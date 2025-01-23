#------------------------------------------------------------------------------#
#           Datos no estructurados y semiestructurados                         #
#      Especialización en Ciencia de Datos (Decon/FCS-UdelaR)                  #
#                      Live coding                                             #
#------------------------------------------------------------------------------#

# CLASE 2 - FUENTES DE DATOS ----

## 1. Recuperación de documentos en imagen o pdf (OCR) ----


## Cargamos la librería necesaria:
library(readtext)

##Abro los archivos de la carpeta y visualizo cómo los carga
txt <- readtext::readtext("Clase2/Material/")
##Abro un archivo .txt y visualizo cómo lo carga
txt <- readtext::readtext("Clase2/Material/Mujeres_Adultos_1.txt")
cat(txt$text) # imprimo en consola para visualizar el texto cargado

# reviso el encoding para chequear caracteres incorrectamente leídos
Encoding(txt$text) # consulto el encoding del texto

Encoding(txt$text)="UTF-8" # asigno un encoding y veo si está ok

cat(txt$text) # imprimo en consola para ver si se arreglo el problema

Encoding(txt$text)="latin1" # asigno otro encoding y veo si está ok

cat(txt$text) # imprimo en consola para ver si se arreglo el problema


# Determinamos el pdf con el que trabajar
pdf <- readtext("Clase2/Material/text.pdf")

# Determinamos el pdf en una url con el que trabajar
url <- readtext("https://www.ingenieria.unam.mx/dcsyhfi/material_didactico/Literatura_Hispanoamericana_Contemporanea/Autores_B/BENEDETTI/Poemas.pdf")


#pdftools

library(pdftools)
# Extraemos el texto
pdf_texto <- pdf_text("Clase2/Material/marcha_1973.pdf")


# write.csv
write.csv(pdf_texto,"Clase2/Material/pdf_texto.csv") # guardo el objeto en un archivo csv


##Reconocimiento óptico de caracteres en imagenes

library(tesseract)
##Chequear los idiomas disponibles 
tesseract_info()
# Bajar por unicamente español para entrenar
tesseract_download("spa")
# asignar
espanol <- tesseract("spa")

#Probamos:
transcribopdf <- ocr("C:/Users/elina/OneDrive/Documentos/analisistextoEPUdelar2023/Clase1/Materiales_curso/analesUruguay.pdf", engine = espanol) #  devuelve vector

tabla=ocr_data("C:/Users/elina/OneDrive/Documentos/analisistextoEPUdelar2023/Clase1/Materiales_curso/analesUruguay.pdf",engine = espanol) # devuelve tibble (dataframe)

# unifico el texto en un vector
texto2 <- stringr::str_c(tabla$word, collapse = " ") # colapso los tres elementos del vector separando por un espacio


#### EJERCICIO 1 ----

# Ejercicio 1

## Reconocimiento óptico de caracteres

# 1. Replicar el OCR para la imagen _analesUruguay3_ y __marcha_1973__

# 2. Hacer la tabla de ambas 


# Solucion
 transcribopng <- ocr("C:/Users/elina/OneDrive/Documentos/analisistextoEPUdelar2023/Clase1/Material/marcha_1973.pdf",engine = espanol)
 tablapng=ocr_data("C:/Users/elina/OneDrive/Documentos/analisistextoEPUdelar2023/Clase1/Material/analesUruguay_3.png",engine = espanol)

 marcha <- ocr("C:/Users/elina/OneDrive/Documentos/analisistextoEPUdelar2023/Clase1/Material/marcha_1973.pdf",engine = espanol)
 
#------------------------------------------------------------------------------#

## 2. Scraping web y parlamentario ----

#### Web scraping  ----

library(rvest)
library(dplyr)

#Defino mi sitio html: Montevideo portal
mvdportal = rvest::read_html("https://www.montevideo.com.uy/index.html") # leo todo el contenido html y guardo en un objeto

resumenes = mvdportal %>% 
  html_elements(".text") %>% #defino el elemento que identifiqué con el SelectorGadget
  html_text()%>% # extraigo el texto
  as.data.frame() # convierto la salida en un data frame

#write.csv(resumenes,"Clase2/Material/resumenes.csv")

titulares = mvdportal %>%
  html_elements("a")%>%
  html_text()%>%
  as.data.frame()

#write.csv(titulares,"Material/titulares.csv")


# descargo de tabla html
url <- 'https://es.wikipedia.org/wiki/Anexo:Ríos_de_Uruguay' # identifico url

tabla = url %>% read_html() %>% # aplico la función de leer el contenido html sin guardarla en un objeto
  html_elements(css = '.wikitable') %>% # selecciono un estilo css específico que es el de las tablas
  html_table() %>%
  as.data.frame()# función que convierte la extracción en una tabla de r
## como no asigné este código a ningún objeto, se va a imprimir en la consola


#### EJERCICIO 2 ----

## Scrapeo web con rvest

# 1. Descargar noticias o información de otra web
# 2. Scrapear dos elementos html diferentes 

#------------------------------------------------------------------------------#

#### Scrapeo parlamentario ----
install.packages("remotes")
##Instalar última versión dev de speech desde github 
remotes::install_github("Nicolas-Schmidt/speech")

##Instalar PUY 
remotes::install_github("Nicolas-Schmidt/puy")

library(speech)
library(puy)
##Speech - ejemplo

url <- "https://parlamento.gub.uy/documentosyleyes/documentos/diarios-de-sesion/5515/IMG"

sesion <- speech::speech_build(file = url)

sesion <- speech::speech_build(file = url, compiler = TRUE, quality = TRUE)

#Función completa
sesion <- speech::speech_build(file = url, 
                               #url a pdf
                               compiler = FALSE, 
                               #compila discursos de unx mismx legisladorx
                               quality = TRUE,
                               #aporta dos índices de calidad
                               add.error.sir = c("SEf'IOR"),
                               ##forma errónea que lo que identifica a el/la legisladorx
                               rm.error.leg = c("PRtSIDENTE", "SUB", "PRfSlENTE"))

#agrego partido político
sesion <- puy::add_party(sesion)



#### EJERCICIO 3 ----

# 1. Elegir una sesión parlamentaria
# 2. Aplicar la funcion speech_build 
# 3. Agregar etiqueta partidaria 
# 4. Guardar en formato tabulado 

#------------------------------------------------------------------------------#


## 4. Google Trends ----


library(gtrendsR)
library(ggplot2)
library(ggrepel)
library(tmap)
library(dplyr)


##Búaqueda de último mes sobre Agua

devtools::install_github("PMassicotte/gtrendsR")

library(gtrendsR)
query=gtrends(keyword = c("romina"),time = "today 1-m",geo = "UY")


##Análisis de evolución de búsquedas por keyword

romina <- query$interest_over_time

romina %>% 
  ggplot(aes(x = date,
             y = hits,group=keyword,
             color = keyword))  +
  theme_bw()+
  labs(title = "Búsquedas de 'Romina' en último mes",
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


query=gtrends(keyword = c("luis suarez"),time = "now 7-d",
              onlyInterest = TRUE)


paises=query$interest_by_country
paises$hits=as.numeric(paises$hits)



paisescoord <- spData::world %>%
  left_join(y=paises,by = c("name_long" = "location"),keep=T)


mapa=tm_shape(paisescoord) +
  tm_fill("hits",
          title = "Búsquedas por países",
          legend.reverse = T,
          id = "name_long")




#### EJERCICIO 1 ----

## Búsquedas de google con gtrendsR

# 1. Realizar una búsqueda de interés general para el último mes 
# 2. Realizar una búsqueda de interés general para el último año
# 3. Graficar ambos resultados


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

#### EJERCICIO 2 ----

## Recuperación de texto de audios

# 1. Recuperar y transcribir con modelo tiny un audio breve (menos de 3 minutos)
# 2. Recuperar y transcribir con modelo medium el mismo audio
# 3. Imprimir en consola ambos resultados y comparar los textos 
# Opción de descarga: https://www.gub.uy/presidencia/comunicacion/audios/breves  

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


#### EJERCICIO 3 ----

## Subtítulos de YouTube

# 1. Recuperar el texto de los subtítulos de un video corto de YouTube



# Presentación de quanteda ----

library(speech)
library(quanteda)

# diario de sesion
url <- "https://parlamento.gub.uy/documentosyleyes/documentos/diarios-de-sesion/3339/IMG"

# compilo por legislador/a
sesion <- speech_build(url, compiler = TRUE)

# Alternativa: cargo el diario de sesión compilado desde el repositorio
# load("Material/sesion.Rdata")


## 1. Corpus ----

# creo un corpus con la variable speech
sesion_corpus <- corpus(sesion, text_field = "speech")

# imprimo en pantalla y veo el objeto corpus
print(sesion_corpus)

# veo la estructura imprimiendo los primeros dos elementos
head(summary(sesion_corpus), 2)


## 2. Tokens ----

# tokenizo en palabras
sesion_corpus_toks <- tokens(sesion_corpus, what = "word") # what por defecto es palabras

# tokenizo en oraciones
sesion_corpus_toks3 <- tokens(sesion_corpus, what = "sentence")

# existe la posibiildad de tokenizar en caracteres

# tokenizo en palabras elimino puntuacion
sesion_corpus_toks2 <- tokens(sesion_corpus, what = "word", remove_punct = TRUE) # what por defecto es palabras


## 3. dfm ----

# creo un dfm con el corpus de la sesion tokenizado en palabras
sesion_corpus_toks_dfm <- dfm(sesion_corpus_toks)

# número de documentos (es el mismo número que en corpus y tokens: 57 = cada legislador/a)
ndoc(sesion_corpus_toks_dfm)

# número de caracetrísticas (es algo así como el token o unidad básica de un dfm)
nfeat(sesion_corpus_toks_dfm)

# número de tokens es distinto (devuelve tokens por documento)
ntoken(sesion_corpus_toks_dfm)


# Caso práctico ----


## Limpieza de texto con paquete **quanteda**
## Visualización

#cargo librerías
library(quanteda) 
library(readtext) 
library(stringr)
library(dplyr)
library(ggplot2)
library(quanteda.textstats)
library(quanteda.textplots)


##Cargo la base que intervenciones que vamos a usar

load("intervenciones.RData")

#aplico la función dfm con los argumentos para limpiar el texto e indicar grupos

dfm_intervenciones <- quanteda::dfm(quanteda::tokens(intervenciones$speech,
                                                     remove_punct = TRUE,
                                                     remove_numbers = TRUE),
                                    tolower=TRUE,
                                    verbose = FALSE) %>%
  quanteda::dfm_remove(pattern = c(quanteda::stopwords("spanish"),
                                   tolower(intervenciones$legislator),"presi*"),
                       min_nchar=3)%>%
  quanteda::dfm_trim(min_termfreq = 6)%>%
  #dfm_tfidf()%>% ## puedo ponderar con tf-idf 
  quanteda::dfm_group(groups = intervenciones$party)



sacopalabras= c(quanteda::stopwords("spanish"),tolower(intervenciones$legislator),"presidente")



View(as.data.frame(dfm_intervenciones))


dim(dfm_intervenciones) ##veo dimensiones

topfeatures(dfm_intervenciones,20) ##veo principales palabras


###si quisieramos considerar términos multi palabra, con  tokens_compound y phrase

# tokens_compound(toks, list(c("United", "Kingdom"), c("European", "Union")))
# 
# tokens_compound(toks, phrase(c("United Kingdom", "European Union")))


#Nubes de palabras con quanteda

##Nubes de palabras sin desagregación
quanteda.textplots::textplot_wordcloud(dfm_tfidf(dfm_intervenciones), min.count = 2,max_words = 200,
random.order = TRUE,colors = RColorBrewer::brewer.pal(8,"Dark2"),comparison = F)


##Nubes de palabras por grupos

quanteda.textplots::textplot_wordcloud(dfm_intervenciones, min.count = 2,max_words = 500,
random.order = FALSE,colors = RColorBrewer::brewer.pal(8,"Dark2"),comparison = T)


quanteda::topfeatures(dfm_intervenciones,20)



##Grafico palabras más frecuentes

#creo un objeto con la 20 principales palabras 
top = data.frame(topfeatures(dfm_tfidf(dfm_intervenciones),20))

#las defino como rownames
top$palabra = rownames(top)

#hago el gráfico con ggplot
topplot = top[1:20, ] %>%
  ggplot(aes(x = reorder(palabra, topfeatures.dfm_tfidf.dfm_intervenciones...20.), 
             y = topfeatures.dfm_tfidf.dfm_intervenciones...20., fill = palabra)) + 
  geom_col(show.legend = FALSE) +
  coord_flip() +
  geom_text(aes(hjust = -0.1, label = round(topfeatures.dfm_tfidf.dfm_intervenciones...20.,1))) +
  theme_minimal() +
  theme(axis.title.y = element_blank(), axis.title.x = element_blank(), axis.text = element_text(size = 15)) +
  ggtitle("Palabras más frecuentes (n=20)") +
  scale_fill_manual(values = c(rep("#D7B5D8",20)))



##Asociación de palabras



quanteda.textstats::textstat_simil(dfm_tfidf(dfm_intervenciones),
                                   selection = "reforma",
method = "correlation",margin = "features")%>%
  as.data.frame()%>%
  dplyr::arrange(-correlation)%>%
  dplyr::top_n(15)




## KWIC

kwic = quanteda::kwic(quanteda::tokens(intervenciones$speech,
                                       remove_punct = TRUE,
                                       remove_numbers = TRUE), 
                      pattern = quanteda::phrase(c("ley de urgente consideración")),
                      window = 20)

DT::datatable(kwic)


##Redes de co-ocurrencia

base_fcm= dfm_tfidf(dfm_intervenciones) %>%
  fcm(context = "document")

View(data.frame(base_fcm))

feat <- names(topfeatures(base_fcm, 25))
base_fcm_select <- fcm_select(base_fcm, pattern = feat, selection = "keep")
size <- log(colSums(dfm_select(base_fcm, feat, selection = "keep")))

set.seed(144)
quanteda.textplots::textplot_network(base_fcm_select, min_freq = 0.8, 
                                     vertex_size = size / max(size) * 3,
                                     edge_color="#ff9d5c")




# EJERCICIO 1

# 1. Descargar menciones de un diario de sesión de interés
## 2. Realizar una nube de palabras desagregada por partido
## 3. Encontrar asociaciones de palabras relevantes 
## 4. Armar redes para un partido específico


library(quanteda)
library(stringr)
library(rtweet)
library(dplyr)
library(tidyr)
library(ggplot2)


load("tweets_fa.RData")
load("tweets_pn.RData")

##1. Realizo limpieza inicial de tweets:

##Frente amplio
# sacar URLs
tweets_fa$full_text <- str_replace_all(tweets_fa$full_text, "http[[:alnum;]]*","")
tweets_fa$full_text <- str_replace_all(tweets_fa$full_text, "s://t.co/[[:alnum;]]*","")
# sacar toda referencia a RT
tweets_fa$full_text <- str_replace(tweets_fa$full_text,"RT @[a-z,A-Z]*: ","")
# sacar hashtags
tweets_fa$full_text <- str_replace_all(tweets_fa$full_text,"#[a-z,A-Z]*","")
# sacar referencias a otros screen_names
tweets_fa$full_text <- str_replace_all(tweets_fa$full_text,"@[a-z,A-Z]*","")

##Partido Nacional
# sacar URLs
tweets_pn$full_text <- str_replace_all(tweets_pn$full_text, "http[[:alnum;]]*","")
tweets_pn$full_text <- str_replace_all(tweets_pn$full_text, "s://t.co/[[:alnum;]]*","")

# sacar toda referencia a RT
tweets_pn$full_text <- str_replace(tweets_pn$full_text,"RT @[a-z,A-Z]*: ","")
# sacar hashtags
tweets_pn$full_text <- str_replace_all(tweets_pn$full_text,"#[a-z,A-Z]*","")
# sacar referencias a otros screen_names
tweets_pn$full_text <- str_replace_all(tweets_pn$full_text,"@[a-z,A-Z]*","")


##creo y limpio: Frente Amplio

dfm_fa <- quanteda::dfm(quanteda::tokens(tweets_fa$full_text,
                                         remove_punct = TRUE,
                                         remove_numbers = TRUE),
                        tolower=TRUE,
                        verbose = FALSE) %>%
  quanteda::dfm_remove(pattern = c(quanteda::stopwords("spanish")),min_nchar=3)


##creo y limpio: Partido Nacional

dfm_pn <- quanteda::dfm(quanteda::tokens(tweets_pn$full_text,
                                         remove_punct = TRUE,
                                         remove_numbers = TRUE),
                        tolower=TRUE,
                        verbose = FALSE) %>%
  quanteda::dfm_remove(pattern = c(quanteda::stopwords("spanish")),min_nchar=3)



### Armo un diccionario según mi interés

midic <- dictionary(list(social = c("social","politica social","politicas sociales", "plan social","planes sociales", "sociedad", "salud","educación","educacion"),
                         economia = c("economía","empleo", "desempleo", "crisis", "economia","fiscal","dolar*","ajuste"),
                         seguridad=c("seguridad","robo","reforma","delincuente")))



### Aplico el diccionario en mi dfm y saco el porcentaje



midic_result_fa<-dfm_lookup(dfm_fa,dictionary=midic,nomatch="no_aparece")
midic_result_fa=convert(midic_result_fa, to = "data.frame") 
midic_result_fa$partido="Frente Amplio"

midic_result_pn<-dfm_lookup(dfm_pn,dictionary=midic,nomatch="no_aparece")
midic_result_pn=convert(midic_result_pn, to = "data.frame") 
midic_result_pn$partido="Partido Nacional"

midic_result=rbind(midic_result_fa,midic_result_pn)


##Armo una tabla resumen
tabla = midic_result  %>%
  group_by(partido)%>%
  tidyr::pivot_longer(cols = c(social,economia,seguridad,no_aparece))%>%
  filter(name!="no_aparece")%>%
  group_by(partido, name)%>%
  summarise(N = sum(value)) %>%
  mutate(Prop = round((N/sum(N))*100,1))


##Ejemplo con base bibliográfica para ver co-ocurrencia de palabras claves. 

library(quanteda)
library(dplyr)
library(stringr)

##a) Cargo la base de bibliografía
base=openxlsx::read.xlsx("Clase6/Material/base.xlsx")

##b) Tokenizo la variable donde tengo alojadas las palabras claves separadas por ";"
toks <- tokens(base$Author.Keywords, remove_punct = TRUE)

##c) Las separo en variables diferentes con la función tidyr::separate() 
convars=base %>% 
  tidyr::separate(col=Author.Keywords,into = "X", sep=";") 

##d) Les saco espacios adelante y atras con str_trim()
palabras=str_trim(c(convars$X1, convars$X2,convars$X3,convars$X4,
                    convars$X5,convars$X6,convars$X7,convars$X8,
                    convars$X9,convars$X10,convars$X11,convars$X12,
                    convars$X13,convars$X14,convars$X15,convars$X16))

##e) Armo diccionario con vector de cada columna  
palabras = quanteda::dictionary(list(palabras=palabras))

##f) Armo un DFM a partir de las keywords y aplico quanteda::tokens_compound() ya que
##son términos multi-palabra. Selecciono sólo las que están en mi vector "palabras"
##que sé que aparecen. Pondero tfidf. 

dfm <- quanteda::dfm(quanteda::tokens_compound(quanteda::tokens(base$Author.Keywords,
                                                                remove_punct = TRUE,remove_numbers = TRUE),palabras),tolower = TRUE,  verbose = FALSE)%>%
  dfm_tfidf()


##g) Armo la matriz de co-ocurrencias y armo red con 80 términos principales
base_fcm= dfm %>%
  fcm(context = "document")

feat <- names(topfeatures(base_fcm, 80)) ##cambia la cantidad de palabras
base_fcm_select <- fcm_select(base_fcm, pattern = feat, selection = "keep")
size <- log(colSums(dfm_select(base_fcm, feat, selection = "keep")))
quanteda.textplots::textplot_network(base_fcm_select, min_freq = 0.8, 
                                     vertex_size = size / max(size) * 3,
                                     edge_color="#eb6864")



##2. Diccionarios de sentimientos. Método Syuzhet

#https://cran.r-project.org/web/packages/syuzhet/vignettes/syuzhet-vignette.html
#https://arxiv.org/pdf/1901.08319.pdf

#install.packages("syuzhet")
library(syuzhet)


tweets_fa$screen_name = "Frente Amplio"
tweets_pn$screen_name = "Partido Nacional"
tweets_df = rbind(tweets_fa,tweets_pn)

Sentiment <- get_nrc_sentiment(tweets_df$full_text, language = "spanish")

tweets_df_senti <- cbind(tweets_df, Sentiment)

##Defino el sentimiento considerando la diferencia entre puntajes + y -

tweets_df_senti$puntaje<-tweets_df_senti$positive-tweets_df_senti$negative
tweets_df_senti$sentimiento=ifelse(tweets_df_senti$puntaje<0,"Negativo","Positivo")
tweets_df_senti$sentimiento=ifelse(tweets_df_senti$puntaje==0,"Neutral",tweets_df_senti$sentimiento)

tweets_sent <- tweets_df_senti %>% group_by(screen_name,sentimiento) %>% summarise(count=n()) %>% 
  mutate(per = round(prop.table(count)*100,1))

##Grafico

ggplot(tweets_sent, aes(x=screen_name, y=per, fill=sentimiento))+
  geom_bar(position="dodge", stat="identity")+
  scale_fill_manual(values = c("#EB594D", "#FFFAA4","#98E898"))+
  geom_text(data = tweets_sent, 
            aes(x = screen_name, y = per, label = per),position=position_dodge(width=0.9), vjust=-0.25)


# Conteo absoluto de puntajes
library(dplyr)
library(tidyverse)
tweets_sent_puntaje <- tweets_df_senti %>% group_by(puntaje,screen_name) %>% summarise(count=n()) %>% 
  mutate(per = round(prop.table(count)*100,1))

ggplot(tweets_sent_puntaje, aes(x=puntaje, y=count, fill=screen_name))+
  geom_bar(position="dodge", stat="identity")+
  scale_fill_manual(values = c("#df4a4a", "#add8e6"))+
  geom_text(data = tweets_sent_puntaje, 
            aes(x = puntaje, y = count, label = count),position=position_dodge(width=1.5), vjust=-0.25)



##Grafico sentimiento y partido agrupado


a=tweets_df_senti  %>%
  group_by(screen_name) %>%
  summarise(text_p = paste(full_text, collapse = " ")) %>%
  mutate(Sentiment_syuzhet = syuzhet::get_sentiment(text_p, method = "syuzhet", 
                                                    language = "spanish")) %>%
  ggplot(aes(x = factor(screen_name, level = c("Frente Amplio", 
                                               "Partido Nacional")), 
             y = Sentiment_syuzhet, color = screen_name)) +
  geom_point(size = 5, alpha = 0.8) +
  ggtitle("Análisis de sentimiento por Partido") +
  geom_hline(yintercept = 0, color = "#4F4D4D") +
  theme_minimal() +
  theme(axis.title.y = element_blank(), 
        axis.title.x = element_blank(),
        legend.title = element_blank(), 
        legend.position = "none") 



##3. Modelado de topicos 
library(topicmodels)

dtm <- convert(dfm_fa, to = "topicmodels")

lda <- LDA(dtm, k = 4)

get_terms(lda,10)


