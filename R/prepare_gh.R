prepare_gh <- function(gh, node = "root", channels) {
  gh_matrix     <- exprs(gh_pop_get_data(gh, y = node))[,channels]
  gh_matrix_ext <- as.matrix(data.frame(gh.matrix,
                                    rep(NA, times = nrow(gh.matrix)),
                                    rep(NA, times = nrow(gh.matrix))))
  colnames(gh_matrix_ext)[3:4] <- paste(colnames(gh_matrix),"_bin",sep = "")
  return(gh_matrix_ext)
}
