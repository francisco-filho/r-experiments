#install.packages("rgdal")
#devtools::install_github("dkahle/ggmap")
#install.packages("maptools")

library(dplyr)
library(stringr)
library(readr)
library(rgdal)

uf <- readOGR("/home/francisco/Downloads/shapes/29MUE250GC_SIR.shp")
br <- readOGR("/home/francisco/Downloads/shapes/UFEBRASIL.shp")
ll <- read_csv("/home/francisco/Downloads/shapes/municipios.csv")

ll <- ll %>% 
    filter(uf == 'BA')
    select(latitude, longitude)
#ba <- uf
ba <- fortify(uf) %>% 
    mutate(id = as.numeric(id))

br <- fortify(br) %>% 
    mutate(id = as.numeric(id))

theme_map <- function(...) {
    theme_classic() +
    theme(
        legend.position = "bottom",
        legend.direction = "horizontal",
        ...
    )
}

ggplot() + 
    geom_polygon(data=br, aes(long, lat, group=group, fill=id))  +
    geom_path(data=br, aes(long, lat, group = group), color = "white", size = 0.1) +
    geom_path(data=ba, aes(long, lat, group = group), color = "white", size = 0.1) +
#    geom_point(data=ll, aes(longitude, latitude), color="red") +
    theme_map() +
    labs(
        title = "Unidade Federativa da Bahia",
        subtitle= "Todos os municípios recentes e concretos no estado da Bahia",
        x = "Alguma altura",
        y = "Ocorrências",
        fill = "Ordenação"
    ) +
    coord_equal()