# Este script abre los archivos de defunciones, los filtra por homicidios
# y los agrupo en un solo archivo
# Input:
#     Path del folder donde se encuentran los archivos de defunciones INEGI
#     Path del folder donde se encuentran los archivos de defunciones de la SS
#Output:
#     inegi_homicidios_1990-2018.csv
#     ss_homicidios_2000-2017.csv

#####################################################################################
#Working directory
setwd('~/Documents/Xaber_ODP/DB/Homicidios/')
#setwd("C:/Users/Brenda Jimenez/Documents/Xaber&ODP/DB/Homicidios")
# PATH del folder donde se encuentran los archivos de defunciones INEGI
path_inegi <- '~/Documents/Xaber_ODP/DB/Homicidios/INEGI_Defunciones'
# PATH del folder donde se encuentran los archivos de defunciones de la Secretaria de Salud
path_ss <- '~/Documents/Xaber_ODP/DB/Homicidios/SS_Defunciones'
#####################################################################################


library(ggplot2)   #make graphs
library(dplyr)     #manipulate data
library(tidyverse) #manipulate data
library(knitr)
library(stringr)
library(foreign)
library(data.table)


# ------------------------------------------- Defunciones INEGI ----------------------------------------
# Defunciones_base_datos desde 1990 a 2018 en formato DBF

#Hacemos una lista con los nombres de todos los archivos en el folder
list_files <- list.files(path = path_inegi, pattern = "defunciones_base_datos_")

#Cargamos los archivos y filtramos por los homicidios (PRESUNTO==2)
files_inegi <- list()
for(i in 1:length(list_files)){
  list_files_names <- paste('INEGI_Defunciones/', list_files[i], "/DEFUN", substring(list_files[i],nchar(list_files[i])-1,nchar(list_files[i])), ".dbf", sep = "")  
  temp <- read.dbf(list_files_names) 
  files_inegi[[i]] <- filter(temp, PRESUNTO==2)
}
remove(temp)

#Pegamos toda la informacion en un solo archivo
inegi_homicidios <- rbindlist(files_inegi, fill=TRUE)

#Guarda la informacion en un archivo csv (inegi_homicidios_1990-2018.csv)
write_csv(inegi_homicidios, "INEGI_Defunciones/inegi_homicidios_1990-2018.csv")




# ------------------------------------------- Defunciones Secretaria de Salud ----------------------------------------
# defunciones_generales de 2000 a 2017 en formato CSV

#Hacemos una lista con los nombres de todos los archivos en el folder
list_files <- list.files(path = path_ss, pattern = "defunciones_generales_")

#Cargamos los archivos y filtramos por los homicidios (PRESUNTO==2)
files_ss <- list()
for(i in 1:length(list_files)){
  temp <- read_csv(paste('SS_Defunciones/', list_files[i], sep = '')) 
  colnames(temp) <- tolower(colnames(temp)) #Convierte a minusculas todos los nombres de las columnas
  files_ss[[i]] <- filter(temp, presunto==2)
}
remove(temp)

#Pegamos toda la informacion en un solo archivo
ss_homicidios <- rbindlist(files_ss, fill=TRUE)

#Guarda la informacion en un archivo csv (inegi_homicidios_1990-2018.csv)
write_csv(ss_homicidios, "SS_Defunciones/ss_homicidios_2000-2017.csv")


####################################################################################################################
#Informacion sobre los archivos

list_files <- list.files(path = path_inegi, pattern = "defunciones_base_datos_")
n <- length(files_inegi)
info_files_inegi <- matrix(0,n,3)
for(i in 1:n){
  info_files_inegi[i,1] <- list_files[i]
  info_files_inegi[i,2:3] <- dim(files_inegi[[i]])
}
info_files_inegi <- as.data.frame(info_files_inegi)
colnames(info_files_inegi) <- c('Nombre', 'Obs', 'Cols')


#----------------------------------------------------------------------------------------------------------------
list_files <- list.files(path = path_ss, pattern = "defunciones_generales_")
n <- length(files_ss)
info_files_ss <- matrix(0,n,3)
for(i in 1:n){
  info_files_ss[i,1] <- list_files[i]
  info_files_ss[i,2:3] <- dim(files_ss[[i]])
}
info_files_ss <- as.data.frame(info_files_ss, col.names = c('Nombre', 'Obs', 'Cols'))
colnames(info_files_ss) <- c('Nombre', 'Obs', 'Cols')


write_csv(info_files_inegi,'~/Documents/Xaber_ODP/DB/Homicidios/info_files_inegi.csv')
write_csv(info_files_ss,'~/Documents/Xaber_ODP/DB/Homicidios/info_files_ss.csv')
