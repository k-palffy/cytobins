del_empty <- function(x) {
  col_total <- colSums(x)
  non_zeros <- which(col_total != 0)
  return(x[,non_zeros])
}
