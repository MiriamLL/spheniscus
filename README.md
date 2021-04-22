
# spheniscus 🐧

El objetivo de este paquete es  
- Hacer disponibles datos crudos de TDR para que se familiaricen con el
formato  
- Ayudarte a limpiar esos datos crudos para obtener medidas de presión  
- Cortar periodos de interés en nuestros datos

The goal of spheniscus is to  
- Provide TDR raw data from devices to get familiar with the format  
- Clean raw data to obtain pressure measurements  
- Cut periods of time of interest

## Installation

El paquete estará disponible solo por GitHub <br> This package is to be
only on the development version from [GitHub](https://github.com/).

``` r
install.packages("devtools")
devtools::install_github("MiriamLL/spheniscus")
```

``` r
library(spheniscus)
```

## Data

### TDR\_raw

Agrega los datos crudos como objeto. <br> Includes raw data as object.

``` r
TDR_raw<-TDR_raw
```

### TDR\_pressure

Agrega los datos editados como objeto. <br> Includes edited data as
object.

``` r
TDR_pressure<-TDR_pressure
```

## Functions

### cut\_rawdata

Extrae la información de presión de los datos crudos de los
dispositivos. <br> Extracts pressure data.

``` r
TDR_pressure<-cut_rawdata(data=TDR_raw, 
                          row_start='Data Block 1', 
                          row_end = 'Data Block 2')
```

### cut\_trip

Corta periodos de tiempo de acuerdo a nuestro interés. <br> Cuts data to
have only periods of interest.

``` r
TDR_trip<-cut_trip(data=TDR_pressure,
                   timeformat="%d-%m-%Y %H:%M:%S",
                   trip_start="30-11-2018 20:43:24",
                   trip_end="01-12-2018 20:16:19")
```

# Citation

Please citate as: Lerma, M (2021). Package spheniscus (Version v1.0).
Zenodo. <http://doi.org/10.5281/zenodo.4709837>

[![DOI](https://zenodo.org/badge/360213200.svg)](https://zenodo.org/badge/latestdoi/360213200)
