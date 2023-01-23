rm(list = ls())

library(dplyr)

# Origem:
# https://mercelsantos.com/dados_curso/milho_br.xlsx
# https://mercelsantos.com/dados_curso/soja_br_2019.xlsx

# Carregar, juntar e alterar os nomes das colunas das tabelas.

# Load, merge, and rename table columns.

dfMilho <- readxl::read_xlsx("dados/milho_br.xlsx", sheet = 5, skip = 4) %>% 
  select(2:4) %>% setNames(c('codigo', 'muni', 'prodM'))


dfSoja <- readxl::read_xlsx("dados/soja_br_2019.xlsx", sheet = 5, skip = 6,
                            col_names = F) %>% select(c(2,6)) %>% 
  setNames(c('codigo', 'prodS'))

dfMS <- full_join(dfMilho, dfSoja, by = 'codigo')
