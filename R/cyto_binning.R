cyto_binning <- function(gh, node = "root", channels, xlimits, ylimits, binnumber) {

  xbins       <- create_bins(xlimits, binnumber)
  ybins       <- create_bins(ylimits, binnumber)

  gh_temp     <- prepare_gh(gh)
  gh_temp     <- gh.temp[order(gh.temp[,1]),]
  gh_temp[,3] <- binning_channel(gh.temp[,1], xbins)
  gh_temp     <- gh.temp[order(gh.temp[,2]),]
  gh_temp[,4] <- binning_channel(gh.temp[,2], ybins)
  gh_temp     <- gh.temp[order(gh.temp[,3],gh.temp[,4]),]
  bin_indices <- gh.temp[,3:4]

  bin_filled  <- bin_matrix(bin_indices, nrow(xbins), nrow(ybins))



}
