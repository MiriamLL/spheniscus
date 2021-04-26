
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

No separe columnas porque primero hay que cortar partes del archivo.
Load your raw data. Columns are not separated on purpose.

### TDR\_pressure

Agrega los datos editados como objeto. <br> Includes edited data as
object.

``` r
TDR_pressure<-TDR_pressure
```

## Functions

### extract\_rawdata

Extrae la información de presión de los datos crudos de los
dispositivos. <br> Extracts pressure data.

Localizar donde aparece por primera vez ‘Data Block 1’, porque es donde
empieza a medir la presion y usar esta fila para separar la presion y la
temperatura (empieza donde dice ‘Data Block 2’). This funcion identifies
where does ‘Data Block 1’ occurs, and is there where the devices start
measuring pressure. I use this row to separate pression and temperature
recordings (temperature starts where it states ‘Data Block 2’).

Se toma unos minutos. Porfavor espera. Takes some seconds. Please wait.

``` r
TDR_pressure<-extract_pressure(data=TDR_raw, 
                          row_start='Data Block 1', 
                          row_end = 'Data Block 2')
```

### extract\_trip

Corta periodos de tiempo de acuerdo a nuestro interés. <br> Cuts data to
have only periods of interest.

Se toma unos minutos. Porfavor espera. Takes some seconds. Please wait.

``` r
TDR_trip<-extract_trip(data=TDR_pressure,
                   timeformat="%d-%m-%Y %H:%M:%S",
                   trip_start="30-11-2018 20:43:24",
                   trip_end="01-12-2018 20:16:19")
```

Esta informacion se obtuvo de dispositivos GPS, trip\_start es cuando
salieron de la colonia y trip\_end cuando regresaron. This information
was obtain from the GPS devices, trip\_start is when the individual left
the colony and trip\_end when it returned.

### plot\_depth

Crea un grafico con el perfil de buceos. Marca el cero con una linea
roja. <br> Creates a plot with the diving profile. Adds a red line for
the zero.

``` r
plot_depth(TDR_trip = TDR_trip,
                   depth_column='Pressure',
                   time_column='daytime')
```

## correct\_zero

Correr funcion, si hay que corregir el cero incluir factor de correccion
aqui. Run function, this is to correct ceros, if manual correction is
needed only.

## identify\_dives

Esta funcion lo que hace es que identifica los buceos reales, es decir
cuando bucean mas profundo de 3 metros. Identifica cada buceo como
unidades individuales, y les asigna a cada inmersion, un numero, una
profundidad media de buceo, una profundidad maxima de buceo, una
duracion media de buceo y una duracion maxima de buceo.

This functions identify real dives, this is when the individual was
deeper than 3 m from the surface. Then identifies every dive as a
individual dive assigning a number, a mean diving depth, a maximum
diving depth, a dive duration, a maximum dive duration.

## dive\_parameters

# Citation

Este script acompaña una publicacion en pingüinos por Lerma et al. (en
preparacion) This script is supporting information from a publication by
Lerma et al. (in preparation)

Please citate the package as: Lerma, M (2021). Package spheniscus
(Version v1.0). Zenodo. <http://doi.org/10.5281/zenodo.4709837>

[![DOI](https://zenodo.org/badge/360213200.svg)](https://zenodo.org/badge/latestdoi/360213200)
