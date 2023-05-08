library(dplyr)
library(ggplot2)
library(rtweet)
library(tidyverse)
library(quanteda)
library(readtext)
library(stringr)
library(twitteR)
library(lubridate)
library(reactable)
library(stopwords)

library(quanteda) 
library(quanteda.textplots)
library(plyr) 
library(dplyr)
library(stringr)
library(RColorBrewer)


########
if(FALSE){
  token = create_token(app = "Rcourse_Seba",
                       consumer_key = "YRPq36FetDTsR5k44vrBpYEXl",
                       consumer_secret = "oyveTkO92eDWSdxQIP4OPvJngzc4xmlnnU3jEaZR4SGQRknbLx",
                       access_token = "AAAAAAAAAAAAAAAAAAAAALrKTgEAAAAAhq4h5aDwZmeWf4a04WcYJlG1mkA%3DfAlBawujdNAsg88G22z8BD5rqzjzbASsdf8TQlaKjY6zRJRvmm",
                       access_secret = "oyveTkO92eDWSdxQIP4OPvJngzc4xmlnnU3jEaZR4SGQRknbLx",
                       set_renv = FALSE)
  
  
  CC <- get_timeline("CosseCarolina", n=3200,retryonratelimit=TRUE)
  LP <- get_timeline("LuisLacallePou", n=3200,retryonratelimit=TRUE)
  OA <- get_timeline("Oandradelallana", n=3200,retryonratelimit=TRUE)
  
  serie <- rbind(CC, LP, OA)
  
  save.image(file="C:/Users/mauricio.gonzalez/Desktop/CursoR/TF_R_datos.RData")
}

########
load("C:/Users/mauricio.gonzalez/Desktop/CursoR/TF_R_datos.RData")


## cantidad de registros por candidato por mes
sel <- serie[serie$created_at>="2020-03-01 00:00:00" & serie$created_at<"2020-12-01 00:00:00",c("created_at","screen_name")]
sel$mes <- month(sel$created_at)
sel2 <- sel %>% dplyr::group_by(mes, screen_name) %>%
  dplyr::summarise(cnt = n())

## comienza el primer plot: line plot cantidad de tweets por mes
if(FALSE){
windows(width = 6, height=4) #abre plot window, para luego grabar el plot con savePlot
  plot(sel2$mes[sel2$screen_name=="CosseCarolina"],sel2$cnt[sel2$screen_name=="CosseCarolina"]
       ,type = "l" #l: line, b: linea y punto
       ,lwd=2 #grosor de la linea
       ,xlab="Mes",ylab="Cantidad" #etiqueta de ejes
       ,ylim=c(0,350) #rango de ejes
       ,col="red3"
       ,lty=1 #tipo de linea. 1: solid, 2: dashed ...
      #,pch=16
      )
  lines(sel2$mes[sel2$screen_name=="LuisLacallePou"],sel2$cnt[sel2$screen_name=="LuisLacallePou"]
        ,lty=1
        ,lwd=2
        ,col="blue")
  lines(sel2$mes[sel2$screen_name=="Oandradelallana"],sel2$cnt[sel2$screen_name=="Oandradelallana"]
        , lty=1
        , lwd=2
        ,col="forestgreen")
  legend("topleft",c("CC","LP","OA")
         #,lty = c(1,2,3)
         ,col=c("red3","blue","forestgreen")
         ,lwd = 2, bty = "n",horiz = TRUE, x.intersp = 0.4)
  savePlot("C:/Users/mauricio.gonzalez/Desktop/CursoR/LinePlot_CantidadPorMes.png",type = "png")
}#Al final no estoy usando este plot

## comienza el segundo y tercer plot: wordcloud y wordcount
windows(width = 7, height=7) #abre plot window, para luego grabar el plot con savePlot
options(warn=-1)
for(i in 0:3){
  que <- i #!!! ¿Que quiero plotear? 0: todos, 1: primer candidato, 2: segundo candidato, 3: tercer candidato
  
  if(que == 0){
    sel <- serie[serie$created_at>="2020-03-01 00:00:00" & serie$created_at<"2020-12-01 00:00:00",] #todos los candidatos
  } else if(que == 1){
    sel <- serie[serie$created_at>="2020-03-01 00:00:00" & serie$created_at<"2020-12-01 00:00:00" & serie$name == "Luis Lacalle Pou",]
  } else if(que == 2){
    sel <- serie[serie$created_at>="2020-03-01 00:00:00" & serie$created_at<"2020-12-01 00:00:00" & serie$name == "Carolina Cosse",]
  } else {
    sel <- serie[serie$created_at>="2020-03-01 00:00:00" & serie$created_at<"2020-12-01 00:00:00" & serie$name == "Óscar Andrade",]
  }
  
  vector <- stopwords(language="es")
  vector <- c(vector,"gracias","hoy","así","ser") #acá agrego otras palabras para excluir
  #Crear dfm, eliminar números, puntuaciones, palabras con pocos caracteres, stopwords
  dfmSerie <- quanteda::dfm(quanteda::tokens(sel$text,
                                             remove_punct = TRUE,
                                             remove_numbers = TRUE),
                            tolower=TRUE,
                            verbose = FALSE) %>%
    quanteda::dfm_remove(pattern = vector, min_nchar = 3)%>%
    dfm_trim(min_termfreq = 1)
  
  #Limpieza
  palabrasSerie <- featnames(dfmSerie)
  arrobaSerie=grep("@\\w+ *",palabrasSerie,value = TRUE)
  hashtagSerie=grep("#\\w+ *",palabrasSerie,value = TRUE)
  httpsSerie=grep("https*", palabrasSerie, value = TRUE)
  otraspalabrasSerie <- c(hashtagSerie,arrobaSerie, httpsSerie, "amp", "t.co", "rt")
  dfmSerie <- dfm(dfmSerie, remove=otraspalabrasSerie)
  
  
  # color parameters for plots
  pal=brewer.pal(8,"Blues")
  pal=pal[-(1:3)]
  colors=brewer.pal(8, "Dark2")
  quanteda.textplots::textplot_wordcloud(dfmSerie, max_words = 100, col = colors,
                               min_size = .5, max_size = 7, rotation = 0.1)
   
  if(que == 0){
    savePlot("C:/Users/mauricio.gonzalez/Desktop/CursoR/wordcloud_todos.png",type = "png")
  } else if(que == 1){
    savePlot("C:/Users/mauricio.gonzalez/Desktop/CursoR/wordcloud_LP.png",type = "png")
  } else if(que == 2){
    savePlot("C:/Users/mauricio.gonzalez/Desktop/CursoR/wordcloud_CC.png",type = "png")
  } else {
    savePlot("C:/Users/mauricio.gonzalez/Desktop/CursoR/wordcloud_OA.png",type = "png")
  }
  
  
  ## comienza el tercer plot: conteo de palabras
  tf <- quanteda::topfeatures(dfmSerie, n=30)
  #las defino como rownames
  tf <- as.data.frame(t(t(tf)))
  tf$palabra = rownames(tf)
  colnames(tf)[1] <- "cantidad"
  ## [1] "cantidad" "palabra"
  
  if(que == 0){
    tit <- "Palabras mas frecuentes en tweets de LP, CC, OA (n=30)"
    col <- "palegreen4"
  } else if(que == 1){
    tit <- "Palabras mas frecuentes en tweets de LP (n=30)"
    col <- "steelblue2"
  } else if(que == 2){
    tit <- "Palabras mas frecuentes en tweets de CC (n=30)"
    col <- "darkorange"
  } else {
    tit <- "Palabras mas frecuentes en tweets de OA (n=30)"
    col <- "maroon"
  }
  #vector con el color para las barras
  coloree = c(rep(col,30))
  #grafico con ggplot
  print(tf[1:30, ] %>%
    ggplot(aes(x = reorder(palabra, cantidad),
               y = cantidad, fill = palabra)) +
    geom_col(show.legend = FALSE) +
    coord_flip() +
    geom_text(aes(hjust = -0.1, label = cantidad)) +
    theme_minimal() +
    theme(axis.title.y = element_blank(), axis.title.x = element_blank(), axis.text = element_text(size = 14)) +
    ggtitle(tit) +
    scale_fill_manual(values = coloree)
  )
  
  if(que == 0){
    savePlot("C:/Users/mauricio.gonzalez/Desktop/CursoR/wordcount_todos.png",type = "png")
  } else if(que == 1){
    savePlot("C:/Users/mauricio.gonzalez/Desktop/CursoR/wordcount_LP.png",type = "png")
  } else if(que == 2){
    savePlot("C:/Users/mauricio.gonzalez/Desktop/CursoR/wordcount_CC.png",type = "png")
  } else {
    savePlot("C:/Users/mauricio.gonzalez/Desktop/CursoR/wordcount_OA.png",type = "png")
  }
}#END: for loop


## comienza el cuarto plot: Análisis de sentimientos
library(syuzhet)
sel <- serie[serie$created_at>="2020-03-01 00:00:00" & serie$created_at<"2020-12-01 00:00:00",c("screen_name","text")]
colnames(sel)[1] <- "candidato"
sel$clean_text <- str_replace_all(sel$text, "@\\w+ *", "")
Sentiment <- get_nrc_sentiment(sel$clean_text, language = "spanish")
serie_senti <- cbind(sel,Sentiment)
serie_senti$puntaje <- serie_senti$positive-serie_senti$negative
#poner sentimientos como nueva variable
serie_senti$sentimiento <- ifelse(serie_senti$puntaje<0,"Negativo","Positivo")
serie_senti$sentimiento <- ifelse(serie_senti$puntaje==0, "Neutral", serie_senti$sentimiento)
#calculo proporción de sentimientos positivos, neutrales y negativos de cada politico
serie_senti_grupos <- serie_senti %>% group_by(candidato, sentimiento) %>% dplyr::summarise(cantidad=n()) %>%
  mutate(porcentaje = round(prop.table(cantidad)*100,1))


library(ggplot2)
windows(width = 6, height=3) #abre plot window, para luego grabar el plot con savePlot
ggplot(data=serie_senti_grupos, aes(x=candidato, y=porcentaje, fill=sentimiento)) +
  geom_bar(stat="identity", position=position_dodge())  + 
  scale_fill_manual(values=c("tomato1","grey80","seagreen3")) +
  geom_text(aes(label=porcentaje), position=position_dodge(width=0.9), vjust=-0.25,size=3)
savePlot("C:/Users/mauricio.gonzalez/Desktop/CursoR/Sentimientos_porc.png",type = "png")

ggplot(data=serie_senti_grupos, aes(x=candidato, y=cantidad, fill=sentimiento)) +
  geom_bar(stat="identity", position=position_dodge())  + 
  scale_fill_manual(values=c("tomato1","grey80","seagreen3")) +
  geom_text(aes(label=cantidad), position=position_dodge(width=0.9), vjust=-0.25,size=3)
savePlot("C:/Users/mauricio.gonzalez/Desktop/CursoR/Sentimientos_cnt.png",type = "png")

