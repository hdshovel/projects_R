rm(list = ls())

library(magrittr)

# getting file fom url
download.file("https://mercelsantos.com/dados_curso/populacao.xls", 
              "/home/fred/R/Mercel/Curso/dados/pop.xls")

# checking the original data
dataOriginal1 <- readxl::read_excel('dados/pop.xls', skip = 3, sheet = 1)
head(dataOriginal1)

# loading and organizing data with pivot_longer creating column year and popu
df <- readxl::read_excel('dados/pop.xls', skip = 3, sheet = 1) %>% 
  tidyr::pivot_longer(data = ., cols = `1960`:`2020`, names_to = 'year',
                      values_to = 'popu')

# checking the original data
dataOriginal2 <- tidyr::billboard
head(dataOriginal2)

# loading and organizing data with pivot_longer creating column weeks and rank
dfBill <- tidyr::billboard %>% tidyr::pivot_longer(data = ., cols = wk1:wk76,
                                                   names_to = 'weeks',
                                                   values_to = 'rank')

# getting file fom url
download.file(url = 'https://mercelsantos.com/dados_curso/prec.csv',
              destfile = '/home/fred/R/Mercel/Curso/dados/prec.csv')

# checking the original data
dataOriginal3 <- read.csv("dados/prec.csv")
head(dataOriginal3)

# loading and organizing data with pivot_longer creating columns day and rain
# and transforming day into type date get free of NAs
df2 <- read.csv("dados/prec.csv") %>% tidyr::pivot_longer(data = ., 
                cols = starts_with(match = 'X', ignore.case = F),
                names_to = 'day', values_to = 'rain', names_prefix = 'X', 
                names_transform = list(day = lubridate::ymd), values_drop_na = T)
skimr::skim(df2)
