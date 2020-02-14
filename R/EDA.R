#########################    EDA    ########################

#Working directory
setwd('~/Documents/Xaber_ODP/DB/Homicidios/')
#setwd("C:/Users/Brenda Jimenez/Documents/Xaber&ODP/DB/Homicidios")

library(ggplot2)   #make graphs
library(dplyr)     #manipulate data
library(tidyverse) #manipulate data
library(knitr)
library(kableExtra)
library(gridExtra)
library(Hmisc)

#Open file
inegi_homicidios <- read_csv('INEGI_Defunciones/inegi_homicidios_1990-2018.csv') 

#inegi2_homicidios <- inegi_homicidios %>% 

#select numerical vars
#numerical_vars <- names(select_if(inegi_homicidios, is.numeric))

#describe(inegi_homicidios, num.desc=('mean', 'median', 'sd', ))

#describe(inegi_homicidios)
