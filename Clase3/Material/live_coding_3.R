

#librerías generales

library(dplyr)
library(ggplot2)
library(rtweet)

##1. Creamos la App en Twitter Dev
##2. Copiamos el bearer token
##3. Corremos la función rtweet_app() asignada a un objeto
##4. Guardamos con la función auth_save() 
##5. Cada vez cargamos con auth_as() 



library(dplyr)
library(tidyverse)
library(dplyr)

rtweet::create_token()

fa <- search_tweets("@Frente_amplio", n = 100, include_rts = TRUE,retryonratelimit=TRUE)

find_original_user_screen_name <- function(.df) {
  row_original_user_info <- .df[1, 'user'][1, c('name', 'screen_name',  'description', 'followers_count', 'friends_count', 'favourites_count')]
  
  return(row_original_user_info)
}


original_tweet_user_info <- fa$retweeted_status %>%
  map_dfr(find_original_user_screen_name)

fa = cbind(fa,original_tweet_user_info)

stream2 <- tempfile(fileext = ".json")
stream_mvd <- stream_tweets(lookup_coords("montevideo, uy"), timeout = 15, file_name = stream2)


auth=rtweet_app("AAAAAAAAAAAAAAAAAAAAANvGjwEAAAAAKtQtjj3MMfUgvDs205RJfTHwQ8M%3DWrzcDHKX9rDf3zFbb8P5SXNPLXn7HqYuVb5tAHgfETKPtCNZlU")


auth=rtweet_user(api_key = "pi3DtBgdl2i3X8DByWh4gznaO", api_secret = "2OMCMBNmrz8DzXfvroqiLa4dM6YIizRYgSVWLPLtPdpbwcXrJT")


auth_save(auth,"authRCuali") 

auth_sitrep(auth)

##Cargamos las credenciales para conectarnos

auth_as("authRCuali")

#buscamos los tweets que mencionan un determinado usuarix o hashtag 




#retryonratelimit=TRUE

## si quisiera hacer búsquedas conjuntas

#facc <- search_tweets('"frente amplio" OR "carolina cosse"', n = 18000, include_rts = TRUE,retryonratelimit=TRUE)


#'"frente amplio"' / OR / AND


load("~/rcuali2022/Clase3/Material/fa.RData")


##graficamos usando la función ts_plot para series de tiempo en twitter


fa %>%
  ts_plot("5 hours") +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frecuencia de @Frente_Amplio de los últimos 9 días",
    caption = "Recuento de tweets en intervalos de 5 horas"
  )



##Utilizamos las funciones get_followers() para obtener lxs usuarixs y 
#lookup_users para obtener información de lxs mismxs

##Análisis de politicos/as: Carolina Cosse y Yamandu Orsi
##trae 75000 cada 15 minutos

#@CosseCarolina

cc_flw <- get_followers("CosseCarolina",n = Inf,retryonratelimit = TRUE)


cc_flw_data <- lookup_users(cc_flw$from_id) ##trae hasta 90000 seguidores/as


#save(cc_flw_data,file="Clase3/Material/CosseCarolina_2021.RData")

#OrsiYamandu

orsi_flw <- get_followers("OrsiYamandu", n = "all",retryonratelimit=TRUE)

orsi_flw_data <- lookup_users(orsi_flw$from_id)

#save(orsi_flw_data,file="Clase3/Material/OrsiYamandu_2021.RData")


#genero una base por candidata, agrego una variable con el nombre 
#y una de conteo antes de unirlas


load("~/rcuali2022/Clase3/Material/CosseCarolina_2021.RData")
load("~/rcuali2022/Clase3/Material/OrsiYamandu_2021.RData")

cc_flw_data <- cc_flw_data %>%
  mutate(candi="Carolina Cosse",
         cc_c=1)

orsi_flw_data <- orsi_flw_data %>%
  mutate(candi="Yamandú Orsi",
         yam_c=1)


#Pongo todos los data.frames de las candidatas en una lista
bases <- list(cc_flw_data, orsi_flw_data)

#Uno todas las bases y selecciono las variables que me interesan                                    
seguidores<-bind_rows(bases) %>%
  select(user_id, text ,name, screen_name,country, country_code,geo_coords,coords_coords,
         location, followers_count, statuses_count, account_created_at,candi,
         ends_with('_c'))

#seguidores[is.na(seguidores)] = 0



##grafico la cantidad de seguidorxs por cada candidata

#save(seguidores,file="Clase3/Material/seguidores_2021.RData")

load("~/rcuali2022/Clase3/Material/seguidores_2021.RData")

library(RColorBrewer)
require(forcats)

ggplot(seguidores, aes(fct_infreq(candi)))+ geom_bar(fill= c("#FFB5E8","85E3FF")) +
  geom_text(stat='count', aes(label=..count..), vjust=-1)+
   xlab("Politicxs") +
  ylab("Cantidad de seguidorxs")



## Uso y gráfico de get_timelines

serie_cc <- get_timelines(c("CosseCarolina"), n = 3200)
serie_cc$screen_name="CosseCarolina"
serie_lp <- get_timelines(c("LuisLacallePou"), n = 3200)

serie_lp$screen_name="GBianchi404"
serie=rbind(serie_cc,serie_lp)

bianchi=get_timelines(c("gbianchi404"), n = 3200)

#load("~/rcuali2022/Clase3/Material/swriecclp.RData")

bianchi %>%
  mutate(screen_name = "Bianchi") %>%
  dplyr::filter(created_at > "2021-07-01") %>%
  dplyr::group_by(screen_name,created_at) %>%
  summarize(n=n())%>%
  group_by(week = cut(created_at, "week"),screen_name) %>% summarise(value = sum(n))%>%
  ggplot(ggplot2::aes(x = as.Date(week), y = value, group=screen_name,colour=screen_name)) +
  geom_line()+
  ggplot2::geom_point() +
  scale_x_date(date_breaks = "4 month")+
  ggplot2::theme_minimal() +
  ggplot2::theme(
    legend.title = ggplot2::element_blank(),
    legend.position = "bottom",
    plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frecuencia de los estados de Twitter publicados",
    subtitle = "Recuento de estados de Twitter agregados por semana - Julio 2021/Noviembre 2022"
  )

bianchi %>%
  mutate(screen_name = "Bianchi") %>%
  dplyr::filter(created_at > "2021-07-01") %>%
  dplyr::group_by(screen_name,created_at) %>%
  summarize(n=n())%>%
  group_by(day = cut(created_at, "day"),screen_name) %>% summarise(value = sum(n))%>%
  ggplot(ggplot2::aes(x = as.Date(day), y = value, group=screen_name,colour=screen_name)) +
  geom_line()+
  ggplot2::geom_point() +
  #scale_x_date(date_breaks = "4 month")+
  ggplot2::theme_minimal() +
  ggplot2::theme(
    legend.title = ggplot2::element_blank(),
    legend.position = "bottom",
    plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frecuencia de los estados de Twitter publicados",
    subtitle = "Recuento de estados de Twitter agregados por semana - Julio 2021/Noviembre 2022"
  )


##Ejercicio

##1. Hacer una búsqueda de los tweets con una palabra clave, sin incluir re tweets

##2. Realizar un gráfico con serie de tiempo de los últimos con actualización cada un 12 horas

##3. Extraer lxs seguidorxs de una cuenta específica y graficar alguna de sus características





##2. Manipulación de strings

# Usa la función print
print("hello world")

# Determina una variable como un vector de texto
x <- "Woods Hole Research Center"
x

# Consulta el length del vector creado
length(x)

# Cantidad de caracteres
nchar(x)

# Concatena vectores usando "print" y "paste"
x <- "hola mundo, yo soy "
y <- "de"
z <- " Uruguay."

print(paste(x, y, z, sep = ""))

# cortando un vector de texto .
x <- "mi nombre es Elina"
x

substr(x, 14, 20)

# recortando texto por un separador - resulta una lista.
x <- "/Users/elinagomez/Documents/archivo.txt"
z <- strsplit(x, "/")
z
class(z)

# para quedarnos con el tercer elemento de lo recortado.
z[[1]][3]

# O, se puede usar la función "unlist" quedando cada elemento como parte de un vector.
z <- unlist(strsplit(x, "/"))
z
z[3]
class(z)

# Creando el nombre de un nuevo archivo a partir de los archivos existentes.

unlist(strsplit(x, "\\."))
newfile <- paste(unlist(strsplit(x, "\\."))[1], "_nuevo.txt", sep = "")
newfile

# grep

#Crea una variable, messages. Asignando cuatro valores a la variable. 

messages <- c("apple", "pear", "banana", "orange")

codigos$coding=gsub("@","",codigos$coding)


#Usa grep para imprimir los valores en messages que contengan una 'g' 

grep("g", messages, value = TRUE)




##Stringr

library(readtext)
url_texto <- "https://www.ingenieria.unam.mx/dcsyhfi/material_didactico/Literatura_Hispanoamericana_Contemporanea/Autores_B/BENEDETTI/Poemas.pdf"
# Extraemos el texto
mario <- readtext(url_texto)

library(stringr)

mario_sentencias=str_split(mario$text, "\n")%>%
  unlist()%>%
  str_trim("both")

unlist(str_split(mario_sentencias, boundary("sentence")))

##type = c("character", "sentence", "word")

str_c("x", "y", sep = ", ")
#> [1] "x, y"

library(stringr)
#la primer coincidencia
str_replace(string, pattern, replacement) 

#todas las coincidencias
str_replace_all(string, pattern, replacement)


str_to_upper(c("i", "ı"))
#> [1] "I" "I"

str_to_lower(c("I", "I"))
#> [1] "i" "ı"

str_trim(string, side = c("both", "left", "right"))

str_trim(" String with trailing and leading white space ")
#> [1] "String with trailing and leading white space"
str_trim("\n\nString with trailing and leading white space\n\n")
#> [1] "String with trailing and leading white space"


str_squish(" String with trailing, middle,   and leading white space\t")
# #> [1] "String with trailing, middle, and leading white space"









