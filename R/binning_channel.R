binning_channel <- function(channel_vec, bins) {
  tot.counter <- 1
  bincounter <- 1
  bin.index <- vector(length = length(channel_vec))
  while(tot.counter <= length(channel_vec)) {
    while(channel_vec[tot.counter] < bins[bincounter,2]) {
      bin.index[tot.counter] <- bincounter
      tot.counter <- tot.counter +1
      if(tot.counter > length(channel_vec)) {
        break
      }
    }
    bincounter <- bincounter +1
  }
  return(bin.index)
}
