#------------------------------------------------------------------------------#
#           Recuperación y análisis de texto con R                             # 
#                  Educación Permanente FCS                                    #
#                         Clase 1                                              # 
#                      Live coding                                             #
#------------------------------------------------------------------------------#

# CLASE 1 - INTRODUCCION, TIDYVERSE Y STRINGS ----

# Clase 1
# Usamos R: ejercicios prácticos
#_Construcción y guardado de objetos:_

# * Creamos un objeto llamado 'dias' (sin tilde) que contenga los días a la semana, usamos la función _c()_
# * Creamos un objeto llamado 'curso' que contenga 0 y 1, donde los 1 se ubiquen en la posición que se encuentran lunes y miércoles, usamos la función _c()_
# * Combinamos ambos vectores en un nuevo objeto llamado 'datos', usamos la función _cbind()_ 
# * Reescribimos el objeto 'datos' y lo convertimos en data.frame con la función _as.data.frame_.
# * Inspeccionamos la dimensión de 'datos', el nombre de las variables y realizamos una tabla de la segunda variable. Usamos las siguientes funciones: _dim()_, _names()_, _table()_.
# * Exportamos el objeto a un archivo *csv*, usamos la función _write.csv()_.

#_Exploración:_

# # * Abrimos el _data.frame_ **cars** que viene pre-cargada en el paquete **base** y le asignamos el nombre **autos**; la abrimos en el visualizador.
# # * Averiguamos el valor máximo y mínimo que tiene la variable **speed**.
# # * Exploramos la cantidad de filas y columnas que tiene la base
# # * Aplicar las funciones del tipo _is.x()_ y _as.x()_ que sirven para verificar si un objeto es de tal tipo y para convertir un tipo de objeto en otro, respectivamente.
# 
# #_Manipulación:_
# 
# # * Hacemos una nueva base únicamente con los datos que tengan un valor en la variable dist mayor a 40. subset()
# # * Hacemos la suma de las columnas de la base **autos** con la función apply y las pegamos al final de la base.
# # * Creamos otra variable **dist_rec** que distinga tres tramos de **dist**: <20,>=20 & <=40, >=41
# 
# 
# #_Presentación:_
# 
# # * Hacemos una tabla de frecuencias de la variable **dist_rec**
# # * Hacemos un gráfico de barras de las frecuencias de **dist_rec**
# 
# 
# 
### Agregación de atributos
## Ejercicio con dplyr
## library(dplyr)


##1.Cargar la base word en formato RData
##2. Agregar atributos con base y con dplyr
##3. Imprimir una tabla con los tres continentes más poblados



