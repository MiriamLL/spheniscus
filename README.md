
# spheniscus

The goal of spheniscus is to provide you with TDR raw data so you can
clean it directly from device to R

## Installation

This package is to be only on the development version from
[GitHub](https://github.com/).

``` r
install.packages("devtools")
devtools::install_github("MiriamLL/spheniscus")
```

## Raw data

``` r
library(spheniscus)
```

``` r
head(TDR_raw)
#>                            Data for Tag A13269
#> 1  File created using G5 Host version V7.0.1.0
#> 2                    Comment :- 05-12-2018 PH2
#> 3 The following data are the ID block contents
#> 4                        **** Tag Details ****
#> 5                          Firmware Version No
#> 6                         Firmware Build Level
```
