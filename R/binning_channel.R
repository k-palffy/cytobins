binning_channel <- function(channel_vec, bins) {
  tot_counter <- 1
  bincounter <- 1
  bin_index <- vector(length = length(channel_vec))
  while(tot.counter <= length(channel_vec)) {
    while(channel_vec[tot_counter] < bins[bincounter,2]) {
      bin_index[tot_counter] <- bincounter
      tot_counter <- tot_counter + 1
      if(tot_counter > length(channel_vec)) {
        break
      }
    }
    bincounter <- bincounter +1
  }
  return(bin_index)
}
