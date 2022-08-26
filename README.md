
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cytobins

<!-- badges: start -->
<!-- badges: end -->

The goal of the `cytobins` package is to provide a simple tool for
binning flow cytometric data, i.e. to create a data matrix of the cell
counts in user-specified compartments (bins) of the space defined by any
two of the detection channels (FSC, FL1, etc.). In a practical sense,
this means that instead of visualizing the 2D scatter plot of those
channels, the `cytobins` package generates a numerical matrix of
customized size, equivalent of that particular plot, which facilitates
further comparative mathematical analysis of flow cytometric files.

## Installation

You can install the development version of cytobins from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("k-palffy/cytobins")
```

## Usage

This package relies on the data structures defined in the R packages
`flowCore` and `flowWorkspace`, as it uses `GatingHierarchy` objects as
input. The function performing the binning procedure is
`cyto_binning()`, which divides the ranges of two selected channels of a
flow cytometric data set (a `GatingHierarchy` object) into `n`
categories. The process results in a matrix with `n` x `n` compartments
(bins) in the space defined by the selected channels, assigning each
detected cell/event to a specific bin according to its relevant channel
signals.

More info on how to use the `cyto_binning()` function can be found in
its help file.

## Example

``` r
library(flowCore)
library(flowWorkspace)
#> As part of improvements to flowWorkspace, some behavior of
#> GatingSet objects has changed. For details, please read the section
#> titled "The cytoframe and cytoset classes" in the package vignette:
#> 
#>   vignette("flowWorkspace-Introduction", "flowWorkspace")
library(cytobins)

# loading flow cytometric data of a phytoplankton sample as a GatingSet object
phyto_gs   <- load_gs(path = system.file("extdata", "phyto_flowcyt_sample", package = "cytobins"))
# creating a separate GatingHierarchy object
phyto_gh   <- phyto_gs[[1]]

# data binning along the axes of channels FSC and FL3, with 64x64 bins
# performed on a gated population ("chl") of phyto_gh
phyto_bins <- cyto_binning(gh = phyto_gh, node = "chl", channels = c(1,9),
                            xlimits = c(3,6), ylimits = c(3,7), binnumber = 64)
```
