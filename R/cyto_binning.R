#' Flow cytometric data binning
#'
#' Divide the data ranges of two selected channels of a flow cytometric data set (a GatingHierarchy object) into `n` categories.
#' The process results in a matrix with `n` x `n` compartments (bins) in the space defined by the selected channels,
#' assigning each detected cell/event to a specific bin according to its relevant channel signals.
#'
#' @param gh a GatingHierarchy object.
#' @param node name of the node (gate).
#' @param channels index of two channels (columns) in the cytometric data matrix, a vector with 2 elements.
#' @param xlimits lower and upper limits of the 1st channel, a vector with 2 elements. Must be at least as low/high as the minimun/maximum value within the channel node.
#' @param ylimits lower and upper limits of the 2nd channel, a vector with 2 elements. Must be at least as low/high as the minimun/maximum value within the channel node.
#' @param binnumber number of bins (compartments) to be created along the channel axes.
#' @param vectorize logical indicating whether the resulting binning matrix should be converted into a vector for easier comparison with other GatingHierarchy objects.
#'
#' @return A binning matrix and (optionally) its vectorized form. In the case of both, a list with the matrix as the first and the vector as the second element.
#' @export
#'
#' @examples
#' library(flowCore)
#' library(flowWorkspace)
#'
#' # loading flow cytometric data of a phytoplankton sample as a GatingSet object
#' phyto_gs   <- load_gs(path = system.file("extdata", "phyto_flowcyt_sample", package = "cytobins"))
#' # creating a separate GatingHierarchy object
#' phyto_gh   <- phyto_gs[[1]]
#'
#' # data binning along the axes of channels FSC and FL3, with 64x64 bins
#' # performed on a gated population ("chl") of phyto_gh
#' phyto_bins <- cyto_binning(gh = phyto_gh, node = "chl", channels = c(1,9),
#'                            xlimits = c(3,6), ylimits = c(3,7), binnumber = 64)
#' # the generated binning matrix
#' phyto_bins[[1]]
#' # the generated binning vector
#' phyto_bins[[2]]
cyto_binning <- function(gh, node = "root", channels, xlimits, ylimits, binnumber, vectorize = TRUE) {

  xbins       <- create_bins(xlimits[1], xlimits[2], binnumber)
  ybins       <- create_bins(ylimits[1], ylimits[2], binnumber)

  gh_temp     <- prepare_gh(gh, prepnode = node, channel = channels)
  gh_temp     <- gh_temp[order(gh_temp[,1]),]
  gh_temp[,3] <- binning_channel(gh_temp[,1], xbins)
  gh_temp     <- gh_temp[order(gh_temp[,2]),]
  gh_temp[,4] <- binning_channel(gh_temp[,2], ybins)
  gh_temp     <- gh_temp[order(gh_temp[,3],gh_temp[,4]),]
  bin_indices <- gh_temp[,3:4]

  bin_filled  <- bin_matrix(bin_indices, nrow(xbins), nrow(ybins))

  if(vectorize == TRUE) {
    bin_vector   <- NULL
    for(k in 1:nrow(bin_filled)) {
      bin_vector <- c(bin_vector, bin_filled[k,])
    }
    binlist      <- list(bin_filled, bin_vector)
    return(binlist)
  }

  return(bin_filled)

}

binning_channel <- function(channel_vec, bins) {
  tot_counter  <- 1
  bincounter   <- 1
  bin_index    <- vector(length = length(channel_vec))
  while(tot_counter <= length(channel_vec)) {
    while(channel_vec[tot_counter] < bins[bincounter,2]) {
      bin_index[tot_counter] <- bincounter
      tot_counter <- tot_counter + 1
      if(tot_counter > length(channel_vec)) {
        break
      }
    }
    bincounter <- bincounter + 1
  }
  return(bin_index)
}

bin_matrix <- function(x, numbin1, numbin2) {
  temp_matrix <- matrix(data = 0, nrow = numbin1, ncol = numbin2)
  for(i in 1:numbin1) {
    temp_vector <- x[x[,1] == i,2]
    bin_counts  <- tapply(temp_vector, as.factor(temp_vector), FUN = length)
    temp_matrix[i,as.numeric(names(bin_counts))] <- bin_counts
  }
  return(temp_matrix)
}

