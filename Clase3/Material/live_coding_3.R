#------------------------------------------------------------------------------#
#           Recuperación y análisis de texto con R                             # 
#                  Educación Permanente FCS                                    #
#                         Clase 3                                              # 
#                      Live coding                                             #
#------------------------------------------------------------------------------#





## 4. Google Trends ----


library(gtrendsR)
library(ggplot2)
library(ggrepel)
library(tmap)
library(dplyr)


##Búaqueda de último mes sobre Agua

query=gtrends(keyword = c("agua"),time = "today 1-m",geo = "UY")


##Análisis de evolución de búsquedas por keyword

agua <- query$interest_over_time
agua %>% 
  ggplot(aes(x = date,
             y = hits,group=keyword,
             color = keyword))  +
  theme_bw()+
  labs(title = "Búsquedas de 'Agua' en último mes",
       x= NULL, y = "Interest")+
  theme(legend.position = "none") +
  geom_point(size=1,color="black")+
  geom_line(size=1,color="black")

#Análisis de búsquedas más relacionadas con keyword

queries_relacionadas = query$related_queries

topics = query$related_topics
query$related_queries %>%
  filter(related_queries=="top") %>%
  mutate(value=factor(value,levels=rev(as.character(value))),
         subject=as.numeric(subject)) %>%
  top_n(20,value) %>%
  ggplot(aes(x=value,y=subject,fill="red")) + 
  geom_bar(stat='identity',show.legend = F) + 
  coord_flip() + labs(title="Búsquedas más relacionadas con 'Agua' en último mes")+
  theme_bw()+
  theme(axis.title= element_blank())



#Comparación de búsquedas en período de tiempo determinado para todos los países


query=gtrends(keyword = c("sub 20"),time = "now 7-d")


paises=query$interest_by_country
paises$hits=as.numeric(paises$hits)



paisescoord <- spData::world %>%
  left_join(y=paises,by = c("name_long" = "location"),keep=T)


mapa=tm_shape(paisescoord) +
  tm_fill("hits",
          title = "Búsquedas por países",
          legend.reverse = T,
          id = "name_long")




#### EJERCICIOS ----

# - Realizar una búsqueda de interés general para el último mes y una para el último año. Graficar


## 5. Audio ----

#### audio whisper ----
# Recuperación de texto a partir de audio

library(av) # conversor a .wav
library(audio.whisper) # transcpción
library(tidyverse) # manipulacion

# 1. OBTENGO UN ARCHIVO DE AUDIO
# descargo para el ejemplo un audio de la web (podría ser un archivo que ya tengo en mi pc)
download.file("https://medios.presidencia.gub.uy/tav_portal/2018/noticias/AD_103/vazquez-cuidados.mp3", # url del audio
              "cuidados.mp3", # nombre del archivo que quedará en mi pc
              mode="wb") # modo web

# 2. CONVERSIÓN (av)
# convierto a .wav 
av_audio_convert("cuidados.mp3", # nombre del archivo en mi pc
                 output = "cuidados.wav", # nombre que va a tener el nuevo archivo convertido a wav
                 format = "wav", sample_rate = 16000) # formato

# 3. TRANSCRIPCIÓN (audio.whisper)

# Descargo el modelo 
# (podría saltear este paso poniendo la ruta en la función predict())
model <- whisper("tiny") # descargo modelo liviano 

# lo corro indicando el idioma (es multilingual)
transcript <- predict(model, newdata = "cuidados.wav", language = "es") # modelo, audio, lenguaje

# extraigo el df donde está el texto transcripto
texto_df <- transcript$data # df tiene 4 cols segmento, inicio, fin, texto 

# para tener todo el texto en un string, colapso la columna text usando paste
texto_vec <- paste(texto_df$text,collapse="")

# hago una tabla para visualizar 
tabla1 <- knitr::kable(texto_vec,
                       col.names = "Tabaré Vázquez - Sistema de Cuidados", # agrego el nombre a la columna de la tabla
                       format = "html", table.attr = "style='width:100%;'") %>% #formato
  kableExtra::kable_styling(font_size = 24) %>% # defino tamaño de letra
  kableExtra::kable_classic() # defino el estilo de la tabla

tabla1 # imprimo la tabla

#### EJERCICIOS ----


# - Recuperar y transcribir en modelo tiny un audio breve (menos de 3 minutos) de https://www.gub.uy/presidencia/comunicacion/audios/breves  

## 6. YouTube ----

library(youtubecaption)

# hadley wickham
url <- "https://www.youtube.com/watch?v=cpbtcsGE0OA"
caption <- get_caption(url)

# suarez
url2 <- "https://www.youtube.com/watch?v=KsE8a9NOtnU"
caption2 <- get_caption(url2, language = "es")

# agarrate catalina
url3 <- "https://www.youtube.com/watch?v=LApsPiejZLI"
caption3 <- get_caption(url3, language = "es")

#### youtubecaption ----

# - Recuperar el texto de los subtítulos de un video corto de YouTube








