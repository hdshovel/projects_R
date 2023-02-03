rm(list = ls())

library(ggplot2)
library(dplyr)


# Dataset original
head(readxl::read_excel('dados/atlas2013_dadosbrutos_pt.xlsx', sheet = 3))

# I created the region column from the first digit of the UF column, which 
# represents the region of the country. 
dfAtlas3 <- readxl::read_excel('dados/atlas2013_dadosbrutos_pt.xlsx', sheet = 3) %>% 
  janitor::clean_names() %>% dplyr::filter(ano == 2010) %>%  
  select(ufn, t_env, t_analf18a24) 

graf_dfAtlas3 <- ggplot(dfAtlas3, aes(ufn, t_analf18a24)) + 
  geom_col(aes(fill = 'Illiteracy rate'), width = 0.5)
# adding line
graf_dfAtlas3 <- graf_dfAtlas3 + geom_line(aes(y = t_env, group = 1, 
                                               col = 'Aging rate'))

# adding points
graf_dfAtlas3 <- graf_dfAtlas3 + geom_point(aes(y = t_env, group = 1, 
                                                col = 'Aging rate'),
                                            fill = 'grey80', pch = 21)

# ajustando fill para deixar as colunas transparentes 
graf_dfAtlas3 <- graf_dfAtlas3 + scale_fill_manual(values = alpha('tomato', 0.8))

# adjusting fill to make columns transparent 
graf_dfAtlas3 <- graf_dfAtlas3 + scale_color_manual(values = 'grey30')

# adjusting titles and subtitles 
graf_dfAtlas3 <- graf_dfAtlas3 + 
  labs(title = 'SOCIO-ECONOMIC INDEX', fill = NULL, color = NULL, x = NULL, 
       subtitle = 'From 18 a 24 years', y = NULL)

graf_dfAtlas3 <- graf_dfAtlas3 + theme_light() + 
  theme(legend.position = 'top', 
        axis.text.x = element_text(angle = 45, hjust = 1),
        legend.box.margin = margin(b = -11))

ggsave(plot = graf_dfAtlas3, filename = 'graficos/graf_atlasBar.jpg', width = 12, 
       height = 10, units = 'cm')
