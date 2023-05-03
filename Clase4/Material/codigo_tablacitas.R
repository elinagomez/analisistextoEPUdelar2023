#cargo librerías
library(quanteda) 
library(readtext) 
library(stringr)
library(dplyr)
library(ggplot2)
library(quanteda.textstats)
library(quanteda.textplots)

library(RQDA)

tabla=RQDA::getCodingTable()

out = vector("list", length = max(tabla$cid))


for(i in 1:max(tabla$cid)) {         
  out[[i]] <- rbind(RQDA::getCodingsByOne(i) )
  
}

data = do.call(rbind, out)



