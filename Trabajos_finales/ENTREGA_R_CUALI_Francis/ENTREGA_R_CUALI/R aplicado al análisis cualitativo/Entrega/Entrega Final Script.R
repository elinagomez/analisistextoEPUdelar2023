
install.packages("readtext")

library(readtext)

Un_Titulo_Viejo <- readtext::readtext("C:/Users/Usuario/Desktop/R aplicado al análisis cualitativo/Entrega/Datos/Un_Titulo_Viejo.docx")

Queso_Magro <- readtext::readtext("C:/Users/Usuario/Desktop/R aplicado al análisis cualitativo/Entrega/Datos/Queso_Magro.docx")

Curtidores_De_Hongos <- readtext::readtext("C:/Users/Usuario/Desktop/R aplicado al análisis cualitativo/Entrega/Datos/Curtidores_De_Hongos.docx")

La_Gran_Muñeca <- readtext::readtext("C:/Users/Usuario/Desktop/R aplicado al análisis cualitativo/Entrega/Datos/La_Gran_Muñeca.docx")

Gente_Grande <- readtext::readtext("C:/Users/Usuario/Desktop/R aplicado al análisis cualitativo/Entrega/Datos/Gente_Grande.docx")

Barrio_Querido <- readtext::readtext("C:/Users/Usuario/Desktop/R aplicado al análisis cualitativo/Entrega/Datos/Barrio_Querido.docx")

Jardin_Del_Pueblo <- readtext::readtext("C:/Users/Usuario/Desktop/R aplicado al análisis cualitativo/Entrega/Datos/Jardín_Del_Pueblo.docx")

Mi_Vieja_Mula <- readtext::readtext("C:/Users/Usuario/Desktop/R aplicado al análisis cualitativo/Entrega/Datos/Mi_Vieja_Mula.docx")

Nos_Obligan_A_Salir <- readtext::readtext("C:/Users/Usuario/Desktop/R aplicado al análisis cualitativo/Entrega/Datos/Nos_Obligan_A_Salir.docx")

Diablos_Verdes <- readtext::readtext("C:/Users/Usuario/Desktop/R aplicado al análisis cualitativo/Entrega/Datos/Diablos_Verdes.docx")
  
Barrio_Querido[3] <- "Nueva"
Curtidores_De_Hongos[3] <- "Tradicional"
Gente_Grande[3] <- "Nueva"
Jardin_Del_Pueblo[3] <- "Nueva"
La_Gran_Muñeca[3] <- "Tradicional"
Queso_Magro[3] <- "Tradicional"
Un_Titulo_Viejo[3] <- "Nueva"
Mi_Vieja_Mula[3] <- "Nueva"
Nos_Obligan_A_Salir[3] <- "Tradicional"
Diablos_Verdes[3] <- "Tradicional"

Barrio_Querido[4] <- "No tienen mujeres letristas"
Curtidores_De_Hongos[4] <- "No tienen mujeres letristas"
Gente_Grande[4] <- "Tienen mujeres letristas"
Jardin_Del_Pueblo[4] <- "No tienen mujeres letristas"
La_Gran_Muñeca[4] <- "Tienen mujeres letristas"
Queso_Magro[4] <- "Tienen mujeres letristas"
Un_Titulo_Viejo[4] <- "Tienen mujeres letristas"
Mi_Vieja_Mula[4] <- "No tienen mujeres letristas"
Nos_Obligan_A_Salir[4] <- "No tienen mujeres letristas"
Diablos_Verdes[4] <- "Tienen mujeres letristas"

install.packages("quanteda")
install.packages("magrittr")

library(quanteda)
library(magrittr)

df_textos <- rbind(Barrio_Querido, Curtidores_De_Hongos, 
                   Gente_Grande, Jardin_Del_Pueblo, La_Gran_Muñeca, 
                   Queso_Magro, Un_Titulo_Viejo, Mi_Vieja_Mula, 
                   Nos_Obligan_A_Salir, Diablos_Verdes)

colnames(df_textos) <- c("doc_id", "texto", "antiguedad", "genero_letristas")

mis_stopwords <- c("abajo", "acá", "ahí", "allá", "allí", "alrededor", "aquí", 
                  "arriba", "atrás", "cerca", "debajo", "delante", "dentro", "vemos",
                  "detrás", "fuera", "encima", "enfrente", "lejos", "adelante", 
                  "además", "así", "bien", "como", "cuando", "cual", "que", "donde",
                  "ahora", "algún", "año*", "mes", "día", "huevo", "iba", "ves", 
                  "aquel", "aquello*", "bien", "buen*", "cada", "caso", "claro", 
                  "exacto", "obvio", "oh", "uh", "uy", "mm", "murga*", "carnaval",
                  "murguero", "murguista", "fiesta", "música", "popurrí", "salpicón",
                  "ser", "estar", "estoy", "estás", "sos", "vos", "tú", "yo", "palabra",
                  "dale", "bo", "vo", "papá", "pa", "menos", "más", "veces", "vez",
                  "usted", "subir", "bajar", "Maxi", "Martincito", "tema*", "un*", 
                  "dice", "digo", "dijo", "dijimos", "dijiste", "vio", "viste", "vamo",
                  "vieron", "fui", "fueron", "van", "están", "para", "por", "pou",
                  "además", "aparte", "algo", "aproximadamente", "bastante", "casi",
                  "demasiado", "incluso", "más", "menos", "mucho", "muy", "nada", "poco", 
                  "solamente", "solo", "tan", "tanto", "todo", "cien", "uno", "dos",
                  "tres", "cosas", "creemos", "creo", "cuestiones", "dar", "dan",
                  "debe", "demás", "desde", "después", "igual", "distinto", "entonces",
                  "ante", "bajo", "cabe", "con", "contra", "de", "desde", "durante",
                  "en", "este", "esto*", "entre", "hacia", "hasta", "para", "por", 
                  "según", "sin", "con", "sobre", "tras", "estas", "mediante", "hay",
                  "ver", "había", "habla*", "hace*", "haciendo", "vida", "vivi*",
                  "hicieron", "hizo", "hace", "lado", "largo", "corto", "traigo", 
                  "llevo", "bien", "mal", "manera", "forma", "cuestiones", "temas",
                  "voz", "mayor", "menor", "mil*", "nadie", "ningún", "ninguna",
                  "cuplé", "parte", "espectáculo", "otr*", "puede", "puedo", "quier*", 
                  "queremos", "quizás", "porque", "tal vez", "capaz", "realmente",
                  "saber", "sabemos", "sabe", "entend*", "también", "tampoco", "i",
                  "tal", "tiene", "tenemos", "quiere", "quieremos", "pedo", "últimos",
                  "últimas", "vamos", "van", "cuenta", "visto", "voy","alguien", 
                  "semana", "lugar", "siguiente", "anterior", "venir", "mañana",
                  "ayer", "pasa", "paso", "diciendo", "vengan", "[Música]", "reina",
                  "[Risas]", "[Aplausos]", "ay", "el", "la", "si", "no", "ellos",
                  "ellas", "ustedes", "mirá", "querés", "cómo", "cuándo", "dónde",
                  "quiénes", "quién", "dicen", "mejor", "peor", "gusta", "encanta",
                  "vas", "aunque", "siempre", "nunca", "da", "doy", "soy", "sos", 
                  "gran", "mismo", "muchas", "muchos", "poco", "pocos", "sé", "carlos",
                  "sabés", "mirá", "mira", "llegó", "llega", "ir", "volver", "vinagre",
                  "parece", "mientras", "durante", "después", "tablado", "velódromo",
                  "cuatro", "cinco", "decir", "todas", "todos", "llegamos", "llegaron",
                  "hice", "hace", "tenés", "tienen", "tengo", "tenías", "viene*", 
                  "pongo", "ponés", "sale", "salgo", "ejemplo", "pitufo", "va", "hoy",
                  "pasó", "pasa*", "toda", "todo", "pasar", "alguna", "alguno","¡",
                  "decís", "anda", "seis", "momento", "etapa", "instante", "modo",
                  "sigue*", "fin", "eh", "ah", "hola", "chau", "che", "cualquier*",
                  "nombre*", "medio", "juan", "siete", "temprano", "tarde", "favor",
                  "noche", "tarde", "sabes", "vivo", "cosa", "importa", "flor",
                  "treinta", "recién", "vayan", "pued*", "nuevo", "dej*", "sabe*",
                  "sali*", "horas", "minutos", "cuál", "ojos", "hora", "sartori-",
                  "hago", "hacen", "hicieron", "papa", "nombrar", "afuera", "adentro",
                  "salida", "llegada", "cara", "limón", "perro", "gato", "tene*",
                  "podés", "mitocondria", "tipo", "das", "viven", "onda", "pas*",
                  "formas", "meses", "años", "todavía", "carlos-", "papa-", "is", "of", "dij*",
                  "is", "of", "biden-", "misma", "cuent*", "qued*", "ven", "maría",
                  "hacé", "andá", "poné", "precis*", "necesit*", "pone", "podemos",
                  "dio", "toca*", "di", "llega*", "teatro", "muñeca", "fondo", "diablos")

toks <- tokens(df_textos$texto) %>%
        tokens_compound(phrase("lacalle pou"), concatenator = "_")

dfm_textos <- dfm(tokens(toks,
                  remove_punct = TRUE, 
                  remove_numbers = TRUE), 
                  tolower=TRUE,
                  verbose = FALSE) %>%
                  dfm_remove(pattern = c(quanteda::stopwords("spanish"),
                  mis_stopwords)) %>%
                  dfm_trim(min_termfreq = 5) %>%
                  dfm_group(groups = df_textos$antiguedad)

wordcloud_general <- quanteda.textplots::textplot_wordcloud(dfm_textos, 
                                       min.count = 2,
                                       max_words = 100,
                                       random.order = FALSE,
                                       colors = RColorBrewer::brewer.pal(8,"Dark2"),
                                       comparison = F) 

wordcloud_antiguedad <- quanteda.textplots::textplot_wordcloud(dfm_textos, 
                                       min.count = 2,max_words = 100,
                                       random.order = FALSE,
                                       colors = RColorBrewer::brewer.pal(8,"Dark2"),
                                       comparison = T)

dfm_textos <- dfm(tokens(toks,
                  remove_punct = TRUE, 
                  remove_numbers = TRUE), 
                  tolower=TRUE,
                  verbose = FALSE) %>%
                  dfm_remove(pattern = c(quanteda::stopwords("spanish"),
                  mis_stopwords)) %>%
                  dfm_trim(min_termfreq = 5) %>%
                  dfm_group(groups = df_textos$genero_letristas)

wordcloud_genero <- quanteda.textplots::textplot_wordcloud(dfm_textos, 
                                       min.count = 2,
                                       max_words = 100,
                                       random.order = FALSE,
                                       colors = RColorBrewer::brewer.pal(8,"Dark2"),
                                       comparison = T)

topwords_general = data.frame(topfeatures(dfm_textos, 15))
topwords_general$Palabra = rownames(topwords_general)
colnames(topwords_general)[1] <- "Frecuencia"
rownames(topwords_general) <- NULL

install.packages("ggplot2")
library(ggplot2)

plot_topwords_general <-  ggplot(topwords_general, 
                          aes(x = reorder(Palabra, Frecuencia), 
                              y = Frecuencia,
                              fill = Palabra)) +
                          geom_col(show.legend = FALSE) +
                          coord_flip() +
                          theme_minimal() +
                          ggtitle("Palabras más recurrentes en los textos de las murgas") +
                          ylab("Frecuencia de aparición") +
                          xlab("") +
                          scale_fill_manual(values = c(rep("#D7B5D8", 15)))
  
#Conteo y visualización de las palabras más frecuencias según antiguedad del conjunto 

df_antiguedad <- split(df_textos, df_textos$antiguedad)
df_murgas_tradicionales <- df_antiguedad[[2]]
df_murgas_nuevas <- df_antiguedad[[1]]

#Conteo y visualización de las palabras más frecuentes en los textos de las murgas tradicionales 

toks_murgas_tradicionales <- tokens(df_murgas_tradicionales$texto) %>%
                             tokens_compound(phrase("lacalle pou"), concatenator = "_")
                             
dfm_murgas_tradicionales <- dfm(tokens(toks_murgas_tradicionales,
                         remove_punct = TRUE, 
                         remove_numbers = TRUE), 
                         tolower=TRUE,
                         verbose = FALSE) %>%
                         dfm_remove(pattern = c(quanteda::stopwords("spanish"),
                         mis_stopwords)) %>% 
                         dfm_trim(min_termfreq = 5)

topwords_murgas_tradicionales = data.frame(topfeatures(dfm_murgas_tradicionales, 15))
topwords_murgas_tradicionales$Palabra = rownames(topwords_murgas_tradicionales)
colnames(topwords_murgas_tradicionales)[1] <- "Frecuencia"
rownames(topwords_murgas_tradicionales) <- NULL

plot_topwords_murgas_tradicionales <-  ggplot(topwords_murgas_tradicionales, 
                                       aes(x = reorder(Palabra, Frecuencia), 
                                       y = Frecuencia,
                                       fill = Palabra)) +
                                       geom_col(show.legend = FALSE) +
                                       coord_flip() +
                                       theme_minimal() +
                                       ggtitle("Palabras más recurrentes en los textos de las murgas con mayor trayectoria") +
                                       ylab("Frecuencia de aparición") +
                                       xlab("") +
                                       scale_fill_manual(values = c(rep("#D7B5D8", 15)))

#Conteo y visualización de las palabras más frecuentes en los textos de las murgas nuevas 

toks_murgas_nuevas <- tokens(df_murgas_nuevas$texto) %>%
                      tokens_compound(phrase("lacalle pou"), concatenator = "_")

dfm_murgas_nuevas <- dfm(tokens(toks_murgas_nuevas,
                         remove_punct = TRUE, 
                         remove_numbers = TRUE), 
                         tolower=TRUE,
                         verbose = FALSE) %>%
                         dfm_remove(pattern = c(quanteda::stopwords("spanish"),
                         mis_stopwords)) %>% 
                         dfm_trim(min_termfreq = 5)

topwords_murgas_nuevas = data.frame(topfeatures(dfm_murgas_nuevas, 15))
topwords_murgas_nuevas$Palabra = rownames(topwords_murgas_nuevas)
colnames(topwords_murgas_nuevas)[1] <- "Frecuencia"
rownames(topwords_murgas_nuevas) <- NULL

plot_topwords_murgas_nuevas <-  ggplot(topwords_murgas_nuevas, 
                                      aes(x = reorder(Palabra, Frecuencia), 
                                      y = Frecuencia,
                                      fill = Palabra)) +
                                      geom_col(show.legend = FALSE) +
                                      coord_flip() +
                                      theme_minimal() +
                                      ggtitle("Palabras más recurrentes en los textos de las murgas con menor trayectoria") +
                                      ylab("Frecuencia de aparición") +
                                      xlab("") +
                                      scale_fill_manual(values = c(rep("#D7B5D8", 15)))

#Conteo y visualización de las palabras más frecuentes según la conformación del equipo creativo en términos de género 

df_genero <- split(df_textos, df_textos$genero_letristas)
df_letristas_mujeres <- df_genero[[2]]
df_letristas_varones <- df_genero[[1]]

#Conteo y visualización de las palabras más frecuentes en los textos escritos exclusivamente por varones

toks_letristas_varones <- tokens(df_letristas_varones$texto) %>%
                          tokens_compound(phrase("lacalle pou"), concatenator = "_")

dfm_letristas_varones <- dfm(tokens(toks_letristas_varones,
                                remove_punct = TRUE, 
                                remove_numbers = TRUE), 
                                tolower=TRUE,
                                verbose = FALSE) %>%
                                dfm_remove(pattern = c(quanteda::stopwords("spanish"),
                                mis_stopwords)) %>% 
                                dfm_trim(min_termfreq = 5)

topwords_letristas_varones = data.frame(topfeatures(dfm_letristas_varones, 15))
topwords_letristas_varones$Palabra = rownames(topwords_letristas_varones)
colnames(topwords_letristas_varones)[1] <- "Frecuencia"
rownames(topwords_letristas_varones) <- NULL

plot_topwords_letristas_varones <-  ggplot(topwords_letristas_varones, 
                                      aes(x = reorder(Palabra, Frecuencia), 
                                      y = Frecuencia,
                                      fill = Palabra)) +
                                      geom_col(show.legend = FALSE) +
                                      coord_flip() +
                                      theme_minimal() +
                                      ggtitle("Palabras más recurrentes en los textos escritos exclusivamente por varones") +
                                      ylab("Frecuencia de aparición") +
                                      xlab("") +
                                      scale_fill_manual(values = c(rep("#D7B5D8", 15)))

#Conteo y visualización de las palabras más frecuentes en los textos escritos por al menos una mujer

toks_letristas_mujeres <- tokens(df_letristas_mujeres$texto) %>%
                          tokens_compound(phrase("lacalle pou"), concatenator = "_")

dfm_letristas_mujeres <- dfm(tokens(toks_letristas_mujeres,
                            remove_punct = TRUE, 
                            remove_numbers = TRUE), 
                            tolower=TRUE,
                            verbose = FALSE) %>%
                            dfm_remove(pattern = c(quanteda::stopwords("spanish"),
                            mis_stopwords)) %>% 
                            dfm_trim(min_termfreq = 5)

topwords_letristas_mujeres = data.frame(topfeatures(dfm_letristas_mujeres, 15))
topwords_letristas_mujeres$Palabra = rownames(topwords_letristas_mujeres)
colnames(topwords_letristas_mujeres)[1] <- "Frecuencia"
rownames(topwords_letristas_mujeres) <- NULL

plot_topwords_letristas_mujeres <-  ggplot(topwords_letristas_mujeres, 
                                     aes(x = reorder(Palabra, Frecuencia), 
                                     y = Frecuencia,
                                     fill = Palabra)) +
                                     geom_col(show.legend = FALSE) +
                                     coord_flip() +
                                     theme_minimal() +
                                     ggtitle("Palabras más recurrentes en los textos escritos por al menos una mujer") +
                                     ylab("Frecuencia de aparición") +
                                     xlab("") +
                                     scale_fill_manual(values = c(rep("#D7B5D8", 15)))

#Análisis de asociación de palabras

library(quanteda.textstats)

dfm_textos <- dfm(tokens(toks,
                  remove_punct = TRUE, 
                  remove_numbers = TRUE), 
                  tolower=TRUE,
                  verbose = FALSE) %>%
                  dfm_remove(pattern = c(quanteda::stopwords("spanish"),
                  mis_stopwords)) %>%
                  dfm_trim(min_termfreq = 5)

#Asociaciones de la palabra "gente"

asoc_gente <- textstat_simil(dfm_textos, selection = "gente",
                             method = "correlation",margin = "features")%>%
  as.data.frame()%>%
  dplyr::arrange(-correlation)%>%
  dplyr::top_n(12)

asoc_gente$correlation <- round(asoc_gente$correlation,2)

plot_asoc_gente <- ggplot(asoc_gente, aes(x = reorder(feature1, correlation), 
                                         y = correlation,
                                         fill = feature2)) +
                                         geom_bar(stat = "identity", position = "dodge") +
                                         geom_text(aes(label = correlation), vjust = -0.5, size = 3) +
                                         coord_cartesian(ylim = c(0.50, 1)) +
                                         xlab("") +
                                         ylab("Nivel de Correlación") +
                                         scale_fill_manual(values = c(rep("#D7B5D8", 12))) +
                                         ggtitle("Palabras correlacionadas con el término 'Gente'") +
                                         theme(legend.position="none")

#Asociaciones de la palabra "gobierno"

asoc_gobierno <- textstat_simil(dfm_textos, selection = "gobierno",
               method = "correlation",margin = "features")%>%
               as.data.frame()%>%
               dplyr::arrange(-correlation)%>%
               dplyr::top_n(12)

asoc_gobierno$correlation <- round(asoc_gobierno$correlation,2)

plot_asoc_gobierno <- ggplot(asoc_gobierno, aes(x = reorder(feature1, correlation), 
                      y = correlation,
                      fill = feature1)) +
                      geom_bar(stat = "identity", position = "dodge") +
                      geom_text(aes(label = correlation), vjust = -0.5, size = 3) +
                      coord_cartesian(ylim = c(0.50, 1)) +
                      xlab("") +
                      ylab("Nivel de Correlación") +
                      scale_fill_manual(values = c(rep("#D7B5D8", 12))) +
                      ggtitle("Palabras correlacionadas con la palabra 'Gobierno'") + 
                      theme(legend.position="none")

#Asociaciones de la palabra "lacalle"

asoc_lacalle <- textstat_simil(dfm_textos, selection = "lacalle",
                method = "correlation",margin = "features")%>%
                as.data.frame()%>%
                dplyr::arrange(-correlation)%>%
                dplyr::top_n(12)

asoc_lacalle$correlation <- round(asoc_lacalle$correlation,2)

plot_asoc_lacalle <- ggplot(asoc_lacalle, aes(x = reorder(feature1, correlation), 
                            y = correlation,
                            fill = feature1)) +
                            geom_bar(stat = "identity", position = "dodge") +
                            geom_text(aes(label = correlation), vjust = -0.5, size = 3) +
                            coord_cartesian(ylim = c(0.50, 1)) +
                            xlab("") +
                            ylab("Nivel de Correlación") +
                            scale_fill_manual(values = c(rep("#D7B5D8", 12))) +
                            ggtitle("Palabras correlacionadas con la palabra 'Lacalle'") +
                            theme(legend.position="none")

#Redes de co-ocurrencia 

library(quanteda.textplots)

base_textos = dfm_textos %>%
fcm(context = "document")

feat <- names(topfeatures(base_textos, 30))
base_textos_select <- fcm_select(base_textos, pattern = feat, selection = "keep")
size <- log(colSums(dfm_select(base_textos, feat, selection = "keep")))

plot_co_ocurrencia_general <- textplot_network(base_textos_select, 
                                     min_freq = 0.8, 
                                     vertex_size = size / max(size) * 3,
                                     edge_color="#ff9d5c") +
                                     ggtitle("Red de co-ocurrencia entre los términos más frecuentes",
                                     subtitle = "En los textos de todas las murgas")

#Redes de co-ocurrencia en los textos de murgas tradicionales

base_murgas_tradicionales = dfm_murgas_tradicionales %>%
fcm(context = "document")

feat <- names(topfeatures(base_murgas_tradicionales, 30))
base_murgas_tradicionales_select <- fcm_select(base_murgas_tradicionales, pattern = feat, selection = "keep")
size <- log(colSums(dfm_select(base_murgas_tradicionales, feat, selection = "keep")))

plot_co_ocurrencia_murgas_tradicionales <- textplot_network(base_murgas_tradicionales_select, 
                                               min_freq = 0.8, 
                                               vertex_size = size / max(size) * 3,
                                               edge_color="#ff9d5c") +
                                               ggtitle("Red de co-ocurrencia entre los términos más frecuentes",
                                               subtitle = "En los textos de las murgas de mayor trayectoria")

#Redes de co-ocurrencia en los textos de murgas nuevas

base_murgas_nuevas = dfm_murgas_nuevas %>%
fcm(context = "document")

feat <- names(topfeatures(base_murgas_nuevas, 30))
base_murgas_nuevas_select <- fcm_select(base_murgas_nuevas, pattern = feat, selection = "keep")
size <- log(colSums(dfm_select(base_murgas_nuevas, feat, selection = "keep")))

plot_co_ocurrencia_murgas_nuevas <- textplot_network(base_murgas_nuevas_select, 
                                                            min_freq = 0.8, 
                                                            vertex_size = size / max(size) * 3,
                                                            edge_color="#ff9d5c") +
                                                            ggtitle("Red de co-ocurrencia entre los términos más frecuentes",
                                                            subtitle = "En los textos de las murgas de menor trayectoria")

#Redes de co-ocurrencia en los textos escritos exclusivamente por hombres

base_letristas_varones = dfm_letristas_varones %>%
fcm(context = "document")

feat <- names(topfeatures(base_letristas_varones, 30))
base_letristas_varones_select <- fcm_select(base_letristas_varones, pattern = feat, selection = "keep")
size <- log(colSums(dfm_select(base_letristas_varones, feat, selection = "keep")))

plot_co_ocurrencia_letristas_varones <- textplot_network(base_letristas_varones_select, 
                                                     min_freq = 0.8, 
                                                     vertex_size = size / max(size) * 3,
                                                     edge_color="#ff9d5c")+
                                                     ggtitle("Red de co-ocurrencia entre los términos más frecuentes",
                                                     subtitle = "En textos escritos exclusivamente por varones")

#Redes de co-ocurrencia en los textos escritos por al menos una mujer

base_letristas_mujeres = dfm_letristas_mujeres %>%
fcm(context = "document")

feat <- names(topfeatures(base_letristas_mujeres, 30))
base_letristas_mujeres_select <- fcm_select(base_letristas_mujeres, pattern = feat, selection = "keep")
size <- log(colSums(dfm_select(base_letristas_mujeres, feat, selection = "keep")))

plot_co_ocurrencia_letristas_mujeres <- textplot_network(base_letristas_mujeres_select, 
                                                         min_freq = 0.8, 
                                                         vertex_size = size / max(size) * 3,
                                                         edge_color="#ff9d5c") +
                                                         ggtitle("Red de co-ocurrencia entre los términos más frecuentes",
                                                         subtitle = "En textos escritos por al menos una mujer")
#Análisis con diccionario propio

dict <- dictionary(list(
  economia = c("aumento*","tarifa*", "OSE", "UTE", "Antel", "hambre", "alimento*", 
               "comida", "compr*", "caro*", "barato*", "precio*", "pobre*", "pobreza",
               "recorte*", "presupuesto", "caja", "plata", "guita", "mango*", "dólar*",
               "inversión*", "gasto", "sueldo", "salario", "ajuste*", "rico*", 
               "millonario*", "economia", "financier*"),
  seguridad = c("narcos","cárcel", "prisión", "robo*", "delincuente*", "arma*", 
                "muerte*", "violencia", "femicidio*", "homicidio*", "militar*",
                "chorro*", "droga*","miedo", "temor", "inseguridad", "boca*", 
                "policia*", "seguridad","patrullero", "comisaria"),
  educacion = c("escuela*", "liceo*", "colegio", "alumno*", "udelar",
                "maestro*", "maestra*", "docente*", "educativa", "enseñar",
                "aprender", "guri*", "niñ*", "estudiante*", "estudi*", 
                "materia*", "asignatura*", "libro*"),
  genero = c("varon*", "hombre*", "mujer*","genero", "femicidio*", "viola*", 
             "muertas", "abusada*", "abusador*", "violento*", "insegura*", "sorora*",
             "puta*", "prostitucion", "prostituta*", "aboli*", "regulacionismo", 
             "abolicionismo", "trata", "cliente*", "abuso*", "acoso", "acosad*", 
             "patriarcado", "machista*", "machismo")))
  

dict_result <- dfm_lookup(dfm_textos, dict, nomatch = "no_aparece")
dict_result <- convert(dict_result, to = "data.frame") 
dict_result$doc_id <- df_textos$doc_id 
dict_result$antiguedad <- df_textos$antiguedad 
dict_result$genero_letristas <- df_textos$genero_letristas

install.packages("reshape2")
library(reshape2)

tabla_dict_result_antiguedad <- dict_result %>%
            group_by(antiguedad) %>%
                     summarise(economia = sum(economia), 
                     economia_prop = sum(economia)/sum(economia, seguridad, educacion, genero, no_aparece)*100,
                     seguridad = sum(seguridad), 
                     seguridad_prop = sum(seguridad)/sum(economia, seguridad, educacion, genero, no_aparece)*100,
                     educacion = sum(educacion),
                     educacion_prop = sum(educacion)/sum(economia, seguridad, educacion, genero, no_aparece)*100,
                     genero = sum(genero),
                     genero_prop = sum(genero)/sum(economia, seguridad, educacion, genero, no_aparece)*100)

tabla_dict_result_antiguedad <- tabla_dict_result_antiguedad[c(1,2,4,6,8)]
melted_table_dict_antiguedad <- melt(tabla_dict_result_antiguedad, id.vars="antiguedad")
plot_table_dict_antiguedad <- ggplot(melted_table_dict_antiguedad, 
                                     aes(x=variable, y=value, fill=variable)) + 
                                     geom_col() +
                                     theme_classic() +
                                     facet_grid(~antiguedad) +
                                     labs(x="Núcleos temáticos",
                                          y="Cantidad de referencias") +
                                     theme(legend.position="none")

tabla_dict_result_genero <- dict_result  %>%
            group_by(genero_letristas)%>%
                      summarise(economia = sum(economia), 
                      economia_prop = sum(economia)/sum(economia, seguridad, educacion, genero, no_aparece)*100,
                      seguridad = sum(seguridad), 
                      seguridad_prop = sum(seguridad)/sum(economia, seguridad, educacion, genero, no_aparece)*100,
                      educacion = sum(educacion),
                      educacion_prop = sum(educacion)/sum(economia, seguridad, educacion, genero, no_aparece)*100,
                      genero = sum(genero),
                      genero_prop = sum(genero)/sum(economia, seguridad, educacion, genero, no_aparece)*100)

tabla_dict_result_genero <- tabla_dict_result_genero[c(1,2,4,6,8)]
melted_table_dict_genero <- melt(tabla_dict_result_genero, id.vars="genero_letristas")
plot_table_dict_genero <- ggplot(melted_table_dict_genero, 
                                     aes(x=variable, y=value, fill=variable)) + 
                                     geom_col() +
                                     theme_classic() +
                                     facet_grid(~genero_letristas) +
                                     labs(x="Núcleos temáticos",
                                         y="Cantidad de referencias") +
                                     theme(legend.position="none")

#Análisis con diccionario creado a partir del paquete "puy"

remotes::install_github("Nicolas-Schmidt/puy")
library(puy)

politicos_uy <- buscar_puy()$politico

politicos_uy <- paste0(sapply(strsplit(politicos_uy, ","), "[[", 1), ",")

politicos_uy <- tolower(politicos_uy)

dict_politicos <- dictionary(list(politicos = politicos_uy))

dfm_textos <- dfm(tokens(df_textos$texto,
                         remove_punct = TRUE, 
                         remove_numbers = TRUE), 
                         tolower=TRUE,
                         verbose = FALSE) %>%
                         dfm_remove(pattern = c(quanteda::stopwords("spanish"),
                         mis_stopwords)) %>%
                         dfm_trim(min_termfreq = 5)

dict_politicos_result <- dfm_lookup(dfm_textos, dict_politicos, nomatch = "no_aparece")

dict_politicos_result <- convert(dict_politicos_result, to = "data.frame") 

dict_politicos_result$doc_id <- df_textos$doc_id 
dict_politicos_result$antiguedad <- df_textos$antiguedad 
dict_politicos_result$genero_letristas <- df_textos$genero_letristas

tabla_dict_politicos_antiguedad <- dict_politicos_result %>%
                                   group_by(antiguedad) %>%
                                   summarise(politicos= sum(politicos))

tabla_dict_politicos_genero <- dict_politicos_result %>%
                               group_by(genero_letristas) %>%
                               summarise(politicos= sum(politicos))

politicos_contexto <- kwic(tokens(df_textos$texto), dict_politicos, window=10)



#Análisis de sentimiento con el diccionario LWIC

lwic <- readRDS("C:/Users/Usuario/Desktop/R aplicado al análisis cualitativo/Entrega/EmoPosNeg_SPA.rds")
lwic_result <- dfm_lookup(dfm_textos, dictionary = lwic)
lwic_result <- convert(lwic_result, to = "data.frame") 
lwic_result$doc_id <- df_textos$doc_id 
lwic_result$antiguedad <- df_textos$antiguedad 
lwic_result$genero_letristas <- df_textos$genero_letristas

lwic_result$puntaje <- lwic_result$EmoPos-lwic_result$EmoNeg
lwic_result$sentimiento=ifelse(lwic_result$puntaje<0,"Negativo","Positivo")
lwic_result$sentimiento=ifelse(lwic_result$puntaje==0,"Neutral",lwic_result$sentimiento)

tabla_lwic_result_antiguedad <- lwic_result %>%
                                group_by(antiguedad) %>%
                                summarise(emociones_positivas = sum(EmoPos),
                                          emociones_negativas = sum(EmoNeg),
                                          puntaje = sum(puntaje)) 

melted_table_antiguedad <- melt(tabla_lwic_result_antiguedad, id.vars="antiguedad")

plot_lwic_antiguedad <- ggplot(melted_table_antiguedad, aes(x=variable, y=value, fill=variable)) + 
                                geom_col() +
                                labs(x="Emociones",
                                     y="Cantidad de referencias") +
                                scale_fill_discrete(labels=c("Emociones positivas", 
                                                             "Emociones negativas", 
                                                             "Diferencia entre ambas")) +
                                theme_classic() +
                                facet_grid(~antiguedad) +
                                theme(legend.position="none")

tabla_lwic_result_genero <- lwic_result %>%
  group_by(genero_letristas) %>%
  summarise(emociones_positivas = sum(EmoPos),
            emociones_negativas = sum(EmoNeg),
            puntaje = sum(puntaje))

melted_table_genero <- melt(tabla_lwic_result_genero, id.vars="genero_letristas")

plot_lwic_genero <- ggplot(melted_table_genero, aes(x=variable, y=value, fill=variable)) + 
                            geom_col() +
                            labs(x="Emociones",
                                 y="Cantidad de referencias") +
                            scale_fill_discrete(labels=c("Emociones positivas", 
                                                         "Emociones negativas", 
                                                         "Diferencia entre ambas")) +
                            theme_classic() +
                            facet_grid(~genero_letristas) +
                            theme(legend.position="none")
