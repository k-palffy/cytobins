#' Binning flow cytometric data
#'
#' @param gh a GatingHierarchy object.
#' @param node name of the node (gate).
#' @param channels number of the channels (columns) in the cytometric data matrix, a vector with 2 elements.
#' @param xlimits lower and upper limits of the 1st channel, a vector with 2 elements.
#' @param ylimits lower and upper limits of the 2nd channel, a vector with 2 elements.
#' @param binnumber number of bins (compartments) to be created along the channel axes.
#' @param vectorize logical indicating whether the resulting binning matrix should be converted into a vector for easier comparison with other GatingHierarchy objects.
#'
#' @return A binning matrix and (optionally) its vectorized form.
#' @export
#'
#' @examples
cyto_binning <- function(gh, node = "root", channels, xlimits, ylimits, binnumber, vectorize = TRUE) {

  xbins       <- create_bins(xlimits[1], xlimits[2], binnumber)
  ybins       <- create_bins(ylimits[1], ylimits[2], binnumber)

  gh_temp     <- prepare_gh(gh, node, channels)
  gh_temp     <- gh.temp[order(gh.temp[,1]),]
  gh_temp[,3] <- binning_channel(gh.temp[,1], xbins)
  gh_temp     <- gh.temp[order(gh.temp[,2]),]
  gh_temp[,4] <- binning_channel(gh.temp[,2], ybins)
  gh_temp     <- gh.temp[order(gh.temp[,3],gh.temp[,4]),]
  bin_indices <- gh.temp[,3:4]

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
