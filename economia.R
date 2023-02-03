rm(list = ls())

library(ggplot2)

# Loading data

head(df <- readr::read_csv('dados/economia.csv'))
skimr::skim(df)

# I have normalized the dollar and Bovespa columns by dividing each one by its 
# respective minimums
graf_ecomonia_min <- ggplot(df, aes(data, dolar/min(dolar))) + 
                    geom_line(aes(col = 'Dolar')) +
                    geom_line(aes(y = indiceBovespa/min(indiceBovespa), col = 'BS3'))

graf_ecomonia_min <- graf_ecomonia_min + labs(title = 'DOLAR x BS3', 
                      subtitle = 'Rate of Change', x = NULL, y = NULL, col = NULL) +
  theme(legend.box.margin = margin(b = -11), legend.position = 'top')

ggsave(plot = graf_ecomonia_min, filename = 'graficos/graf_ecomonia_min.jpg', 
       width = 12, height = 10, units = 'cm')


