rm(list = ls())

library(ggplot2)
library(magrittr)
library(lubridate)


dfIbovespa <- readr::read_csv('dados/ibovespaOK.csv')
skimr::skim(dfIbovespa)
class(dfIbovespa$ibovespa)

# plotting with Ibovespa data

graf_dfIbovespa <- dfIbovespa %>% ggplot(aes(data, ibovespa)) + geom_line(col = 'coral')
graf_dfIbovespa <- graf_dfIbovespa + scale_x_date(limits = c(ymd('2017/01/01'),
                                                             ymd('2018/01/01')),
                                                  date_breaks = '3 months')
graf_dfIbovespa <- graf_dfIbovespa + labs(title = 'IBOVESPA', subtitle = '2017/2018', 
                                          caption = 'Mercel Santos', x = 'Datas', 
                                          y = NULL)

ggsave(plot = graf_dfIbovespa, filename = 'graficos/graf_dfIbovespa.jpg', width = 12, 
       height = 10, units = 'cm')


# plotting only 2019 data

graf_dfIbovespa2019 <- dfIbovespa %>% dplyr::filter(year(data)==2019) %>% ggplot(aes(data, ibovespa)) +
  geom_line(col = 'coral') + scale_x_date(breaks = scales::breaks_width('2 months'),
                              labels = scales::label_date(format = '%B')) +
  labs(title = 'IBOVESPA', subtitle = 'Periodo simples', caption = 'Mercel Santos', 
       x = '2019', y = NULL)

# Plotting February 2019 every 3 days

graf_dfIbovespa3em3 <- dfIbovespa %>% dplyr::filter(year(data)==2019 & month(data)==2) %>% 
  ggplot(aes(data, ibovespa)) + geom_line(col = 'coral') + 
  scale_x_date(breaks = scales::breaks_width('3 days'),
              labels = scales::label_date(format = '%m/%d')) +
  labs(title = 'IBOVESPA', subtitle = 'Fevereiro, 3 em 3 dias', 
       caption = 'Source: Mercel Santos', x = '2019', y = NULL)

ggsave(plot = graf_dfIbovespa3em3, filename = 'graficos/graf_dfIbovespa3em3.jpg',
       width = 12, height = 10)
