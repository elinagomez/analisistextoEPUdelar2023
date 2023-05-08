
################ RECOGIDA DE DATOS #####################

#Hacemos scrpaing de las notas que abordan conflictividad laboral en el medio informativo La Diaria durante la segunda quincena de agosto de 2021
#Instalamos rvest para...
#Idicar título, copete y parte de la nota según el sector seleccionado del SelectorGadget


library(dplyr)
library(rvest)
library(readtext)

#Clipping1

ladiaria1708a = rvest:: read_html("https://ladiaria.com.uy/politica/articulo/2021/8/este-miercoles-hay-paro-de-cofe-cuales-son-los-servicios-afectados-y-por-donde-ira-la-caravana/")
ladiaria1708a = read_html("https://ladiaria.com.uy/politica/articulo/2021/8/este-miercoles-hay-paro-de-cofe-cuales-son-los-servicios-afectados-y-por-donde-ira-la-caravana/")
titulo1 = ladiaria1708a %>% 
  html_nodes(".after_foto")%>%
  html_text()

ladiaria1708a = read_html ("https://ladiaria.com.uy/politica/articulo/2021/8/este-miercoles-hay-paro-de-cofe-cuales-son-los-servicios-afectados-y-por-donde-ira-la-caravana/")
copete1 = ladiaria1708a %>% 
  html_nodes(".article__deck")%>%
  html_text()

ladiaria1708a = read_html("https://ladiaria.com.uy/politica/articulo/2021/8/este-miercoles-hay-paro-de-cofe-cuales-son-los-servicios-afectados-y-por-donde-ira-la-caravana/")
nota1 = ladiaria1708a %>%  
  html_nodes(".article-body--faded")%>%
  html_text()

#Clipping2

ladiaria1708b = read_html("https://ladiaria.com.uy/salud/articulo/2021/8/gremios-de-la-salud-buscan-conseguir-mas-recursos-para-asse-en-la-rendicion-de-cuentas/")
titulo2 = ladiaria1708b %>% 
  html_nodes(".after_foto")%>%
  html_text()

ladiaria1708b = read_html ("https://ladiaria.com.uy/salud/articulo/2021/8/gremios-de-la-salud-buscan-conseguir-mas-recursos-para-asse-en-la-rendicion-de-cuentas/")
copete2 = ladiaria1708b %>% 
  html_nodes(".article__deck")%>%
  html_text()

ladiaria1708b = read_html("https://ladiaria.com.uy/salud/articulo/2021/8/gremios-de-la-salud-buscan-conseguir-mas-recursos-para-asse-en-la-rendicion-de-cuentas/")
nota2 = ladiaria1708b %>%  
  html_nodes(".article-body--faded")%>%
  html_text()

#Clipping3

ladiaria1708c = read_html("https://ladiaria.com.uy/educacion/articulo/2021/8/sindicatos-de-la-educacion-paran-24-horas-contra-rendicion-de-cuentas-del-gobierno-y-los-recortes-presupuestales/")
titulo3 = ladiaria1708c %>% 
  html_nodes(".after_foto")%>%
  html_text()

ladiaria1708c = read_html ("https://ladiaria.com.uy/educacion/articulo/2021/8/sindicatos-de-la-educacion-paran-24-horas-contra-rendicion-de-cuentas-del-gobierno-y-los-recortes-presupuestales/")
copete3 = ladiaria1708c %>% 
  html_nodes(".article__deck")%>%
  html_text()

ladiaria1708c = read_html("https://ladiaria.com.uy/educacion/articulo/2021/8/sindicatos-de-la-educacion-paran-24-horas-contra-rendicion-de-cuentas-del-gobierno-y-los-recortes-presupuestales/")
nota3 = ladiaria1708c %>%
    html_nodes(".article-body--faded")%>%
    html_text()

#Clipping4
  
 ladiaria1808a = read_html ("https://ladiaria.com.uy/trabajo/articulo/2021/8/consejos-de-salarios-sin-avances-en-los-grupos-madres-diferencias-por-pedido-de-descuelgue-de-freeshops/")
  titulo4 = ladiaria1808a %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria1808a = read_html ("https://ladiaria.com.uy/trabajo/articulo/2021/8/consejos-de-salarios-sin-avances-en-los-grupos-madres-diferencias-por-pedido-de-descuelgue-de-freeshops/")
  copete4 = ladiaria1808a %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
ladiaria1808a = read_html ("https://ladiaria.com.uy/trabajo/articulo/2021/8/consejos-de-salarios-sin-avances-en-los-grupos-madres-diferencias-por-pedido-de-descuelgue-de-freeshops/") 
  nota4 = ladiaria1808a %>%
    html_nodes(".article-body--faded")%>%
    html_text()
  
#Clipping5

  ladiaria1808b = read_html("https://ladiaria.com.uy/maldonado/articulo/2021/8/fenapes-maldonado-se-movilizo-por-el-recorte-de-horas-docentes-y-por-la-sobrepoblacion-de-estudiantes-en-los-liceos/")
  titulo5 = ladiaria1808b %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria1808b = read_html ("https://ladiaria.com.uy/maldonado/articulo/2021/8/fenapes-maldonado-se-movilizo-por-el-recorte-de-horas-docentes-y-por-la-sobrepoblacion-de-estudiantes-en-los-liceos/")
  copete5 = ladiaria1808b  %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria1808b = read_html("https://ladiaria.com.uy/maldonado/articulo/2021/8/fenapes-maldonado-se-movilizo-por-el-recorte-de-horas-docentes-y-por-la-sobrepoblacion-de-estudiantes-en-los-liceos/")
  nota5 = ladiaria1808b %>%  
    html_nodes(".article-body--faded")%>%
    html_text()
  
  #Clipping6
  
 ladiaria1808c = read_html("https://ladiaria.com.uy/trabajo/articulo/2021/8/tras-movilizacion-de-cofe-argimon-le-aseguro-que-habra-negociacion-con-los-sindicatos-en-el-senado/")
  titulo6 = ladiaria1808c %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria1808c = read_html ("https://ladiaria.com.uy/trabajo/articulo/2021/8/tras-movilizacion-de-cofe-argimon-le-aseguro-que-habra-negociacion-con-los-sindicatos-en-el-senado/")
  copete6 = ladiaria1808c  %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria1808c = read_html("https://ladiaria.com.uy/trabajo/articulo/2021/8/tras-movilizacion-de-cofe-argimon-le-aseguro-que-habra-negociacion-con-los-sindicatos-en-el-senado/")
  nota6 = ladiaria1808c %>%  
    html_nodes(".article-body--faded")%>%
    html_text()
  
#Clipping7

  ladiaria1808d = read_html("https://ladiaria.com.uy/trabajo/articulo/2021/8/trabajadores-de-peajes-paran-este-jueves-por-24-horas-en-defensa-de-las-fuentes-de-trabajo/")
  titulo7 = ladiaria1808d %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria1808d = read_html ("https://ladiaria.com.uy/trabajo/articulo/2021/8/trabajadores-de-peajes-paran-este-jueves-por-24-horas-en-defensa-de-las-fuentes-de-trabajo")
  copete7 = ladiaria1808d  %>%
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria1808d = read_html("https://ladiaria.com.uy/trabajo/articulo/2021/8/trabajadores-de-peajes-paran-este-jueves-por-24-horas-en-defensa-de-las-fuentes-de-trabajo")
  nota7 = ladiaria1808d %>%  
    html_nodes(".article-body--faded")%>%
    html_text()
  
  #Clipping8
  
 ladiaria1808e = read_html("https://ladiaria.com.uy/educacion/articulo/2021/8/la-educacion-publica-no-se-vende-se-defiende-sindicatos-de-la-ensenanza-pararon-y-marcharon-por-mas-presupuesto/")
  titulo8 = ladiaria1808e %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria1808e = read_html ("https://ladiaria.com.uy/educacion/articulo/2021/8/la-educacion-publica-no-se-vende-se-defiende-sindicatos-de-la-ensenanza-pararon-y-marcharon-por-mas-presupuesto/")
  copete8 = ladiaria1808e  %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria1808e = read_html("https://ladiaria.com.uy/educacion/articulo/2021/8/la-educacion-publica-no-se-vende-se-defiende-sindicatos-de-la-ensenanza-pararon-y-marcharon-por-mas-presupuesto/")
  nota8 = ladiaria1808e %>%  
    html_nodes(".article-body--faded")%>%
    html_text()
  
  #Clipping9
  
 ladiaria1908a = read_html("https://ladiaria.com.uy/trabajo/articulo/2021/8/trabajadoras-de-peajes-hicieron-paro-de-24-horas-y-reclaman-que-se-mantenga-sistema-mixto-de-cobro-y-se-mejore-la-atencion-al-usuario/")
  titulo9 = ladiaria1908a %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria1908a = read_html ("https://ladiaria.com.uy/trabajo/articulo/2021/8/trabajadoras-de-peajes-hicieron-paro-de-24-horas-y-reclaman-que-se-mantenga-sistema-mixto-de-cobro-y-se-mejore-la-atencion-al-usuario/")
  copete9 = ladiaria1908a  %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria1908a = read_html("https://ladiaria.com.uy/trabajo/articulo/2021/8/trabajadoras-de-peajes-hicieron-paro-de-24-horas-y-reclaman-que-se-mantenga-sistema-mixto-de-cobro-y-se-mejore-la-atencion-al-usuario/")
  nota9 = ladiaria1908a %>%  
    html_nodes(".article-body--faded")%>%
    html_text()
  
  #Clipping10
  
ladiaria1908b = read_html("https://ladiaria.com.uy/feminismos/articulo/2021/8/trabajadoras-domesticas-reivindican-definir-categorias-para-el-sector-tienen-que-dejar-de-decir-que-somos-multitarea/")
  titulo10 = ladiaria1908b %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria1908b = read_html ("https://ladiaria.com.uy/feminismos/articulo/2021/8/trabajadoras-domesticas-reivindican-definir-categorias-para-el-sector-tienen-que-dejar-de-decir-que-somos-multitarea/")
  copete10 = ladiaria1908b  %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria1908b = read_html("https://ladiaria.com.uy/feminismos/articulo/2021/8/trabajadoras-domesticas-reivindican-definir-categorias-para-el-sector-tienen-que-dejar-de-decir-que-somos-multitarea/")
  nota10 = ladiaria1908b %>%  
    html_nodes(".article-body--faded")%>%
    html_text()
  
  #Clipping11
  
  ladiaria1908c = read_html("https://ladiaria.com.uy/trabajo/articulo/2021/8/resolucion-establece-que-si-una-trabajadora-domestica-con-mas-de-un-empleo-es-enviada-al-seguro-de-paro-podra-recibir-el-beneficio/")
  titulo11 = ladiaria1908c %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria1908c = read_html ("https://ladiaria.com.uy/trabajo/articulo/2021/8/resolucion-establece-que-si-una-trabajadora-domestica-con-mas-de-un-empleo-es-enviada-al-seguro-de-paro-podra-recibir-el-beneficio/")
  copete11 = ladiaria1908c  %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria1908c = read_html("https://ladiaria.com.uy/trabajo/articulo/2021/8/resolucion-establece-que-si-una-trabajadora-domestica-con-mas-de-un-empleo-es-enviada-al-seguro-de-paro-podra-recibir-el-beneficio/")
  nota11 = ladiaria1908c %>%  
    html_nodes(".article-body--faded")%>%
    html_text()
  
  #Clipping12
  
 ladiaria1908d = read_html("https://ladiaria.com.uy/trabajo/articulo/2021/8/sindicato-de-la-industria-quimica-ocupo-por-seis-horas-la-planta-de-alur-ubicada-en-capurro/")
  titulo12 = ladiaria1908d %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria1908d = read_html ("https://ladiaria.com.uy/trabajo/articulo/2021/8/sindicato-de-la-industria-quimica-ocupo-por-seis-horas-la-planta-de-alur-ubicada-en-capurro/")
  copete12 = ladiaria1908d  %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria1908d = read_html("https://ladiaria.com.uy/trabajo/articulo/2021/8/sindicato-de-la-industria-quimica-ocupo-por-seis-horas-la-planta-de-alur-ubicada-en-capurro/")
  nota12 = ladiaria1908d %>%  
    html_nodes(".article-body--faded")%>%
    html_text()

  #Clipping13
  
  ladiaria2308 = read_html("https://ladiaria.com.uy/educacion/articulo/2021/8/sindicato-de-funcionarios-no-docentes-de-secundaria-declaro-a-silva-y-cherro-como-personas-no-gratas-por-persecucion-antisindical/")
  titulo13 = ladiaria2308 %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria2308= read_html ("https://ladiaria.com.uy/educacion/articulo/2021/8/sindicato-de-funcionarios-no-docentes-de-secundaria-declaro-a-silva-y-cherro-como-personas-no-gratas-por-persecucion-antisindical/")
  copete13 = ladiaria2308 %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria2308= read_html("https://ladiaria.com.uy/educacion/articulo/2021/8/sindicato-de-funcionarios-no-docentes-de-secundaria-declaro-a-silva-y-cherro-como-personas-no-gratas-por-persecucion-antisindical/")
  nota13 = ladiaria2308 %>%  
    html_nodes(".article-body--faded")%>%
    html_text()
  
  #Clipping14
  
ladiaria2408a = read_html("https://ladiaria.com.uy/justicia/articulo/2021/8/tribunal-de-apelaciones-confirmo-imputacion-contra-trabajadores-de-friopan/")
  titulo14 = ladiaria2408a %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria2408a = read_html ("https://ladiaria.com.uy/justicia/articulo/2021/8/tribunal-de-apelaciones-confirmo-imputacion-contra-trabajadores-de-friopan/")
  copete14 = ladiaria2408a %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria2408a = read_html("https://ladiaria.com.uy/justicia/articulo/2021/8/tribunal-de-apelaciones-confirmo-imputacion-contra-trabajadores-de-friopan/")
  nota14 = ladiaria2408a %>%  
    html_nodes(".article-body--faded")%>%
    html_text()
  
  #Clipping15
  
 ladiaria2408b = read_html("https://ladiaria.com.uy/educacion/articulo/2021/8/mientras-sigue-investigacion-los-14-profesores-de-san-jose-sumariados-son-restituidos-a-sus-tareas/")
  titulo15 = ladiaria2408b %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
ladiaria2408b = read_html ("https://ladiaria.com.uy/educacion/articulo/2021/8/mientras-sigue-investigacion-los-14-profesores-de-san-jose-sumariados-son-restituidos-a-sus-tareas/")
  copete15 = ladiaria2408b %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria2408b = read_html("https://ladiaria.com.uy/educacion/articulo/2021/8/mientras-sigue-investigacion-los-14-profesores-de-san-jose-sumariados-son-restituidos-a-sus-tareas/")
  nota15 = ladiaria2408b %>%  
    html_nodes(".article-body--faded")%>%
    html_text()
  
  #Clipping16
  
 ladiaria2708 = read_html("https://ladiaria.com.uy/politica/articulo/2021/8/paro-general-del-pit-cnt-el-15-de-setiembre-desde-las-1000-en-el-area-metropolitana/")
  titulo16 = ladiaria2708 %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria2708 = read_html ("https://ladiaria.com.uy/politica/articulo/2021/8/paro-general-del-pit-cnt-el-15-de-setiembre-desde-las-1000-en-el-area-metropolitana/")
  copete16 = ladiaria2708 %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria2708 = read_html("https://ladiaria.com.uy/politica/articulo/2021/8/paro-general-del-pit-cnt-el-15-de-setiembre-desde-las-1000-en-el-area-metropolitana/")
  nota16 = ladiaria2708 %>%  
    html_nodes(".article-body--faded")%>%
    html_text()
  
  #Clipping17
  
 ladiaria2908 = read_html("https://ladiaria.com.uy/trabajo/articulo/2021/8/unatra-definio-hacer-una-marcha-a-caballo-de-mas-de-100-jinetes-el-dia-del-paro-general-convocado-por-el-pit-cnt/")
  titulo17 = ladiaria2908 %>% 
    html_nodes(".after_foto")%>%
    html_text()
  
  ladiaria2908 = read_html ("https://ladiaria.com.uy/trabajo/articulo/2021/8/unatra-definio-hacer-una-marcha-a-caballo-de-mas-de-100-jinetes-el-dia-del-paro-general-convocado-por-el-pit-cnt/")
  copete17 = ladiaria2908 %>% 
    html_nodes(".article__deck")%>%
    html_text()
  
  ladiaria2908 = read_html("https://ladiaria.com.uy/trabajo/articulo/2021/8/unatra-definio-hacer-una-marcha-a-caballo-de-mas-de-100-jinetes-el-dia-del-paro-general-convocado-por-el-pit-cnt/")
  nota17 = ladiaria2908 %>%  
    html_nodes(".article-body--faded")%>%
    html_text()
  
  
#Uso función paste() para unir titulo, copete y parte de la nota visible de cada nota  

  ladiaria1708a=paste(titulo1,copete1,nota1)
  ladiaria1708b=paste(titulo2,copete2,nota2)
  ladiaria1708c=paste(titulo3,copete3,nota3)
  ladiaria1808a=paste(titulo4,copete4,nota4)
  ladiaria1808b=paste(titulo5,copete5,nota5)
  ladiaria1808c=paste(titulo6,copete6,nota6)
  ladiaria1808d=paste(titulo7,copete7,nota7)
  ladiaria1808e=paste(titulo8,copete8,nota8)
  ladiaria1908a=paste(titulo9,copete9,nota9)
  ladiaria1908b=paste(titulo10,copete10,nota10)
  ladiaria1908c=paste(titulo11,copete11,nota11)
  ladiaria1908d=paste(titulo12,copete12,nota12)
  ladiaria2308=paste(titulo13,copete13,nota13)
  ladiaria2408a=paste(titulo14,copete14,nota14)
  ladiaria2408b=paste(titulo15,copete15,nota15)
  ladiaria2708=paste(titulo16,copete16,nota16)
  ladiaria2908=paste(titulo17,copete17,nota17)

  
#Creo un dataframe con todas las 17 notas scrapeadas

  ladiaria = as.data.frame(rbind(ladiaria1708a,ladiaria1708b,ladiaria1708c,ladiaria1808a,ladiaria1808b,ladiaria1808c,ladiaria1808d,ladiaria1808e,ladiaria1908a,ladiaria1908b,ladiaria1908c,ladiaria1908d,ladiaria2308,ladiaria2408a,ladiaria2408b,ladiaria2708,ladiaria2908))

#Guardo la base de datos con mi corpus
write.csv(ladiaria,"C:/Users/ASUS/Desktop/Examen R Cuali/base.csv")
  

################ CODIFICACIÓN DE LOS DATOS #################

#Categorización y codificación
#Instalamos RQDA para análisis de datos de cada noticia
  
  # library(RQDA)
  # rqdpkgs <- c("RSQLite", "gWidgets2RGtk2", "DBI",
  #           "stringi", "RGtk2", "igraph", "gWidgets2",
  #           "devtools")
  # install.packages("pkgs")
  # library(RGtk2)
  # devtools::install_github("RQDA/RQDA",
  # INSTALL_opts = "--no-multiarch")
  
  library(RQDA)
  
  textos = setNames(as.list(ladiaria$V1), rownames(ladiaria))
  
  Encoding(codificacion$ladiaria1708a)
  write.csv(tabla_cods,"C:/Users/ASUS/Desktop/Examen R Cuali/Resultados/textos")
  
  RQDA()
  
  # Lectura de caracteres es español
  
  RQDA::write.FileList(textos, encoding = "UTF-8")
  
 # Utilizo summaryCodings() para visualizar n° de codificciones, caracteres y archivos asociados a cada código 
   summaryCodings()
    #Número de codificaciones por código
     num_cod=summaryCodings()[[1]]
     #Número de caracteres asociados a cada código
     num_caract=summaryCodings()[[2]]
     #Número de archivos asociados a cada código
      num_archivos=summaryCodings()[[3]]
 
 # Tabla con codificaciones
  getCodingTable =(tabla_cods)
  write.csv(tabla_cods,"C:/Users/ASUS/Desktop/Examen R Cuali/Resultados/tabla_cods.csv")
  
 # Guardo la base de datos de número de codificaciones por código
  write.csv(num_cod,"C:/Users/ASUS/Desktop/Examen R Cuali/num_cod.csv")
  
 # Búsqueda de un código
   codigos=getCodingsByOne(29)
 
  #Exporto los códigos
 
 exportCodings("C:/Users/ASUS/Desktop/Examen R Cuali/codigos.html")
 
#Creo una tabla con las organizaciones sindicales que identifiqué en las notas
 
   tabla_org <- data.frame(org = c("ATES", "COFE", "UNATRA", "STUD", "STIQ", "PINT-CNT", "SUNCA", "CSEU", "FUECYS", "FFSP", "FENAPES"))
   write.csv(tabla_org,"C:/Users/ASUS/Desktop/Examen R Cuali/Resultados/tabla_org.csv")
  
    #remotes:: install_github ("stats4sd/RQDAPlus", upgrade = "always")
   #Guardo la codificación en un archivo
   
    devtools::install_github("sdumble1/RQDAPlus")
 
 RQDAPlus::RQDAPlus("C:/Users/ASUS/Desktop/Examen R Cuali//Codigos.rqda")
 
################ ILUSTRACIÓN Y VISUALIZACIÓN DE LOS DATOS #############
 # cargo un archivo que contiene todas las notas
 
 library(quanteda)
 library(readtext)
 
 mytf <- readtext("C:/Users/ASUS/Desktop/Examen R Cuali/Version Quanteda/docs*", docvarsfrom = "filenames")
 
 Encoding(mytf$text)= "UTF-8"
 
 myCorpus <- corpus(mytf,text_field = "text")
 
 #Limpieza de texto
 ##abro un archivo con stopwords
 
 stop = read.csv("C:/Users/ASUS/Desktop/Examen R Cuali/Version Quanteda/stopes.csv", sep = ";")
 
 ##me quedo con el vector
 vector = as.character(stop$X0)
 
 #aplico la función dfm con los argumentos para limpiar el texto
 
 mydfm <- dfm(myCorpus,
              tolower = TRUE,
              remove = c(stopwords("spanish"),vector,"agosto","otraspalabras"), 
              remove_punct = TRUE, 
              remove_numbers = TRUE, 
              verbose = TRUE)%>%
   dfm_remove(min_nchar=3) 
 
 mydfm_df<- as.data.frame(mydfm)
 
 
 #Nubes de palabras con quanteda: Nubes de palabras sin desagregación
 
 textplot_wordcloud(mydfm, min.count = 3,max_words = 100,random.order = FALSE,
                    rot.per = .50, colors = RColorBrewer::brewer.pal(8,"Dark2"))
 
 ##Grafico palabras más frecuentes
 
     #defino el color para las barras
 coloree = c(rep("#D7B5D8",20))
 
 #creo un objeto con la 20 principales palabras 
 topconflictos = data.frame(topfeatures(mydfm,20))
 
 write.csv(topconflictos,"C:/Users/ASUS/Desktop/Examen R Cuali/Resultados/topconflictos.csv")

 #las defino como rownames
 topconflictos$palabra = rownames(topconflictos)
 
 #hago el gráfico con ggplot
 library(ggplot2)
 
 conflictospplot = topconflictos[1:20, ] %>%
   ggplot(aes(x = reorder(palabra, topfeatures.mydfm..20.), 
              y = topfeatures.mydfm..20., fill = palabra)) + 
   geom_col(show.legend = FALSE) +
   coord_flip() +
   geom_text(aes(hjust = -0.1, label = topfeatures.mydfm..20.)) +
   theme_minimal() +
   theme(axis.title.y = element_blank(), axis.title.x = element_blank(), axis.text = element_text(size = 15)) +
   ggtitle("Palabras mÃ¡s frecuentes (n=20)") +
   scale_fill_manual(values = coloree)
 

################ ARMADO DE INFORME FINAL
 
 install.packages("rmarkdown")
library(rmarkdown)
 tinytex::install_tinytex()
library(tinytex)
 install.packages("knitr")
 
 