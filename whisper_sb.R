

##Requisito RTools 43 (https://cran.r-project.org/bin/windows/Rtools/rtools43/files/rtools43-5550-5548.exe)
remotes::install_github("bnosac/audio.whisper", ref = "0.2.1")

library(audio.whisper)


#PASO 0: Convertir en .wav
##Librería para convertir audios en wav (si los tenés en otro formato)
#install.packages("av")
library(av)
av_audio_convert("rutaentumaquina/Entrevista.m4a", 
  output = "rutaentumaquina/Entrevista.wav",format = "wav", sample_rate = 16000)

#PASO 1: Descargar el modelo
##descargo modelo manual (para hacerlo dentro de la sesión tenés que tener mucha RAM para el modelo medio, 
##entonces lo descargas y luego evocás)
##2 formas, con función o de la URL directo
#whisper_download_model("medium")
#https://huggingface.co/datasets/ggerganov/whisper.cpp/resolve/main/ggml-medium.bin


##PASO 2: Corres el modelo, indicando el idioma (es multilingual)
model <- whisper("C:/Users/Usuario/Downloads/ggml-medium.bin")##la ruta es dónde lo tengas
transcribe_medio <- predict(model, newdata = "rutaentumaquina/Entrevista.wav", language = "es")

##Y guardas:
entrevista=transcribe_medio$data ##está en un DF de la lista que se llama data 
save(entrevista,file="/Transcribe_Samuel_mejor.RData") #o en el formato que quieras






