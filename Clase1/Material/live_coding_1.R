#------------------------------------------------------------------------------#
#           Recuperación y análisis de texto con R                             # 
#                  Educación Permanente FCS                                    #
#                         Clase 1                                              # 
#                      Live coding                                             #
#------------------------------------------------------------------------------#

# 1. R y Rproj ----

# Ejercicio 1 ----

## Creación de proyectos 

# Quienes tienen usuario de github:

# 1. Clonar el repositorio del curso en su pc local
# 2. Abrir el archivo live_coding_1.R alojado en la carpeta Clase 1

# Quienes no tienen usuario de github:

# 1. Descargar el repositorio, descomprimirlo y alojarlo en una carpeta denominada analisistextoEPUdelar2023
# 2. Abrir el archivo live_coding_1.R alojado en la carpeta Clase 1

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
str_c(x, y, sep = ". ") # string1, string2, sep (para controlar)

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

mario_sentencias=str_split(mario$text, "\n")%>%
  unlist()%>%
  str_trim("both")

unlist(str_split(mario_sentencias, boundary("sentence")))

# Ejercicio 3 ----

# 1. Elija, descargue o cree un vector de character 

# 2. Aplique al menos tres funciones de las vistas de forma separada

# 3. Simplifique el ejercicio anterior utilizando el %>% 


# ##type = c("character", "sentence", "word")
# 
# str_c("x", "y", sep = ", ")
# #> [1] "x, y"
# 
# #la primer coincidencia
# str_replace(string, pattern, replacement) 
# 
# #todas las coincidencias
# str_replace_all(string, pattern, replacement)
# 
# 
# str_to_upper(c("i", "ı"))
# #> [1] "I" "I"
# 
# str_to_lower(c("I", "I"))
# #> [1] "i" "ı"
# 
# str_trim(string, side = c("both", "left", "right"))
# 
# str_trim(" String with trailing and leading white space ")
# #> [1] "String with trailing and leading white space"
# str_trim("\n\nString with trailing and leading white space\n\n")
# #> [1] "String with trailing and leading white space"
# 
# 
# str_squish(" String with trailing, middle,   and leading white space\t")
# # #> [1] "String with trailing, middle, and leading white space"






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


