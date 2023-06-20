#------------------------------------------------------------------------------#
#           Recuperación y análisis de texto con R                             # 
#                  Educación Permanente FCS                                    #
#                         Clase 1                                              # 
#                      Live coding                                             #
#------------------------------------------------------------------------------#


## Manipulación de strings

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




##Stringr

library(readtext)
url_texto <- "https://www.ingenieria.unam.mx/dcsyhfi/material_didactico/Literatura_Hispanoamericana_Contemporanea/Autores_B/BENEDETTI/Poemas.pdf"
# Extraemos el texto
mario <- readtext(url_texto)

library(stringr)

mario_sentencias=str_split(mario$text, "\n")%>%
  unlist()%>%
  str_trim("both")

unlist(str_split(mario_sentencias, boundary("sentence")))

##type = c("character", "sentence", "word")

str_c("x", "y", sep = ", ")
#> [1] "x, y"

#la primer coincidencia
str_replace(string, pattern, replacement) 

#todas las coincidencias
str_replace_all(string, pattern, replacement)


str_to_upper(c("i", "ı"))
#> [1] "I" "I"

str_to_lower(c("I", "I"))
#> [1] "i" "ı"

str_trim(string, side = c("both", "left", "right"))

str_trim(" String with trailing and leading white space ")
#> [1] "String with trailing and leading white space"
str_trim("\n\nString with trailing and leading white space\n\n")
#> [1] "String with trailing and leading white space"


str_squish(" String with trailing, middle,   and leading white space\t")
# #> [1] "String with trailing, middle, and leading white space"



#### EJERCICIOS ----

#- Cargar la base word en formato RData

#-  Agregar atributos con dplyr

#- Imprimir una tabla con los tres continentes más poblados

#- Abrir un texto de la web con readtext

#- Aplicar las funciones vistas de scringr





