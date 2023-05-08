
remotes::install_github("bnosac/audio.whisper", ref = "0.2.1")

library(audio.whisper)


##Librería para convertir audios en wav
library(av)
av_audio_convert("C:/Users/Usuario/Desktop/Doctorado/Tesis/Campo/Entrevista_Samuel.m4a", 
  output = "C:/Users/Usuario/Desktop/Doctorado/Tesis/Campo/Entrevista_Samuel.wav", format = "wav", sample_rate = 16000)


model <- whisper("tiny")
path  <- system.file(package = "audio.whisper", "samples", "Entrevista_Samuel.wav")
trans <- predict(model, newdata = path, language = "es", n_threads = 2)

save(trans,file="C:/Users/Usuario/Desktop/Doctorado/Tesis/Campo/Transcribe_Samuel.RData")
entrevista=trans$data
save(entrevista,file="C:/Users/Usuario/Desktop/Doctorado/Tesis/Campo/Transcripcion_Samuel.RData")
tokens=trans$tokens




