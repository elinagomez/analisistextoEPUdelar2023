##**Introducción**

#El presente trabajo se enmarca en la entrega final del curso "R aplicado al análisis cualitativo" dictado en la unidad de Educación Permanente de la Universidad de la República. El mismo, dictado por la Mag. Elina Goméz, durante el mes de diciembre del 2022, pretende profundizar en el análisis de fuentes documentales a través de R. En el siguiente trabajo buscaremos presentar el análisis de una serie de entrevistas en profundidad realizadas en el marco de la Tesis de Grado *¿Y después qué? Una mirada a los procesos de reinserción de las personas liberadas del sistema penitenciario uruguayo.* A través de este trabajo realizamos una codificación manual de los textos de las entrevistas transcritas mediante la plataforma RQDA. Para poder presentar datos relevantes a este estudio se requirieron dos acciones fundamentales: una correcta limpieza y homogeneización de los datos así como el uso de técnicas de minería de datos.

#Análisis documental mediante plataforma RQDA

library(RQDA)
RQDA()

##Visualización de algunos datos relevantes obtenidos

#La función summaryCodings() nos devuelve una lista con el número de entrevistas vinculadas a cada código que creamos en RQDA y con summaryCodings(byFile= TRUE) podemos ver por entrevista el número de códigos asociados a la misma.
summaryCodings()
summaryCodings(byFile= TRUE)

## Tabla con codificaciones

tabla_cods=getCodingTable()

## Y por último, con la función filesByCodes() podemos ver la relación entre entrevistas y códigos

filesByCodes()

##Limpieza de textos

##Los datos obtenidos de las entrevistas presentan muchos caracteres, espacios y palabras que no sirven para realizar un análisis preciso de los datos recabados. Es por eso que a la hora de trabajar con textos planos como son las entrevistas que realizamos, así como otras bases de datos, utilizaremos las llamadas técnicas de "limpieza".
#*Instalaciones requeridas*
install.packages("pdftools") #para cargar archivos de texto en pdf
install.packages("tm") #para minería de texto
install.packages("SnowballC") #para minería de texto
install.packages("wordcloud2") #paquete para generar la nube de palabras
#*Librerías requeridas*
library("pdftools")
library("tm")
library("SnowballC")
library("wordcloud2")
library("udpipe") 
library("ggplot2")
library("readtext")
library("corpus")
library("dplyr")

##Limpieza de archivos PDF

##Cargamos nuestra base de datos 
texto <- pdf_text("C:/Users/Usuario/OneDrive/Escritorio/EntregaR/Entrevistasrecopiladasanalisisquanteda.pdf")

##Debido a que el español lleva tildes y otros signos de puntuación, usamos la función iconv() para quitarlos y no tener problemas más adelante.
texto <- iconv(texto, "UTF-8")
texto <- iconv(texto, "latin1")
texto = iconv(texto, to="ASCII//TRANSLIT")

# Utilizando la función Corpus(), indicamos la fuente de nuestro texto

docs <- Corpus(VectorSource(texto))

##luego limpiamos de caracteres especiales
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "\r\n")
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")

##Por último limpiamos nuestro texto 

# Convertir el texto a minúsculas
docs <- tm_map(docs, content_transformer(tolower))
# Quitar puntuacion
docs <- tm_map(docs, removePunctuation)
# Quitar los números
docs <- tm_map(docs, removeNumbers)
# Quitar las palabras comunes en español
docs <- tm_map(docs, removeWords, stopwords("spanish"))
# Quitar palabras communes que consideramos no tenían relación
docs <- tm_map(docs, removeWords, c( "sale", "año","digo", "decir", "digamos","claro","dia", "seria","general","cosa", "ano","menos","podes","algun", "risas","pasa", "anos", "puede", "claro","asi","tipo","vez","ver","habia","parte","alguna","siempre","situacion", "capaz", "dos", "trabajando","aca","mas","tambien","hacer","entonces","si", "bueno", "creo","despues","hace","bueno","eh,","estan","veces","ser","ahora","muchas", "bien,", "ta,", "si,","ahi","bueno","persona", "eh","bien","ta","parece","vos","cada", "momento","van", "cosas", "tener","todas"))

##Limpieza de archivos TXT

#Primero cargamos la base de datos

base_final <- read.delim2("C:/Users/Usuario/OneDrive/Escritorio/EntregaR/baseentrevistadoentrevista.txt",sep="\t",header = T)

##Convertimos a DFM nuestra base de datos y al mismo tiempo realizamos su limpieza`

text_df_pre <- dfm(tokens(base_final$text, remove_punct = TRUE,remove_numbers = TRUE), 
                   tolower = TRUE, ##Convertir el texto a minúsculas`
                   remove_punct = TRUE, ##Quitar puntuación`
                   remove_numbers = TRUE, ##Quitar números`
                   remove = c(stopwords("spanish"))) %>% #Quitar palabras Español`
  dfm_remove(min_nchar=3) %>% #Quitar palabras de menos de tres letras`
  dfm_trim(min_termfreq = 20, min_docfreq = 2) #Devuelve un documento con todas las palabras que se repitan más de veinte veces y que se repitan en por lo menos dos entrevistas`

##Mineria de texto

##En esta sección buscaremos visualizar algunas de las técnicas de minería de textos que pueden servir tanto para análisis como para visualización de datos surgidos a partir de textos de formas dinámicas y atractivas.

##Primeramente construimos una matriz term-document a partir de nuestro documento _docs_ al que le hicimos previamente una "limpieza" como se vió anteriormente.

#Construir una matriz term-document

mtd <- TermDocumentMatrix(docs)
m <- as.matrix(mtd)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v) library(dp)

##Generamos 3 nubes con distintas caracteristicas.

wordcloud2(data=d,10, size = 0.65, shape = "cloud", color = 'red',backgroundColor = 'white')

wordcloud2(data = d,12, size = 0.6, shape = "círcle", color="white", backgroundColor = 'grey')

wordcloud2(data=d,24, size = 0.65, shape = "triangle" ,color = 'random-dark',backgroundColor = "pink")

##Frecuencia de las 20 palabras mas nombradas

palabras <- docs %>% 
  TermDocumentMatrix() %>% 
  as.matrix() %>% 
  rowSums() %>% 
  sort(decreasing = TRUE)

palabras %>% head(20)

##Co-ocurrencia de códigos

##Otra de las herramientas del uso del RQDA, es la posibilidad de crear tablas de co-ocurrencia. Para este caso buscamos observar según cada entrevistas la frecuencia de aparición de los códigos generados, al mismo que logramos comparar la aparición entre los distintos entrevistados.

library(ggplot2)

cods = getCodingTable()[,4:5]

ggplot(cods, aes(codename, fill=filename)) + geom_bar(stat="count") + 
  facet_grid(~filename) + coord_flip() + 
  theme(legend.position = "none") + 
  ylab("Frecuencia de códigos por documento") + xlab("Códigos")

#librerías
install.packages("tidytext")
install.packages("tokenizers")
library(quanteda) 
library(knitr)
library(quanteda.textplots)
library(quanteda.textstats)
library(readtext) 
library(stringr)
library(dplyr)
library(ggplot2)
library(tm)
library(qdap)
library(wordcloud)
library(tidyverse)
library(tokenizers)
library(corpus)

##Creacion y analisis de corpus a partir de las entrevistas individuales

list.files(path = "C:/Users/Usuario/OneDrive/Escritorio/EntregaR/corpus/")
corpus_base <- readtext("C:/Users/Usuario/OneDrive/Escritorio/EntregaR/corpus/*", encoding = "UTF-8")
corpus_base <- corpus(corpus_base)
docvars(corpus_base, "Reinsercion") <- c("Alicia", "asfavide", "laura", "lucia", "pamela", "parodi")

kable(summary(corpus_base))
