#------------------------------------------------------------------------------#
#           Recuperación y análisis de texto con R                             # 
#                  Educación Permanente FCS                                    #
#                         Clase 5                                              # 
#                      Live coding                                             #
#------------------------------------------------------------------------------#

# Presentación de quanteda ----

library(speech)
library(quanteda)

# diario de sesion
url <- "https://parlamento.gub.uy/documentosyleyes/documentos/diarios-de-sesion/3339/IMG"

# compilo por legislador/a
sesion <- speech_build(url, compiler = TRUE)

# Alternativa: cargo el diario de sesion compilado desde el repositorio
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

load("~/rcuali2022/Clase5/Material/intervenciones.RData")

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



quanteda.textstats::textstat_simil(dfm_tfidf(dfm_intervenciones),selection = "reforma",
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


