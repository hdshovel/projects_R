rm(list = ls())

library(magrittr)


# download file from url
download.file(url = "https://mercelsantos.com/dados_aulas/temp_floresta.xlsx", 
              destfile = paste0(getwd(), '/dados/temp_floresta.xlsx'))

# loading dataset and spliting 
df2 <- readxl::read_excel('dados/temp_floresta.xlsx') %>% janitor::clean_names() %>% 
  tidyr::separate(., col = hora_local, into = c('hora', 'min'), sep = -2, 
                  convert = T)





