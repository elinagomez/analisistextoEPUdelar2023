# Instalo las librerias necesarias 

install.packages("tesseract")
library(tesseract)
install.packages("readtext")
library(readtext)
library(pdftools)

# extraigo las constituciones de la República a ser analizadas

# Constitución de la República Oriental del Uruguay
getwd()
setwd("C:/Users/magomez/Desktop/M_T_R/Curso_R_apli_Cuali/Trabajo_final")
getwd()
Consti_UY_PDF <- ("C:/Users/magomez/Desktop/M_T_R/Curso_R_apli_Cuali/Trabajo_final/Constitución de la República Oriental del Uruguay.pdf")
Consti_UY_PDF
Const_UY <- readtext(Consti_UY_PDF)

# Con la funciÃ³n cat, concatenamos el texto

cat(Const_UY[,2])
Const_UY_2 <- capture.output(cat(Const_UY[,2])) 
Const_UY_2
View(Const_UY_2)
# Constitución de Costa Rica

Consti_CR_PDF <- "C:/Users/magomez/Desktop/M_T_R/Curso_R_apli_Cuali/Trabajo_final/constitucion_Costa_Rica.pdf"
Consti_CR_PDF
Consti_CR <- readtext(Consti_CR_PDF)

# Con la funciÃ³n cat, concatenamos el texto

cat(Consti_CR[,2])
Const_CR_2 <- capture.output(cat(Consti_CR[,2])) 
Const_CR_2
View(Const_CR_2)

# Exploro y manipulo

UY_Table <- table(Const_UY_2)
UY_Table
View(UY_Table)

CR_Table <- table(Const_CR_2)
CR_Table
View(CR_Table)


# fijamos a UTF-8

options(encoding = "utf-8")

# Cargo las librerias
install.packages("dplyr", "stopwords", "tidytext","stringi",
                 "stringr","ggplot2","scales","tidyr","widyr",
                 "ggraph","igraph","quanteda","topicmodels","cvtools")

library(pdftools)
library(dplyr)
library(stopwords)
library(tidytext)
library(stringi)
library(stringr)
library(ggplot2)
library(scales)
library(tidyr)
library(widyr)
library(ggraph)
library(igraph)
library(quanteda)
library(topicmodels)
library(cvTools)
library(knitr)

# Ubicacion de los set de datos

getwd()
setwd("C:/Users/farti/Documents/Angeles")
getwd()


# exploro el largo de ambos texto

length(Const_UY_2)
length(Const_CR_2)

# limpio

Const_UY <- gsub("\\r", " ",Const_UY_2)
Const_UY <- gsub("\\n", "",Const_UY_2)
Const_UY <- gsub("\\d\\K\\.(?=\\d)", "",Const_UY_2, perl = TRUE)

# juntamos todas las páginas

Const_UY <- paste(Const_UY_2, collapse = "")
length(Const_UY)

Const_UY[1]

# estructuro el texto

vector = c()
for (i in 1:length(Const_UY)) {
  temp<-(strsplit(Const_UY[[i]], "\\.")[[1]])
  print(temp)
  vector <- c(vector, temp)
}

length(vector)
class(vector)

# lo convertimos en un data frame

Constitu <- as.data.frame(vector)
Constitu
View(Constitu)
# limpieza nuevamente

colnames(Constitu)[1]<-"Contenido"

# quitamos los espacios de encabezado y pie de página

Constitu$Contenido <- trimws(Constitu$Contenido, "l")

# paso a cáracter
Constitu$Contenido <- as.character(Constitu$Contenido)

# limpio un poco mas

Constitu$Contenido <- gsub("CAPITULO", "", Constitu$Contenido)
Constitu$Contenido <- gsub("Artículo", "", Constitu$Contenido)

View(Constitu)
# Análisis exploratorio

Nomenclatura <- stopwords("es")

Nomenclatura <- as.data.frame(Nomenclatura)
Nomenclatura
names(Nomenclatura) <- "normativa"
names(Nomenclatura)
Nomenclatura$normativa <- as.character(Nomenclatura$normativa)

View(Nomenclatura)

# generamos un ID para análisis básico
library(tidyverse)
CUY <- tibble::rowid_to_column(Constitu, "ID")
CUY
View(CUY)
library(unnest)
library(tidyr)
library(dplyr)


review_words <- CUY%>%
  distinct(Contenido, .keep_all = TRUE)%>% 
  unnest_tokens(normativa, Contenido, drop = FALSE)%>%
  distinct(ID,normativa,.keep_all = TRUE)%>%
  anti_join(Nomenclatura)%>%
  filter(str_detect(normativa,"[^\\d]"))%>%
  group_by(normativa)%>%
  dplyr::mutate(normativa_total= n())%>%
  ungroup()

review_words
View(review_words)
#Contamos las palabras

word_counts  <- review_words%>%
  dplyr::count(normativa, sort = TRUE)
word_counts
View(word_counts)

# Grafique segun numero de aparicion
word_counts%>%
  head(20)%>%
  mutate(normativa = reorder(normativa, n))%>%
  ggplot(aes(normativa, n)) +
  geom_col(fill = "green")+
  scale_y_continuous() +
  coord_flip() +
  labs(title = paste0("Palabras mas utilizadas"),
       subtitle = "Stopwords retiradas",
       x = "Palabra",
       y = "Numero de veces usada")



# Generamos nuestra nube de palabras

library(wordcloud)
library(RColorBrewer)
library(textplot)

CUY_grouped_V <- review_words%>% group_by(normativa)%>%count(normativa_total)%>%
  mutate(frecuencia = n/dim(review_words)[1])
View(CUY_grouped_V)
CUY_grouped_V
View(CUY_grouped_V)
wordcloud(words = CUY_grouped_V$normativa, freq = CUY_grouped_V$normativa_total,
          min.words = 3 , random.order = FALSE, rot.per = 0.35,
          colors = brewer.pal(8,"Dark2")) 


# bigramas
library(tidytext)
review_bigrams <- CUY %>% 
  unnest_tokens(bigram, Contenido, token = "ngrams", n = 2)
review_bigrams
bigrams_separated <- review_bigrams %>%
  separate(bigram, c("word1","word2"), sep = " ")
bigrams_filtered <- bigrams_separated %>% 
  filter(!word1 %in% Nomenclatura$normativa) %>%
  filter(!word2 %in% Nomenclatura$normativa)
bigram_counts <- bigrams_filtered %>%
  dplyr::count(word1, word2, sort = TRUE)
bigrams_united <- bigrams_filtered %>%
  unite(bigram, word1, word2, sep =  " ")
bigrams_united %>%
  dplyr::count(bigram, sort = TRUE)
  
view(bigrams_united) 

  
  