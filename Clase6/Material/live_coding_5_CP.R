#------------------------------------------------------------------------------#
#           Recuperación y análisis de texto con R                             # 
#                         Clase 5                                              # 
#                      Live coding                                             #
#------------------------------------------------------------------------------#


library(quanteda)
library(stringr)
library(rtweet)
library(dplyr)
library(tidyr)
library(ggplot2)


load("Clase6/Material/tweets_fa.RData")
load("Clase6/Material/tweets_pn.RData")

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
  tidyr::pivot_longer(cols = c(social,economia,seguridad,no_aparece)) %>%
  filter(name!="no_aparece") %>%
  group_by(partido, name) %>%
  summarise(N = sum(value)) %>%
  mutate(Prop = round((N/sum(N))*100,1))




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

tweets_df_senti2=tweets_df_senti %>%
  select(full_text,positive,negative)

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

