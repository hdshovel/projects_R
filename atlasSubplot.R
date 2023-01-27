rm(list = ls())

library(ggplot2)
library(ggthemes)
library(dplyr)

 
# Dataset original
head(readxl::read_excel('dados/atlas2013_dadosbrutos_pt.xlsx', sheet = 2))

# I created the region column from the first digit of the UF column, which represents
# the region of the country. 
dfAtlas <- readxl::read_excel('dados/atlas2013_dadosbrutos_pt.xlsx', sheet = 2) %>% 
  select(ANO, UF, ESPVIDA, MORT1) %>% mutate(regiao = UF %/% 10)

skimr::skim(dfAtlas)

# Plotting with subgraphs by region
graf_dfAtlasWrap <- dfAtlas %>% ggplot(aes(ESPVIDA, MORT1)) + geom_point() + 
  facet_wrap(facets = vars(regiao), nrow = 3) + theme_stata()
ggsave(plot = graf_dfAtlasWrap, filename = 'graficos/graf_dfAtlasWrap.jpg', 
       width = 12, height = 10)

# In this plot I show the relationship between ESPVIDA and MORT1 by region and 
# by year
graf_dfAtlasGrid <- dfAtlas %>% ggplot(aes(ESPVIDA, MORT1)) + geom_point() + 
  facet_grid(ANO~regiao, scales = 'fixed') + theme_stata()
ggsave(plot = graf_dfAtlasGrid, filename = 'graficos/graf_dfAtlasGrid.jpg', 
       width = 12, height = 10)

# Plotting with totals in the margins
graf_dfAtlasMargins <- dfAtlas %>% ggplot(aes(ESPVIDA, MORT1)) + geom_point() + 
  facet_grid(ANO~regiao, margins = T, scales = 'free') + theme_stata()
ggsave(plot = graf_dfAtlasMargins, filename = 'graficos/graf_dfAtlasMargins.jpg', 
       width = 12, height = 10)

# Including in the dataset MHDI classification column 
# (Low, Medium, High, Very High), according to interval: -Inf, .5, .8, .9, Inf
dfAtlas2 <- readxl::read_excel('dados/atlas2013_dadosbrutos_pt.xlsx', sheet = 2) %>% 
  select(ANO, UF, ESPVIDA, MORT1, IDHM) %>% 
  mutate(regiao = UF %/% 10, 
         idh_cat = cut(IDHM, breaks = c(-Inf, .5, .8, .9, Inf),
                      labels = c('Baixo', 'Medio', 'Alto', 'Muito Alto'), rigth = F))  

# I plotted ESPVIDA x MORT1 by region and year and classified according to MHDI.
graf_dfAtlas2 <- dfAtlas2 %>% ggplot(aes(ESPVIDA, MORT1)) + geom_point() +
  facet_grid(regiao~ANO+idh_cat) + theme_stata()
ggsave(plot = graf_dfAtlas2, filename = 'graficos/graf_dfAtlas2.jpg', 
       width = 12, height = 10)
