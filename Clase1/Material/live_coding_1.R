#------------------------------------------------------------------------------#
#           Recuperación y análisis de texto con R                             # 
#                  Educación Permanente FCS                                    #
#                         Clase 1                                              # 
#                      Live coding                                             #
#------------------------------------------------------------------------------#

# 1. R y Rproj ----

# Ejercicio 1 ----

## Creación de proyectos 

## Quienes tienen usuario/a de github:

# 1. Clonar el repositorio del curso https://github.com/elinagomez/analisistextoEPUdelar2023 en su pc local
# 2. Abrir el archivo del proyecto analisistextoEPUdelar2023.Rproj 
# 3. Abrir el archivo live_coding_1.R alojado en la carpeta Clase1/Material

## Quienes no tienen usuario/a de github:

# 1. Descargar el repositorio del curso de https://github.com/elinagomez/analisistextoEPUdelar2023 
##(Code y luego download Zip) descomprimirlo y alojarlo en una carpeta local denominada analisistextoEPUdelar2023 
# 2. Abrir el archivo del proyecto analisistextoEPUdelar2023.Rproj 
# 3. Abrir el archivo live_coding_1.R alojado en la carpeta Clase1/Material


#-----------------------------------------------------------------------------#

# 2. Generalidades de Tidyverse ----

# agregación de atributos 
library(tidyverse) # tidyverse
load("Clase1/Material/world.Rdata") # cargo base de datos 

# base
aggregate(pop ~ continent,
          FUN = sum,
          data = world,
          na.rm = TRUE)

# tidyverse
group_by(world, continent) %>%
  summarize(pop = sum(pop, na.rm = TRUE))

# población y número de países del mundo
world %>%
  summarize(pop = sum(pop, na.rm = TRUE), # sumo la población y la guardo en la variable pop
            n_countries = n()) # cuento el número de filas porque sabemos que cada fila corresponde a un país diferente y la guardo en la variable n_countries

# tres continentes más poblados y numero de países
world %>% 
  dplyr::select(pop, continente = continent) %>% # con select() selecciono columnas de población y continente (traducida al espacñol)
  dplyr::group_by(continente) %>% # con group_by() agrupo por continente
  dplyr::summarize(población = sum(pop, na.rm = TRUE), # con sum() sumo la pop de cada grupo y la guardo en la variable población
                   n_paises = n()) %>%  # con n() cuento el número de filas por continente y lo guardo en la variable n_paises (sabemos que cada fila corresponde a un país diferente)
  dplyr::slice_max(n = 3, order_by = población) # slice_max: función que permite seleccionar las primeras filas de acuerdo al orden de una variable 


# Ejercicio 2 ----

## Tidyverse

#- Cargar la base world en formato RData

#- Imprimir una tabla con los tres continentes con mayor territorio 


#-----------------------------------------------------------------------------#

# 3. Stringr ----

## funciones para separar una cadena
x <- "Este es un curso de Recuperacion y analisis de texto con R"

# divido por espacio en blanco
str_split(x, " ")  # string, pattern

# la cadena puede ir en el argumento string sin crear un objeto previo
str_split("Este es un curso de Recuperacion y analisis de texto con R", " ") 

# variante con regex
str_split(x, "\\s") # string, pattern
# otra variante divido por palabra
str_split(x, boundary("word")) #string, boundary(tipos: character, line_break, sentence, word)


## funciones para combinar cadenas una cadena

x <- "Este es un curso de Recuperacion y analisis de texto con R"
y <- "Es un curso de educación permanente."

# combino los vectores con un punto seguido de un espacio
str_c(x, y, sep = ". ") # string1, string2, separador

## funciones para reemplazar un texto:

x <- "Este es un curso de Recuperacion y analisis de texto con R"

# reemplazo primera ocurrencia de "de" por un .
str_replace(x, "de", ".") # string, pattern, replacement 

# reemplazo todas las ocurrencias de "de" por un .
str_replace_all(x, "de", ".") # string, pattern, replacement

## funciones para pasar mayúscula/minúscula:

x <- "Este es un curso de Recuperacion y analisis de texto con R"

# paso a mayuscula
str_to_upper(x) # string

# paso a minuscula
str_to_lower(x) # string


# funciones para eliminar espacios en blanco:
  
# elimino espacios al inicio de la cadena
x <- "  Este es un curso de Recuperacion y analisis de texto con R  "

str_trim(x, side = "left") # string, side = c("both", "left", "right")

# elimino espacios al inicio y final de la cadena
str_trim(x) # por defecto side = both


# elimino espacios al inicio y final de la cadena y reemplaza a un espacio el resto 
# str_squish(string)
str_squish(" Este es un   curso de Recuperacion   y analisis de texto con R\t")



# Ejemplo extrayendo un texto de internet:

library(readtext)
url_texto <- "https://www.ingenieria.unam.mx/dcsyhfi/material_didactico/Literatura_Hispanoamericana_Contemporanea/Autores_B/BENEDETTI/Poemas.pdf"
# Extraemos el texto
mario <- readtext(url_texto)

library(stringr)

# divido el texto en oraciones

# usando %>% 
mario_sentencias <- str_split(mario$text, boundary("sentence"))%>% # divido el texto en oraciones
  unlist()%>% # convierto el texto en un vector
  str_trim("both") # elimino espacios

# sin %>% 
mario_sentencias2 <- str_trim(unlist(str_split(mario$text, boundary("sentence"))), "both") 

# compruebo que son iguales
identical(mario_sentencias, mario_sentencias2)


# Ejercicio 3 ----

# 1. Elija, descargue o cree un vector de character 

# 2. Aplique al menos tres funciones de las vistas de forma separada

# 3. Simplifique el ejercicio anterior utilizando el %>% 


#-----------------------------------------------------------------------------#

# 4. Caracteres especiales y expresiones regulares ----

## Cuantificadores

vec <- c("AB", "A1B", "A11B", "A111B", "A1111B", "A2B", "A1q2")

str_detect(vec, "A1*B") # `*` : coincide al menos 0 veces.
#detecta coincidencia siempre que a una A le siga una B 
#y en los casos en que una A y una B estén separadas por 1 o muchos 1.
#Si hay algún otro caracter en el medio no detecta coincidencia

str_detect(vec, "A1+B") # `+` : coincide al menos 1 vez.
#detecta coincidencia siempre que una A y B estén separadas por 1 o muchos 1.
#Si hay ninguno o algún otro caracter en el medio no detecta coincidencia

str_detect(vec, "A1?B")
#detecta coincidencia siempre que una A y B estén juntas o separadas por un 1.
#Si algún otro caracter o más de un 1 en el medio no detecta coincidencia

## Posición

vec <- c("abxxxx", "xxxxabxxxx", "xxxxxab")

str_detect(vec, "^ab") # ^: inicio
#detecta coincidencia sólo cuando "ab" está al inicio de la cadena

str_detect(vec, "ab$") # $: final
#> #detecta coincidencia sólo cuando "ab" está al final de la cadena


## Clases

vec <- c("12345", "hola", "HOLA", "Hola", "Hola12345", "$#&/(#")

str_detect(vec, "[[:alnum:]]")
#detecta coincidencia si hay caracteres alfanuméricos

str_detect(vec, "[[:digit:]]")
str_detect(vec, "\\d")
str_detect(vec, "[0-9]")
#detecta coincidencia si hay números

str_detect(vec, "[[:alpha:]]")
str_detect(vec, "[A-z]")
#detecta coincidencia si hay letras

str_detect(vec, "[A-Z]")
#detecta coincidencia si hay letras mayusculas

str_detect(vec, "[a-z]")
#detecta coincidencia si hay letras minúsculas

## Expresiones regulares
vec <- c("12312342312345", "hola", "HOLA", "Hola", "Hola12345", "$#&/(#")

str_detect(vec, "^[A-Z].*\\d$") # inicio mayuscula, fin número, pueden existir caracteres en medio

#-----------------------------------------------------------------------------#

# Material Extra: Manipulación de cadenas (base) ----


# Usa la función print
print("hello world")

# Determina una variable como un vector de texto
x <- "Woods Hole Research Center"
x

# Consulta el length del vector creado
length(x)

# Cantidad de caracteres
nchar(x)

# Concatena vectores usando "print" y "paste"
x <- "hola mundo, yo soy "
y <- "de"
z <- " Uruguay."

print(paste(x, y, z, sep = ""))

# cortando un vector de texto .
x <- "mi nombre es Elina"
x

substr(x, 14, 20)

# recortando texto por un separador - resulta una lista.
x <- "/Users/elinagomez/Documents/archivo.txt"
z <- strsplit(x, "/")
z
class(z)

# para quedarnos con el tercer elemento de lo recortado.
z[[1]][3]

# O, se puede usar la función "unlist" quedando cada elemento como parte de un vector.
z <- unlist(strsplit(x, "/"))
z
z[3]
class(z)

# Creando el nombre de un nuevo archivo a partir de los archivos existentes.

unlist(strsplit(x, "\\."))
newfile <- paste(unlist(strsplit(x, "\\."))[1], "_nuevo.txt", sep = "")
newfile

# grep

#Crea una variable, messages. Asignando cuatro valores a la variable.

messages <- c("apple", "pear", "banana", "orange")

codigos$coding=gsub("@","",codigos$coding)


#Usa grep para imprimir los valores en messages que contengan una 'g'

grep("g", messages, value = TRUE)


