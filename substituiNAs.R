rm(list = ls())

library(magrittr)


df3 <- readxl::read_excel('dados/temp_floresta.xlsx') %>% janitor::clean_names() %>% 
  tidyr::separate(col = hora_local, into = c('hr', 'min'), sep = -2, convert = T) %>% 
  tidyr::replace_na(replace = list(hr=0, 
                              t_ar1=with(data = .,expr = mean(t_ar1, na.rm=T))))

