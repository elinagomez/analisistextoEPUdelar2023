#Extracción de tweets
library(httpuv)

library(dplyr)
library(ggplot2)
library(rtweet)

#rtweet::create_token() 

auth=rtweet_app("AAAAAAAAAAAAAAAAAAAAAJCojwEAAAAAcuTZRAzHEuhrop3Q7%2Bv5YUvvTg4%3DvTml99TwbQIoW2qUs2zbP4cON8KTc3zHjxXYv8HMH3TXk2IDeL")
auth_save(auth,"proyecto")
auth_as("proyecto")
#Cargar tweets
RobertSilva<- search_tweets("@RobertSilva1971", n = 500, include_rts = TRUE,retryonratelimit=TRUE)
ANEP<- search_tweets("@ANEP_Uruguay", n = 500, include_rts = TRUE,retryonratelimit=TRUE)
FENAPES<- search_tweets("@FenapesUruguay", n = 500, include_rts = TRUE,retryonratelimit=TRUE)
Adur<- search_tweets("@adur_udelar", n = 500, include_rts = TRUE,retryonratelimit=TRUE)
Hastagh<- search_tweets("#TransformacionDeTerror", n = 500, include_rts = TRUE,retryonratelimit=TRUE)
Hastagh2<- search_tweets("#VivaLaEducaciónPública", n = 500, include_rts = TRUE,retryonratelimit=TRUE)
Hastagh3<- search_tweets("#Transformacion Educativa", n = 500, include_rts = TRUE,retryonratelimit=TRUE)
Ceipa<- search_tweets("@CeipaEnLucha", n = 500, include_rts = TRUE,retryonratelimit=TRUE)

#Renombrar variables y agrupar tweets
tweets_V1<- bind_rows(RobertSilva,ANEP,Hastagh2,Hastagh,Hastagh3,Ceipa,FENAPES)
tweets <- tweets %>% rename( fecha = created_at,
                            texto= text,
                            tweet_id = id_str)
head(tweets)

#limpieza de texto

library(quanteda)
library(readtext) 
library(stringr)
library(dplyr)
library(ggplot2)
library(quanteda.textstats)
library(quanteda.textplots)
  
  
  dfm_tweets_v1<- quanteda::dfm(quanteda::tokens(tweets_V1$full_text,
                                               remove_punct = FALSE,
                                               remove_numbers = FALSE),
                              tolower=FALSE,
                              verbose = TRUE) %>%
  quanteda::dfm_remove(pattern = c(quanteda::stopwords("spanish"),tolower(tweets_V1$full_text)),min_nchar=3)

  quanteda::dfm_trim(min_termfreq = 4)%>% 

    topfeatures(dfm_tweets_v1,20)
  
--------# graficos
quanteda.textplots::textplot_wordcloud(dfm_tweets_v1, min.count = 2,max_words = 200,
                                       random.order = FALSE,colors = RColorBrewer::brewer.pal(8,"Dark2"),comparison = F)

top = data.frame(topfeatures(dfm_tweets_V1,30))
topfeatures(dfm_tweets_v1,20)

kwic = quanteda::kwic(quanteda::tokens(tweets_V1$full_text,
                                       remove_punct = TRUE,
                                       remove_numbers = TRUE), 
                      pattern = quanteda::phrase(c("educacion")),
                      window = 5)
                      

datatable(kwic)

#las defino como rownames
top$palabra = rownames(top)

#hago el grÃ¡fico con ggplot
topplot = top[1:30] %>%
  ggplot(aes(x = reorder(palabra, topfeatures.dfm_tweets..30.), 
             y = topfeatures.dfm_tweets_V1..20., fill = palabra)) + 
  geom_col(show.legend = FALSE) +
  coord_flip() +
  geom_text(aes(hjust = -0.1, label = topfeatures.dfm_tweets.V1..20.)) +
  theme_minimal() +
  theme(axis.title.y = element_blank(), axis.title.x = element_blank(), axis.text = element_text(size = 15)) +
  ggtitle("Palabras mÃ¡s frecuentes (n=30)") +
  scale_fill_manual(values = c(rep("#D7B5D8",30)))


