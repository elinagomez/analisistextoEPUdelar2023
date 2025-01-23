
library(quanteda)
library(topicmodels)
library(tidyverse)

ruta="C:/Users/elina/OneDrive/Escritorio/IECON/Medios/Bases/Base_final.xlsx"
topic=openxlsx::read.xlsx(ruta)
topic$doc_id=c(1:nrow(topic))


corpus <- corpus(topic, text_field = "Cuerpo", docid_field = "doc_id")

dfm <- corpus %>%
  tokens(remove_punct = TRUE, remove_numbers = TRUE) %>%
  tokens_remove(stopwords("es")) %>%
  dfm()

# Filtrar términos poco frecuentes
dfm <- dfm_trim(dfm, min_termfreq = 2)

# Guardar los IDs originales antes de eliminar documentos vacíos
doc_ids <- docnames(dfm)

# Filtrar documentos vacíos (filas con solo ceros)
dfm <- dfm[rowSums(dfm) > 0, ]

# Actualizar los IDs de los documentos filtrados
doc_ids_filtered <- docnames(dfm)

# Aplicar el modelo LDA
lda_model <- LDA(dfm, k = 6, control = list(seed = 1234))
terms(lda_model,15)

# Extraer los tópicos y guardarlos en un data frame
topics <- posterior(lda_model)$topics
topics_df <- as.data.frame(topics)
colnames(topics_df) <- paste0("Topic_", 1:6)

# Añadir los IDs originales a los resultados de tópicos
topics_df$doc_id <- doc_ids_filtered

topics_df$doc_id=as.numeric(topics_df$doc_id)
topic <- left_join(topic, topics_df, by = "doc_id")


# Aplicar las etiquetas a los tópicos
topic_labels <- c(
  
  "Topic_1" = "Plebiscito Seguridad Social",
  "Topic_2" = "Política económica del Gobierno",
  "Topic_3" = "Campaña electoral",
  "Topic_4" = "Propuesta económica Frente Amplio",
  "Topic_5" = "Política económica",
  "Topic_6" = "Impuestos"
)



long_topic <- topic %>%
  pivot_longer(cols = starts_with("Topic_"), names_to = "topic", values_to = "count") %>%
  mutate(topic_label = recode(topic, !!!topic_labels))


topic_frequencies <- long_topic %>%
  filter(Medio%in%c("BUSQUEDA DIGITAL","EL PAIS DIGITAL","MONTEVIDEO PORTAL","EL OBSERVADOR DIGITAL"))%>%
  group_by(topic_label, Medio) %>%
  summarise(frequency = sum(count, na.rm = TRUE), .groups = 'drop') %>%
  ungroup() %>%
  group_by(Medio) %>%
  mutate(frequency_pct = frequency / sum(frequency, na.rm = TRUE) * 100) %>%
  ungroup()

topic_frequencies <- topic_frequencies %>%
  mutate(topic_label = factor(topic_label, levels = unique(topic_label[order(-frequency_pct)])))

# Grafico

ggplot(topic_frequencies, aes(x = reorder(topic_label, -frequency_pct), y = frequency_pct, fill = Medio)) +
  geom_bar(stat = "identity", position = "dodge") +
  #scale_fill_manual(values =  RColorBrewer::brewer.pal(12, "Set3")) +
  scale_y_continuous(labels = scales::percent_format(scale = 1)) +
  labs(title = "Frecuencia de Tópicos por Medio",
       x = "",
       y = "",
       fill = "") +
  coord_flip() +
  theme_minimal(base_family = 'montserrat') +
  theme(axis.text.x = element_text(size = 10,  face = "bold", family = 'montserrat'),
        axis.text.y = element_text(size = 8, face = "bold", family = 'montserrat'),
        legend.title = element_text(size = 12, face = "bold", family = 'montserrat'),
        legend.text = element_text(size = 7, face = "bold", family = 'montserrat'),
        legend.position = "bottom",
        plot.title = element_text(size = 12, face = "bold", family = 'montserrat'))




base_final_grande <- read.delim2("Clase7/Material/base_genero_final.txt",sep="\t",header = T,encoding = "latin1")

save(base_final_grande,file="Clase7/Material/base_genero_final.RData")








