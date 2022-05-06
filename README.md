# PE

Práctica en R para la asignatura Probabilidad y estadística de la UCM (Ingeniería informática).

## Estructura

- [src](./src): incluye el código para realizar el estudio
- [resources](./resources/): incluye el fichero de datos usado sacado del [INE](https://www.ine.es/jaxiT3/Tabla.htm?t=49075)
- [docs](./docs/): nota de prensa haciendo una pequeña explicación del estudio

## Compilación

Para funcions.R solo necesitas una instalación de R y ejecutar o bien `R` o bien `rscript`. Son necesarias las librerias `ggplot2` y `dplyr`.

Para generar la documentación necesitaras las librerías `knitr`. Ejecuta `make` y el makefile se encargará del resto.
