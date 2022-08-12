bin_matrix <- function(x, numbin1, numbin2) {
  temp_matrix <- matrix(data = 0, nrow = numbin1, ncol = numbin2)
  for(i in 1:numbin1) {
    temp_vector <- x[x[,1] == i,2]
    bin_counts  <- tapply(temp_vector, as.factor(temp_vector), FUN = length)
    temp_matrix[i,as.numeric(names(bin_counts))] <- bin_counts
  }
  return(temp_matrix)
}
