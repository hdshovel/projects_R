rm(list = ls())

# Origem dos dados: 
# https://mercelsantos.com/dados_curso/atlas2013_dadosbrutos_pt.xlsx

library(dplyr)

# Função select com colunas congeladas para fatiar grandes datasets sem perder a 
# referência da análise.

# Select function with frozen columns to slice large datasets without losing 
# the analysis reference.

# download the file
download.file(url = "https://mercelsantos.com/dados_curso/atlas2013_dadosbrutos_pt.xlsx", 
              destfile = "dados/atlas2013_dadosbrutos_pt.xlsx")

# Lendo dos dados
df <- readxl::read_excel('dados/atlas2013_dadosbrutos_pt.xlsx', sheet = 3)

# Selecionando colunas IDHM
dfIDHM <- df %>% select(1:3, starts_with('IDHM'))

# Selecionando colunas com peso de 15 a 70
dfPeso <- df %>% select(1:3, num_range(prefix = 'PESO', range = 15:70))

# Selecionando colunas que contenham ATRASO
dfAtraso <- df %>% select(1:3, contains('ATRASO'))
