



##Clase 6

library(quanteda)
library(stringr)
library(rtweet)
library(dplyr)

##me logeo y autorizo
#rtweet::create_token()

load("~/rcuali2022/Clase6/Material/tweets_fa.RData")
load("~/rcuali2022/Clase6/Material/tweets_pn.RData")

tweets_fa <- get_timeline(user="@Frente_amplio",n = 5000)

##alguna limpieza previa de tweets:

#sacar espacios
#tweets_fa$full_text <- str_replace_all(tweets_fa$full_text," ","")
# sacar URLs
tweets_fa$full_text <- str_replace_all(tweets_fa$full_text, "http[[:alnum;]]*","")
tweets_fa$full_text <- str_replace_all(tweets_fa$full_text, "s://t.co/[[:alnum;]]*","")

# sacar toda referencia a RT
tweets_fa$full_text <- str_replace(tweets_fa$full_text,"RT @[a-z,A-Z]*: ","")
# sacar hashtags
tweets_fa$full_text <- str_replace_all(tweets_fa$full_text,"#[a-z,A-Z]*","")
# sacar referencias a otros screen_names
tweets_fa$full_text <- str_replace_all(tweets_fa$full_text,"@[a-z,A-Z]*","")




tweets_pn <- get_timeline(user="@PNACIONAL",n = 5000)

##alguna limpieza previa de tweets:

#sacar espacios
#tweets_pn$full_text <- str_replace_all(tweets_pn$full_text," "," ")
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

tabla = midic_result  %>%
  group_by(partido)%>%
  summarise(social = sum(social), social_prop = (sum(social)/sum(social,economia,seguridad,no_aparece))*100, 
            economia = sum(economia), economia_prop = (sum(economia)/sum(social,economia,seguridad,no_aparece))*100,
            seguridad = sum(seguridad), seguridad_prop = (sum(seguridad)/sum(social,economia,seguridad,no_aparece))*100)





##Aplico un diccionario ya existente para analizar emociones: 
#Diccionario LWIC-Spanish 


lwic <- readRDS("Clase6/Material/EmoPosNeg_SPA.rds")

sent_dfm_fa <- dfm_lookup(dfm_fa, dictionary = lwic)

sent_fa=convert(sent_dfm_fa, to = "data.frame") 

##creo un score que es la difrencia entre términos positivos y negativos, y los vinculo con las variables de agregación de los documentos
sent_fa$puntaje <- sent_fa$EmoPos-sent_fa$EmoNeg
sent_fa$sentimiento=ifelse(sent_fa$puntaje<0,"Negativo","Positivo")
sent_fa$sentimiento=ifelse(sent_fa$puntaje==0,"Neutral",sent_fa$sentimiento)
sent_fa$partido="Frente Amplio"

sent_dfm_pn <- dfm_lookup(dfm_pn, dictionary = lwic)
sent_pn=convert(sent_dfm_pn, to = "data.frame") 
##creo un score que es la difrencia entre términos positivos y negativos, y los vinculo con las variables de agregación de los documentos
sent_pn$puntaje <- sent_pn$EmoPos-sent_pn$EmoNeg
sent_pn$sentimiento=ifelse(sent_pn$puntaje<0,"Negativo","Positivo")
sent_pn$sentimiento=ifelse(sent_pn$puntaje==0,"Neutral",sent_pn$sentimiento)
sent_pn$partido="Partido Nacional"


sentimiento=rbind(sent_fa,sent_pn)


library(dplyr)
library(ggplot2)


sentimiento_tabla <- sentimiento %>% filter(sentimiento!="Neutral") %>%group_by(partido,sentimiento) %>% summarise(count=n()) %>% 
mutate(per = prop.table(count)*100)
library(ggplot2)
ggplot(sentimiento_tabla, aes(x=partido, y=per, fill=sentimiento))+
  geom_bar(position="dodge", stat="identity")+
  scale_fill_manual(values = c("#EB594D","#98E898"))




##Método Syuzhet

#https://cran.r-project.org/web/packages/syuzhet/vignettes/syuzhet-vignette.html
#https://arxiv.org/pdf/1901.08319.pdf

#install.packages("syuzhet")
library(syuzhet)

#Otro método

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

tweets_sent_puntaje <- tweets_df_senti %>% group_by(puntaje,screen_name) %>% summarise(count=n()) %>% 
  mutate(per = round(prop.table(count)*100,1))

ggplot(tweets_sent_puntaje, aes(x=puntaje, y=count, fill=screen_name))+
  geom_bar(position="dodge", stat="identity")+
  scale_fill_manual(values = c("#df4a4a", "#add8e6"))+
  geom_text(data = tweets_sent_puntaje, 
            aes(x = puntaje, y = count, label = count),position=position_dodge(width=1.5), vjust=-0.25)



##grafico sentimiento y partido agrupado


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


##Modelado de topicos 
library(topicmodels)

dtm <- convert(dfm_fa, to = "topicmodels")

lda <- LDA(dtm, k = 4)

get_terms(lda,10)

