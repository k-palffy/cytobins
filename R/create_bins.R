create_bins <- function(ll,ul,numbin) {
  boundaries <- seq(from = ll, to = ul, length.out = (numbin+1))
  bin.matrix <- matrix(data = c(boundaries[1:numbin],boundaries[-1]),
                       nrow = numbin, ncol = 2, byrow = F)
  return(bin.matrix)
}
