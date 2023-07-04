#------------------------------------------------------------------------------#
#           Recuperación y análisis de texto con R                             # 
#                  Educación Permanente FCS                                    #
#                         Clase 4                                              # 
#                      Live coding                                             #
#------------------------------------------------------------------------------#




##1. Atributos - la libreria **RQDA** ####
library(RQDA)
#Código para abrir la interface
RQDA()


## Resumen de los códigos

#La función summaryCodings() nos devuelve una lista con:

#Número de codificaciones por código
num_cod=summaryCodings()[[1]] 

#Número de caracteres asociados a cada código
num_caract=summaryCodings()[[2]] 

#Número de archivos asociados a cada código
num_archivos=summaryCodings()[[3]] 


## Tabla con codificaciones

tabla_cods=getCodingTable()


## Codificación por palabra

codingBySearch("taxi", fid=1, cid=1, seperator = "[.!?]") 

#fid - número de archivo
#cid - número de código
#seperator - ("\n" ; "[.!?]")


## Relación entre archivos y códigos

t(filesByCodes())

## Búsqueda de códigos

#obtengo
codigos=getCodingsByOne(7)


#Para hacer búsquedas cruzadas
codigos_dos=getCodingsByOne(1) %or% getCodingsByOne(8)

#podría ser: %and%; %or%; %not%


## Co-ocurrencia de códigos

#Busca la co-ocurrencia entre los códigos que se seleccionen por vector o seleccionando

crossTwoCodes(relation = "exact", data=tabla_cods, cid1 = 1, cid2 = 9)

#relation=c("overlap","inclusion","exact","proximity")



## Exporto a HTML

#Exporto los archivos codificados
exportCodedFile("Clase4/Material/archivos_insercion.html", fid = 1)

#Exporto los códigos
exportCodings("Clase4/Material/codigos_insercion.html")


##extraer citas tabuladas 

tabla=RQDA::getCodingTable()

out = vector("list", length = max(tabla$cid))


for(i in 1:max(tabla$cid)) {         
  out[[i]] <- rbind(RQDA::getCodingsByOne(i) )
  
}

data = do.call(rbind, out)



devtools::install_github("stats4sd/RQDAPlus", upgrade = "always")

RQDAPlus::RQDAPlus("C:/Users/Usuario/Downloads/Final Analisis.VersionMAca.rqda")



#1. Abrir el proyecto _clase_4_Ejemplo_Acoso.rqda_

library(RQDA)
RQDA()


#2. Crear dos categorías con dos códigos en cada una y citas asociadas

#3. Averiguar el número de caractéres asociado a cada código

resumen=summaryCodings()
resumen=resumen[[2]]

#4. En la interface, hacer un plot de las categorías y códigos


#5. Hacer un data.frame _cods_ con los códigos asociados a cada documento.


cods = getCodingTable()[,4:5]

#6. Hacer un gráfico con la frecuencia de los códigos asociados a cada documento

library(ggplot2)

ggplot(cods, aes(codename, fill=filename)) + geom_bar(stat="count") + 
  facet_grid(~filename) + coord_flip() + 
  theme(legend.position = "none") + 
  ylab("Frecuencia de códigos por documento") + xlab("Códigos")


RQDAPlus::RQDAPlus("Clase4/Material/clase_4_Ejemplo_Acoso.rqda")


##Abrir archivos masivos
# 
#  fa <- search_tweets("@Frente_amplio", n = 100, include_rts = FALSE)
#  #Encoding(fa$text)="UTF-8"
# # 
# lista = setNames(as.list(fa$text), fa$status_id)
# # 
# RQDA::write.FileList(lista) 


# # Ejercicio 1
# 
# ## RQDA
# 
# 1. Abrir el proyecto _clase_4_Ejemplo_Acoso.rqda_
# 
# 2. Crear dos categorías con dos códigos en cada una y citas asociadas
# 
# 3. Averiguar el número de caractéres asociado a cada código
# 
# 4. Hacer un plot de las categorías y códigos
# 
# 5. Hacer un data.frame _cods_ con los códigos asociados a cada documento.
# 
# 6. Hacer un gráfico con ggplot con la frecuencia de los códigos asociados a cada documento
