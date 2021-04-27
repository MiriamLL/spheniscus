
# spheniscus 🐧

El objetivo de este paquete es  
- Hacer disponibles datos crudos de TDR para que se familiaricen con el
formato  
- Ayudarte a limpiar esos datos crudos para obtener parametros de buceo

The goal of spheniscus is to  
- Provide TDR raw data from devices to get familiar with the format  
- Clean raw data to obtain diving parameters

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

### TDR\_raw 📥

Agrega los datos crudos como objeto. <br> Includes raw data as object.

``` r
TDR_raw<-TDR_raw
```

Las columnas no estan separadas porque primero hay que cortar partes del
archivo. <br> Loads raw data. Columns are not separated on purpose.

### TDR\_dives 🤿

Incluye todos los buceos durante el viaje. <br> Includes all dives
during the foraging trip.

``` r
TDR_dives<-TDR_dives
```

## Functions

### extract\_rawdata 🧹

Extrae la información de presión de los datos crudos de los
dispositivos. <br> En mis dispositivos la presión se empieza a medir
después de ‘Data Block 1’ y termina de medir presión cuando empieza
‘Data Block 2’, por eso use estos separadores en row\_start y
row\_end.<br>

Extracts pressure data.<br> In my devices the pressure starts to be
recorded after the row ‘Data Block 1’ and the last recording is just
before ‘Data Block 2’, that the reason to use those names in row\_start
and row\_end.<br>

``` r
TDR_pressure<-extract_pressure(data=TDR_raw, 
                          row_start='Data Block 1', 
                          row_end = 'Data Block 2')
```

### extract\_trip ✂️

Corta periodos de tiempo de acuerdo a nuestro interés. <br> La
información se obtuvo de dispositivos GPS, trip\_start es cuando
salieron de la colonia y trip\_end cuando regresaron.

Cuts data to have only periods of interest. <br> This information was
obtain from the GPS devices, trip\_start is when the individual left the
colony and trip\_end when it returned.

``` r
TDR_trip<-extract_trip(data=TDR_pressure,
                   timeformat="%d-%m-%Y %H:%M:%S",
                   trip_start="30-11-2018 20:43:24",
                   trip_end="01-12-2018 20:16:19")
```

### plot\_depth 🎨

Crea un grafico con el perfil de buceos. Marca el cero con una linea
roja. <br> Creates a plot with the diving profile. Adds a red line for
the zero.

``` r
plot_depth(TDR_trip = TDR_trip,
                   depth_column='Pressure',
                   time_column='daytime')
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />

## correct\_zero 📐

Correr funcion, si hay que corregir el cero incluir factor de corrección
aquí. <br> En el ejemplo corregí el cero usando -0.80 m. Esto tiene que
ser adjustado de manera manual.

Run function, this is to correct zeros, if manual correction is needed.
<br> In the example below I corrected the zero using -0.80 m. This is to
be adjusted accordingly.

``` r
TDR_corrected<-correct_zero(TDR_trip = TDR_trip,
             depth_column='Pressure',
             extra_correction=-0.80)
```

``` r
plot_depth(TDR_trip = TDR_corrected,
            depth_column='corrected_depth',
            time_column='daytime')
```

<img src="man/figures/README-unnamed-chunk-9-1.png" width="100%" />

## identify\_dives 🐟

Esta función lidentifica los buceos reales, es decir cuando bucean más
profundo de 3 metros. <br> Identifica cada buceo como unidades
individuales, y les asigna a cada inmersión un numero, una profundidad
media de buceo, una profundidad maxima de buceo, una duración media de
buceo y una duración maxima de buceo.

This functions identify real dives, this is when the individual was
deeper than 3 m from the surface. <br> Then identifies every dive as a
individual dive assigning a number, a mean diving depth, a maximum
diving depth, a dive duration, a maximum dive duration.

``` r
TDR_dives<-identify_dives(TDR_corrected=TDR_corrected,
               real_dives=3,
               depth_column='corrected_depth')
```

## dive\_parameters 🤿

Esta función calcula los parametros del viaje completo. Incluye:  
- promedio de la profundidad maxima de buceo,  
- desviacion estandar de la profundidad maxima de bcueo,  
- el maximo de profundidad, la duracion promedio de los buceos,  
- la desviacion estandar de la duracion de los buceos, y  
- la duracion maxima de buceo, asi como  
- el total de buceos durante el viaje.  
**Nota** La profundidad de buceo se da en metros, la duración en
segundos.

This function calculates the dive parameters from the foraging trip. It
includes:  
- average maximum depth  
- standard deviation of the maximum depth  
- maximum depth during the trip  
- average dive duration  
- standard deviation of dive duration  
- maximum dive duration  
- total number of dives  
**Note** Diving depths are in meters, duration is in seconds

``` r
dive_parameters<-calculate_diveparams(TDR_dives)
```

# Citation

Este script acompaña una publicacion en pingüinos por Lerma et al. (en
preparacion) This script is supporting information from a publication by
Lerma et al. (in preparation)

Please citate the package as: Lerma, M (2021). Package spheniscus
(Version v1.0). Zenodo. <http://doi.org/10.5281/zenodo.4709837>

[![DOI](https://zenodo.org/badge/360213200.svg)](https://zenodo.org/badge/latestdoi/360213200)
