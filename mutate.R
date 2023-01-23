rm(list = ls())

# Origem dos dados:
# https://mercelsantos.com/dados_curso/HIST_PAINEL_COVIDBR_21abr2021.csv

library(dplyr)

df <- readr::read_csv2('dados/HIST_PAINEL_COVIDBR_21abr2021.csv', guess_max = 50000)

# Filtering by estado 'SP' and municipio 'Americana'
dfSP <- dplyr::filter(.data = df, estado == 'SP' & municipio == 'Americana')

# Filtering by estado 'SP' and casosNovos > 5000
df5mil <- dplyr::filter(df, estado == 'SP' & casosNovos > 5000)

# Filtering by estado 'SP' and casosNovos > mean
dfAcimaMedia <- df %>% dplyr::filter(estado == 'SP' & casosNovos > mean(casosNovos, na.rm = T))

################################################################################

# Origem dos dados:
# https://mercelsantos.com/dados_curso/floresta.csv

# Loading the data and creating a thermal amplitude column.
dfFloresta <- readr::read_csv("dados/floresta.csv") %>% 
  mutate(apl.term = t.max-t.min)

# With the general average of the t.media column, we identify which dia.do.ano 
# is above or below the this average.
dfFlorestaMedia <- dfFloresta %>% select(dia.do.ano, t.media, estacao) %>% 
  mutate(status = ifelse(mean(t.media, na.rm = T) > t.media, 'Above', 'Below'))

################################################################################

# Origem dos dados:
# https://mercelsantos.com/dados_curso/pesosAlturaIBGE.xlsx

dfPeso <- readxl::read_xlsx("dados/pesosAlturaIBGE.xlsx")

# Translate the sex column into English. And create 2 new columns with the 
# body mass index(BMI) and status classifying BMI.

dfPeso <- dfPeso  %>% mutate(sexo = if_else(sexo == 'Masculino', 'Male', 'Female'),
                             BMI = round(peso/(altura*0.01)^2 , 2),
                             status = case_when(BMI < 18.5 ~ 'Below',
                                                BMI >= 18.5 & BMI < 25 ~ 'OK',
                                                BMI >= 25 & BMI < 30 ~ 'Above',
                                                BMI >= 30 ~ 'Obesity'))

