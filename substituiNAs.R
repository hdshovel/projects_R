'
Durante o carregamento do dataset, fiz a correcao dos nomes das colunas com clean_names, dividi a coluna hora_local em 2 colunas de hr e min e substituir 
os NAs da coluna hr por 0 e os NAs da coluna t_ar1 pela media da propria coluna.
'

'
While loading the dataset, I corrected the column names with clean_names, divided the local_time column into 2 columns of hr and min and replaced 
the NAs of the hr column with 0 and the NAs of the t_ar1 column with the average of the column itself.
'

rm(list = ls())

library(magrittr)


df3 <- readxl::read_excel('dados/temp_floresta.xlsx') %>% janitor::clean_names() %>% 
  tidyr::separate(col = hora_local, into = c('hr', 'min'), sep = -2, convert = T) %>% 
  tidyr::replace_na(replace = list(hr=0, 
                              t_ar1=with(data = .,expr = mean(t_ar1, na.rm=T))))

