# Librerias
library(dplyr)
library(ggplot2)
library(gridExtra)

# Opciones
options(OutDec = ",")

# Análisis de una variable
data <- read.csv2("../../resources/49075bsc.csv",
    header = FALSE
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

men_trimmed_data <- men_data %>%
    group_by(Causa) %>%
    summarise(total = sum(as.numeric(Total)))

men_trimmed_data


men_moda <- subset(men_trimmed_data, total == max(men_trimmed_data$total))

message("Causa más recurrente en hombres: ", men_moda$Causa)

women_trimmed_data <- women_data %>%
    group_by(Causa) %>%
    summarise(total = sum(as.numeric(Total)))

women_moda <- subset(women_trimmed_data, total == max(women_trimmed_data$total))

message("Causa más recurrente en mujeres: ", women_moda$Causa)

## Desviación típica

men_sd <- sd(as.numeric(men_data$Total))

message("Desviación típica en datos de hombres: ", men_sd)

women_sd <- sd(as.numeric(women_data$Total))

message("Desviación típica en datos de mujeres: ", women_sd)

## Error estandar

men_se <- men_sd / sqrt(length(men_data))

message("Error estandar en datos de hombres: ", men_se)

women_se <- women_sd / sqrt(length(women_data))

message("Error estandar en datos de mujeres: ", women_se)

## Gráficos
## Dado el gran número de datos, nos centraremos en la medida que más defunciones acumula # nolint
men_moda_data <- filter(men_data, Causa == "053-061 IXEnfermedades del sistema circulatorio")
p <- ggplot(men_moda_data, aes(x = Edad, y = as.numeric(Total))) +
    geom_bar(stat = "identity")
p + coord_flip()

women_moda_data <- filter(women_data, Causa == "053-061 IXEnfermedades del sistema circulatorio")
p <- ggplot(women_moda_data, aes(x = Edad, y = as.numeric(Total))) +
    geom_bar(stat = "identity")
p + coord_flip()
