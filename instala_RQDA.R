

##1) Instalar RTools 4.0: https://cran.r-project.org/bin/windows/Rtools/rtools40.html


##2)Instalación desde repositorio Microsoft
url="https://cran.microsoft.com/snapshot/2021-12-15/bin/windows/contrib/4.1/RGtk2_2.20.36.2.zip"
install.packages(url, repos=NULL)

library(RGtk2)##OK + Instalar, luego reiniciar R.

##3)Instalar gWidgets2RGtk2
devtools::install_github("jverzani/gWidgets2RGtk2", INSTALL_opts = "--no-multiarch")

##4) Instalar RQDA
devtools::install_github("RQDA/RQDA", INSTALL_opts = "--no-multiarch")

##5) Lo lanzo

library(RQDA) ##Cargo y chequeo que esté bien
RQDA() ##Abre plataforma
