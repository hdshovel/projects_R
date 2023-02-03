rm(list = ls())

library(ggplot2)
library(dplyr)

# Carregando dados
df <- readr::read_csv('dados/data_sus_13_14.csv')

# Dados originais
head(df)

# Analisando NAs
skimr::skim(df)
naniar::gg_miss_var(df, show_pct = T)
naniar::gg_miss_var(df, facet = sexo, show_pct = T)
naniar::gg_miss_upset(df)

# Numero mensal de suicidios em Alagoas ano 2014
dfsa <- df %>% 
  dplyr::filter(circobito == 'Suicídio' & mun_res_uf == 'Alagoas' & 
                  lubridate::year(dtobito) == 2014) %>% 
  group_by(meses = lubridate::month(dtobito)) %>% na.omit() %>% summarise(n_obitos = n())
skimr::skim(dfsa)

# Plotando dfsa
graf_barra <- ggplot(dfsa, aes(meses, n_obitos)) + 
                geom_col(width = 0.6, fill = 'tomato', col = 'black') +
                geom_text(aes(label = n_obitos), nudge_y = 0.5) +
                scale_x_continuous(breaks = 1:12, 
                                   labels = c('Jan', 'Fev', 'Mar', 'Abr', 'Mai',
                                'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez')) +
                labs(title = 'SUICÍDIO EM ALAGOAS', subtitle = 'Ano 2014', 
                    caption = 'Mercel Santos', x = NULL, y = 'Qde')

ggsave(plot = graf_barra, filename = 'graficos/graf_barra.jpg', width = 12, 
       height = 10, units = 'cm')

# Plot anterior por genero.
dfsag <- df %>% 
  dplyr::filter(circobito == 'Suicídio' & mun_res_uf == 'Alagoas' & 
                  lubridate::year(dtobito) == 2014) %>% 
  group_by(meses = lubridate::month(dtobito), genero = sexo) %>% na.omit() %>% 
  summarise(n_obitos = n())

graf_barra2 <- ggplot(dfsag, aes(meses, n_obitos, fill = genero)) + 
                geom_col(width = 0.6, position = 'dodge') +
                geom_text(aes(label = n_obitos, col = genero), show.legend = F, 
                          nudge_y = 0.5, nudge_x = c(-0.2, 0.2)) +
  scale_x_continuous(breaks = 1:12, labels = c('Jan', 'Fev', 'Mar', 'Abr', 'Mai',
                            'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez')) +
  ggthemes::theme_clean() + scale_fill_manual(values = c('#F08080', '#00FFFF')) +
  scale_color_manual(values = c('#F08080', '#00FFFF')) +
  labs(title = 'SUICÍDIO EM ALAGOAS', subtitle = 'Ano 2014', 
       caption = 'Mercel Santos', x = NULL, y = 'Qde', fill = NULL) +
  theme(plot.title = element_text(hjust = 0.5), legend.position = 'top')

ggsave(plot = graf_barra2, filename = 'graficos/graf_barra2.jpg', width = 12, 
       height = 10, units = 'cm')


