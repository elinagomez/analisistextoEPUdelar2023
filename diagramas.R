# diagrama clase 1

DiagrammeR::grViz("digraph {

graph [fontname = 'calibri'];
node [fontname = 'calibri'];
edge [fontname = 'calibri'];
 
graph [layout = dot, labelloc='t', label = 'Esquema del curso', fontsize='25']
#graph [layout = dot, labelloc='t']

subgraph cluster_1 {
         graph[shape = rectangle]
         style = rounded
         bgcolor = White
         fontsize='15'
         
         graph[label = 'Objetivos']

  node[shape = egg, style = filled, fillcolor = Linen]
  explore [label =  'Exploración']
  analisis [label = 'Análisis']
  viz [label = 'Visualización']
  
}

subgraph cluster_2 {
         graph[shape = rectangle]
         style = rounded
         bgcolor = Gray
         
         graph[label = 'Actividades', fontsize='15']

  node[shape = rect, style = rounded]
  recover [label =  'Recuperación: 
  txt, pdf, doc, OCR,  web sacraping, 
  prensa digital, redes sociales, audio, APIs', fontsize='10']
  clean [label =  'Procesamiento:
  limpieza, homogeneización, minería, corpus, codificación,
  diccionarios, clasificación', fontsize='10']
  interprete [label = 'Interpretación:
  nubes de palabras, frecuencias, asociación, correlación,
  redes de co-ocurrencia, dendrogramas', fontsize='10']

}

subgraph cluster_3 {
         graph[shape = rectangle]
         style = rounded
         bgcolor = White

         graph[label = 'Paquetes', fontsize='15']
  
  node[shape = rect, fontsize='10', style = rounded]
  paquetes1 [label =  'readtext, pdftools, tesseract,magick, rvest, speech, 
  gdeltr2, gtrendsR, twitteR, rtweet, audio.whisper', fillcolor = Linen]
  paquetes2 [label =  'stringr, stringi, RQDA, quanteda, quanteda.textstats,
  syuzhet, topicmodels, udpipe']
  paquetes3 [label =  'quanteda, quanteda.textplots, ggplot2, plotly']

}

edge[color = black, arrowhead = vee, arrowsize = 0.5]
explore -> analisis -> viz
recover -> clean -> interprete
paquetes1 -> paquetes2 -> paquetes3
}")





# diagrama exploracion

DiagrammeR::grViz("digraph {

graph [fontname = 'calibri'];
node [fontname = 'calibri'];
edge [fontname = 'calibri'];

graph [label = '', fontsize='20', layout = dot, labelloc='t']

subgraph cluster_1 {
         graph[shape = rectangle]
         style = rounded
         bgcolor = White
         fontsize='15'
         
         graph[label = 'Objetivos']

  node[shape = egg, style = filled]
  explore [label =  'Exploración', fillcolor = Linen]
  analisis [label = 'Análisis', fillcolor = White]
  viz [label = 'Visualización', fillcolor = White]
  
  edge[color = black, arrowhead = vee, arrowsize = 0.5]
explore -> analisis -> viz

}



}")


# diagrama análisis

DiagrammeR::grViz("digraph {

graph [fontname = 'calibri'];
node [fontname = 'calibri'];
edge [fontname = 'calibri'];

graph [label = '', fontsize='20', layout = dot, labelloc='t']

subgraph cluster_1 {
         graph[shape = rectangle]
         style = rounded
         bgcolor = White
         fontsize='15'
         
         graph[label = 'Objetivos']

  node[shape = egg, style = filled]
  explore [label =  'Exploración', fillcolor = White]
  analisis [label = 'Análisis', fillcolor = Linen]
  viz [label = 'Visualización', fillcolor = White]
  
  edge[color = black, arrowhead = vee, arrowsize = 0.5]
explore -> analisis -> viz

}



}")


# diagrama visualizacion

DiagrammeR::grViz("digraph {

graph [fontname = 'calibri'];
node [fontname = 'calibri'];
edge [fontname = 'calibri'];

graph [label = '', fontsize='20', layout = dot, labelloc='t']

subgraph cluster_1 {
         graph[shape = rectangle]
         style = rounded
         bgcolor = White
         fontsize='15'
         
         graph[label = 'Objetivos']

  node[shape = egg, style = filled]
  explore [label =  'Exploración', fillcolor = White]
  analisis [label = 'Análisis', fillcolor = Linen]
  viz [label = 'Visualización', fillcolor = White]
  
  edge[color = black, arrowhead = vee, arrowsize = 0.5]
explore -> analisis -> viz

}



}")
