#------------------------------------------------------------------------------#
#           Recuperación y análisis de texto con R                             # 
#                  Educación Permanente FCS                                    #
#                         Clase 2                                              # 
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
transcribopdf <- ocr("Clase2/Material/analesUruguay.pdf",engine = espanol) #  devuelve vector

tabla=ocr_data("Clase2/Material/analesUruguay.pdf",engine = espanol) # devuelve tibble (dataframe)

# unifico el texto en un vector
texto2 <- stringr::str_c(tabla$word, collapse = " ") # colapso los tres elementos del vector separando por un espacio


#### EJERCICIO 1 ----

# Ejercicio 1

## Reconocimiento óptico de caracteres

# 1. Replicar el OCR para la imagen _analesUruguay3_ y __marcha_1973__

# 2. Hacer la tabla de ambas 


# Solucion
# transcribopng <- ocr("Clase2/Material/analesUruguay_3.png",engine = espanol)
# tablapng=ocr_data("Clase2/Material/analesUruguay_3.png",engine = espanol)

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

url %>% read_html() %>% # aplico la función de leer el contenido html sin guardarla en un objeto
  html_elements(css = '.wikitable') %>% # selecciono un estilo css específico que es el de las tablas
  html_table() # función que convierte la extracción en una tabla de r
## como no asigné este código a ningún objeto, se va a imprimir en la consola


#### EJERCICIO 2 ----

## Scrapeo web con rvest

# 1. Descargar noticias o información de otra web
# 2. Scrapear dos elementos html diferentes 

#------------------------------------------------------------------------------#

#### Scrapeo parlamentario ----

##Instalar última versión dev de speech desde github 
##remotes::install_github("Nicolas-Schmidt/speech")

##Instalar PUY 
##remotes::install_github("Nicolas-Schmidt/puy")


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


## 3. Prensa digital ----

#### gdeltr2 ----

#Instalación
# devtools::install_github("hafen/trelliscopejs")
# devtools::install_github("abresler/gdeltr2")

library(gdeltr2)

##ver paises dominios

loc = gdeltr2::dictionary_country_domains()



articulos = gdeltr2::ft_v2_api(
  terms = c("Messi"),
  modes = c("ArtList"),
  visualize_results = F,
  timespans = "55 days",
  source_countries = "AR"
)


##mode:"TimelineVol" o "TimelineVolInfo"

intensidad = gdeltr2::ft_v2_api(
  terms = c("Messi"),
  modes = c("TimelineVol"),
  visualize_results = F,
  timespans = "1 days",
  source_countries = "AR"
)

intensidad_info = gdeltr2::ft_v2_api(
  terms = c("Messi"),
  modes = c("TimelineVolInfo"),
  visualize_results = F,
  timespans = "55 days",
  source_countries = "AR"
)

tono_diario = gdeltr2::ft_v2_api(
  terms = c("Kirchner"),
  modes = c("TimelineTone"),
  visualize_results = F,
  timespans = "30 days",
  source_countries = "AR"
)


##Indicadores de inestabilidad

inestabilidad_zona <-
  gdeltr2::instability_api_locations(
    location_ids = c("UP"),
    use_multi_locations = c(F),
    variable_names = c('instability', 'tone', 'protest', 'conflict','artvolnorm'),
    time_periods = c('daily'),
    nest_data = F,
    days_moving_average = NA,
    return_wide = T,
    return_message = F,
    visualize = T
  )

inestabilidad_zona[1]

##busqueda por temas

##recupero códigos
df_gkg <-
  gdeltr2::dictionary_ft_codebook(code_book = "gkg")


tema =  gdeltr2::ft_v2_api(gkg_themes = "WB_2901_GENDER_BASED_VIOLENCE",modes = c("Artlist"),
                  visualize_results = F,
                  timespans = "55 days")


ultimo = gdeltr2::ft_trending_terms("http://data.gdeltproject.org/gdeltv2/20230629031500.translation.export.CSV.zip")

#### EJERCICIO 4 ----

# 1. Aplicar dos de las funciones vistas sobre un tema diferente  

#------------------------------------------------------------------------------#



# ##mode:"ArtList" (listado de artículos)
# 
# articulos = gdeltr2::ft_v2_api(
#   terms = c("Lacalle Pou"),
#   modes = c("ArtList"),
#   visualize_results = F,
#   timespans = "55 days",
#   source_countries = "UY"
# ) 
# 
# articulos_comb  = gdeltr2::ft_v2_api(
#   terms = c('"gobierno" corrupción'),
#   modes = c("ArtList"),
#   visualize_results = F,
#   timespans = "55 days",
#   source_countries = "UY")
# 
# 
# 
# ##mode:"TimelineVol" o "TimelineVolInfo"
# 
# intensidad = gdeltr2::ft_v2_api(
#   terms = c("astesiano"),
#   modes = c("TimelineVol"),
#   visualize_results = F,
#   timespans = "55 days",
#   source_countries = "UY"
# ) 
# 
# intensidad_info = gdeltr2::ft_v2_api(
#   terms = c("Lacalle Pou"),
#   modes = c("TimelineVolInfo"),
#   visualize_results = F,
#   timespans = "55 days",
#   source_countries = "UY"
# ) 
# 
# ##mode:"TimelineTone" 
# 
# tono_diario = gdeltr2::ft_v2_api(
#   terms = c("Lacalle Pou"),
#   modes = c("TimelineTone"),
#   visualize_results = F,
#   timespans = "30 days",
#   source_countries = "UY"
# ) 
# 
# ##mode:"ToneChart" 
# 
# tonos = gdeltr2::ft_v2_api(
#   terms = c("Lacalle Pou"),
#   modes = c("ToneChart"),
#   visualize_results = F,
#   timespans = "30 days",
#   source_countries = "UY"
# ) 


##mode:"ArtList" (listado de artículos)

