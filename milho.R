rm(list = ls())

# dataset: https://mercelsantos.com/dados_aulas/area_plantada_milho.xlsx

'No dataset area_plantada_milho.xlsx, a coluna das localidades foi dividida em 
munic e uf durante o carregamento dos dados'

'In the area_plantada_milho.xlsx dataset, the location column was divided into 
munic and uf during data loading'

library(tidyr)

df <- readxl::read_excel('dados/area_plantada_milho.xlsx', sheet = 1, skip = 6, 
                         n_max = 5435, col_names = c('muni', 'area')) %>% 
  separate(col = muni, into = c('munic', 'est'), sep = "[ ]+[(]") %>% 
  extract(col = est, into = 'uf', regex = "([A-Z]*)")

