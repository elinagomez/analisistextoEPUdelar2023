


# Clase 1
# Solución ejercicios

#_Construcción y guardado de objetos:_

dias <- c("lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo")



curso <- c(1,0,1,0,0,0,0)



datos <- cbind(dias, curso)


datos_df <- as.data.frame(datos)



##veo la dimensiones
dim(datos_df)

nrow(datos_df)
ncol(datos_df)
#nombres de columnas
names(datos_df)[2]
#hago una tabla 
table(datos_df$curso,datos_df$dias)

datos_df[2,1]


### seteo el directorio de trabajo
setwd("C:/Users/Usuario/Desktop/") ##agregar la ruta


write.csv(datos_df, "datos.csv")


install.packages("remotes")

remotes::install_github("Nicolas-Schmidt/puy")

library(quanteda)



#_Exploración:_

autos = cars


View(autos)

dim(autos)

class(autos$speed)

min(autos$speed)
max(autos$speed)

summary(autos$speed)

is.numeric(autos$speed)



is.character(autos$speed)

autos$speed=as.character(autos$speed)

is.character(autos$speed)



#_Manipulación:_

#==
#!=
#>
#<
#>=
#<=
autos2=subset(autos,autos$dist!=40)

autos3=subset(autos,autos$dist>=20)


autos$speed=as.numeric(autos$speed)##tengo que volver a pasar a numérica para poder sumar

suma = apply(autos,2,sum) ##2 por columna, 1 sería por fila

autos=rbind(autos,suma) # pego al final con rbind

autos$dist_rec=ifelse(autos$dist<20,1,ifelse(autos$dist>=20 & autos$dist<=40,2,
                                             ifelse(autos$dist>=41,3,
                                                    autos$dist)))


#_Presentación:_

table(autos$dist_rec)
barplot(autos$dist_rec)
barplot(table(autos$dist_rec))




##instalar

install.packages("") ##para instalar paquetes

library(dplyr)
library(devtools)

devtools::install_github()


##xlsx::read.xlsx()


###### Agregación de atributos
## Ejercicio con dplyr
## library(dplyr)


##1.Cargar la base word en formato RData
##2. Agregar atributos con base y con dplyr
##3. Imprimir una tabla con los tres continentes más poblados con kable

#load("Clase1/Material/world.Rdata")

load("Clase1/Material/world.Rdata")



#base 

aggregate(pop ~ continent, 
          FUN = sum, 
          data = world, 
          na.rm = TRUE)



#dplyr

library(dplyr)

#suma por grupos


pop_continente = world %>%
group_by(continent) %>%
  summarize(pop = sum(pop, na.rm = TRUE))



##población total

world %>% 
  summarize(pop = sum(pop, na.rm = TRUE),
            n_countries = n())


##los tres continentes más poblados

a = world %>% 
  dplyr::select(pop, continente = continent) %>% 
  group_by(continente) %>% 
  summarize(población = sum(pop, na.rm = TRUE), 
            n_paises = n()) %>% 
  slice_max(n = 3, order_by = n_paises)


##genero una tabla con knitr

world %>% 
  dplyr::select(pop, continente = continent) %>% 
  dplyr::group_by(continente) %>% 
  dplyr::summarize(población = sum(pop, na.rm = TRUE), 
                   n_paises = n()) %>% 
  dplyr::slice_max(n = 3, order_by = población) %>%
  knitr::kable(caption = "Los 3  continentes más poblados, y su número de países.")

a%>% 
knitr::kable(caption = "Los 3  continentes más poblados, y su número de países.")

