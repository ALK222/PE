#' @author Alejandro Barrachina Argudo
#' @author Jaime Benedí Galdeano
#' @description Práctica de la asignatura PE del curso 2021-2022


# Librerias
library(dplyr)
library(ggplot2)
library(gridExtra)

options(OutDec = ",")


# Funciones que usaremos a lo largo del documento
calculo_moda <- function(data) {
    trimmed_data <- data %>%
        group_by(Causa) %>%
        summarise(total = sum(as.numeric(Total)))

    return(subset(trimmed_data, total == max(trimmed_data$total))) # nolint
}

diagrama_barras <- function(data_set) {
    moda <- filter(data_set, Causa == men_moda$Causa) # nolint
    p <- ggplot(moda, aes(x = Edad, y = as.numeric(Total))) +
        geom_bar(stat = "identity")
    p + coord_flip() # nolint
}

# Asumiremos un 95% de confianza
z_alfa_medio <- 1.96

# Análisis de una variable
data <- read.csv2(
    file = "../../resources/49075bsc.csv",
    header = TRUE,
)

names(data) <- c("Causa", "Sexo", "Edad", "Periodo", "Total")

## Media

men_data <- subset(data, Sexo == "Hombres")

men_media <- mean(as.numeric(men_data$Total))

message("Media hombres: ", men_media)

women_data <- subset(data, Sexo == "Mujeres")

women_media <- mean(as.numeric(women_data$Total))

message("Media mujeres: ", women_media)

## Moda
men_moda <- calculo_moda(men_data)

message("Causa más recurrente en hombres: ", men_moda$Causa)

women_moda <- calculo_moda(women_data)

message("Causa más recurrente en mujeres: ", women_moda$Causa)

## Desviación típica

men_sd <- sd(as.numeric(men_data$Total))

message("Desviación típica en datos de hombres: ", men_sd)

women_sd <- sd(as.numeric(women_data$Total))

message("Desviación típica en datos de mujeres: ", women_sd)

## Error estandar

men_se <- men_sd / sqrt(length(men_data$Total))

message("Error estandar en datos de hombres: ", men_se)

women_se <- women_sd / sqrt(length(women_data$Total))

message("Error estandar en datos de mujeres: ", women_se)

## Gráficos
## Dado el gran número de datos, nos centraremos en la medida que más defunciones acumula # nolint
diagrama_barras(men_data)

diagrama_barras(women_data)


## Límite inferior y superior

limite_superior_hombres <- men_media + (z_alfa_medio * men_se)

message("Límite superior en hombres: ", limite_superior_hombres)

limite_superior_mujeres <- women_media + (z_alfa_medio * women_se)

message("Limite superior en mujeres: ", limite_superior_mujeres)

limite_inferior_hombres <- men_media - (z_alfa_medio * men_se)

message("Límite inferior en hombres: ", limite_inferior_hombres)

limite_inferior_mujeres <- women_media - (z_alfa_medio * women_se)

message("Limite inferior en mujeres: ", limite_inferior_mujeres)

intervalo_men <- data.frame(length(men_data$Total), men_media, men_sd, z_alfa_medio, men_se, limite_inferior_hombres, limite_superior_hombres) # nolint
names(intervalo_men) <- c("Tamaño de la muestra", "Media", "Desviación estandar", "Z Alfa /2", "Error estandar", "Límite inferior", "Límite superior") # nolint
intervalo_men

intervalo_women <- data.frame(length(women_data$Total), women_media, women_sd, z_alfa_medio, women_se, limite_inferior_mujeres, limite_superior_mujeres) # nolint
names(intervalo_women) <- c("Tamaño de la muestra", "Media", "Desviación estandar", "Z Alfa /2", "Error estandar", "Límite inferior", "Límite superior") # nolint
intervalo_women


# Contraste de hipótesis

# Para este contraste de hipótesis vamos a suponer una campaña que quiere hacer
# frente a hábitos que reduzcan las tasa de fallecidos en hombres. En un primer
# momento se decide que se hará con aquellas causas que acumulen mas de 10000
# muertes al año. Para ver si esto es suficiente vamosa a usar el siguiente
# contraste:

# Hipótesis nula -> H0 : mu >= mu0
# Hipótesis alternativa -> H1 : mu < mu0

# Nivel de significación del 5%
z_alfa <- 2.49

mu_sub_cero <- 10000

# Calculamos la parte derecha
right_part <- z_alfa * (men_sd / sqrt(length(men_data$Total)))

if (men_media < mu_sub_cero - right_part) {
    message("Se rechaza la hipótesis, por lo tanto se debería bajar el número de afectados para que sea más efectiva la campaña") # nolint
} else {
    message("Se acepta la hipótesis nula, por lo tanto la campaña puede ser efectiva") # nolint
}


# Haremos otra hipótesis para una supuesta campaña enfocada en este caso al
# sector femenino de la población. Utilizaremos una metodología distinta.

# Hipótesis nula -> H0 : sigma >= sigma0
# Hipótesis alternativa -> H1 : sigma < sigma0

# En este caso usaremos 20 grados de libertad y un nivel de significación del 5%

sigma_cero <- 10000

# Sacamos el valor de la tabla
ji_cuadrado <- 39.572

cuasivarianza <- var(as.numeric(women_data$Total))

left_part <- ((length(women_data$Total) - 1) * cuasivarianza) / (sigma_cero^2)

if (left_part > ji_cuadrado) {
    message("Se rechaza la hipótesis, por lo tanto se debería bajar el número de afectados para que sea más efectiva la campaña") # nolint
} else {
    message("Se acepta la hipótesis nula, por lo tanto la campaña puede ser efectiva") # nolint
}
