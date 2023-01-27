rm(list = ls())

library(ggplot2)
library(dplyr)

# I loaded the 2021 covid data in Brazil and filtered it to show
# just the sum of new cases registered by region and date in a single dataset.

dfCovidBR <- readr::read_csv2('dados/HIST_PAINEL_COVIDBR_21abr2021.csv') %>% 
  dplyr::filter(is.na(municipio) & !is.na(estado)) %>% 
  group_by(regiao, data) %>% summarise(casosCovid = sum(casosNovos))

# From a single dataset I plotted the individual graphs of all
# regions of Brazil in 2021

grafCovid <- ggplot(dfCovidBR, aes(data, casosCovid)) + geom_col() + 
  ggthemes::theme_stata() +
  facet_wrap(facets = vars(regiao), nrow = 2) + 
  labs(title = 'CASOS NOVOS DE COVID NO BRASIL', subtitle = '2021', 
       caption = 'Source: Mercel Santos', x = 'Data', y = NULL) +
  scale_x_date(date_labels = '%b') +
  scale_y_continuous(labels = scales::label_number(scale = 1/100, 
                                                   suffix = 'mil'))

ggsave(plot = grafCovid, filename = 'graficos/grafCovid.jpg', width = 12, height = 10)
