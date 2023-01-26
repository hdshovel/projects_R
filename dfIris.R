rm(list = ls())

library(ggplot2)


dfIris <- tibble::as.tibble(iris)
skimr::skim(dfIris)
unique(df2['Species'])
grafico_dfIris <- ggplot(dfIris, aes(Sepal.Length, Petal.Length,col = Species)) + 
  geom_point() + 
  geom_smooth(formula = y~x , method = 'lm', se = F, linewidth = 0.5, col = 'black')

grafico_dfIris <- grafico_dfIris + scale_x_continuous(name = 'Sepal', position = 'top') + 
  scale_y_continuous(name = 'Petal') 
grafico_dfIris <- grafico_dfIris + labs(title = 'PLOT IRIS', subtitle = 'Carlos Frederico',
                                    caption = 'Source: R', col = "Especies")

ggsave(plot = grafico_dfIris, filename = 'graficos/grafico_dfIris.jpg', width = 12, 
       height = 10, units = 'cm')


grafico_dfIris2 <- ggplot(dfIris, aes(Sepal.Length, Petal.Length, group = Species)) + 
  geom_point(aes(col = Species)) + 
  geom_smooth(formula = y~x , method = 'lm', se = F, linewidth = 0.5, col = 'black') +
  labs(title = 'PLOT IRIS', subtitle = 'Carlos Frederico',
       caption = 'Source: R', col = "Especies")

ggsave(plot = grafico_dfIris2, filename = 'graficos/grafico_dfIris2.jpg', width = 12, 
       height = 10, units = 'cm')
