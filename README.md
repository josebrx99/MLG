<!-- README.md is generated from README.Rmd. Please edit that file -->

# MLG

<!-- badges: start -->
<!-- badges: end -->


## Instalación

Este paquete esta en su versión de construcción, por tanto se encontrará
alojado en GitHub durante su etapa de elaboración.

### Función supuestos
``` r
install.packages("devtools"); install.packages("MASS"); install.packages("lmtest")
library("devtools")
devtools::install_github("josebrx99/MLG"); library(MLG)
model = lm()
MLG::supuestos(model = model, col = "indianred2")
```
