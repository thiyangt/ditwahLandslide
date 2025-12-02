
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ditwahLandslide

This package provides curated early-warning data on landslides in Sri
Lanka during the Ditwah storm, scraped from the Disaster Management
Centre, Sri Lanka. It includes a structured, machine-readable,
analysis-ready tidy dataset designed to support statistical workflows,
education, and research.

<!-- badges: start -->

<!-- badges: end -->

![](https://github.com/thiyangt/ditwahLandslide/blob/main/data-raw/flyr.png?raw=true)

## Installation

You can install the development version of ditwahLandslide from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("thiyangt/ditwahLandslide")
```

## Example

``` r
library(ditwahLandslide)
head(ditwah_landslides_warnings)
#>   ID_DataAnalyst Report_Date Report_Time              Message_ID
#> 1           NGSM  2025-11-20       16:00 LEWM-20-11-2025-1600-03
#> 2           NGSM  2025-11-20       16:00 LEWM-20-11-2025-1600-03
#> 3           NGSM  2025-11-20       16:00 LEWM-20-11-2025-1600-03
#> 4           NGSM  2025-11-20       16:00 LEWM-20-11-2025-1600-03
#> 5           NGSM  2025-11-20       16:00 LEWM-20-11-2025-1600-03
#> 6           NGSM  2025-11-20       16:00 LEWM-20-11-2025-1600-03
#>   Valid_From_Date Valid_From_Time Valid_To_Date Valid_To_Time District
#> 1      2025-11-20           16:00    2025-11-21         16:00  Badulla
#> 2      2025-11-20           16:00    2025-11-21         16:00  Badulla
#> 3      2025-11-20           16:00    2025-11-21         16:00  Badulla
#> 4      2025-11-20           16:00    2025-11-21         16:00  Badulla
#> 5      2025-11-20           16:00    2025-11-21         16:00  Badulla
#> 6      2025-11-20           16:00    2025-11-21         16:00 Kalutara
#>         Location Level State
#> 1    Bandarawela     1    NA
#> 2      Haputhale     1    NA
#> 3 Uva Paranagama     1    NA
#> 4    Kandaketiya     1    NA
#> 5    Haldummulla     1    -1
#> 6      Mathugama     1    -1
```
