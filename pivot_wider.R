rm(list = ls())

library(magrittr)

# getting file fom url
download.file(url = "https://mercelsantos.com/dados_curso/world_bank1.xls", 
              destfile = "/home/fred/R/Mercel/Curso/dados/world_bank1.xls") 


dfOriginalwb <- readxl::read_excel('/home/fred/R/Mercel/Curso/dados/world_bank12.xlsx')
head(dfOriginalwb)
colnames(dfOriginalwb)

# loading and reworking the columns and columns names
dfwb <- readxl::read_excel('/home/fred/R/Mercel/Curso/dados/world_bank12.xlsx') %>% 
  tidyr::pivot_wider(data = ., names_from = "Series Name", values_from = "values") %>% 
  janitor::clean_names()




