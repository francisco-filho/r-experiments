#install.packages("rgdal")
#devtools::install_github("dkahle/ggmap")
#install.packages("maptools")
#install.packages("ex)
#devtools::install_github("hrbrmstr/hrbrthemes")
#hrbrthemes::import_roboto_condensed()


library(dplyr)
library(ggplot2)
library(stringr)
library(readr)
library(rgdal)
library(extrafont)
library(hrbrthemes)


#font_import(paths = "~/.local/share/fonts/",prompt = F)

uf <- readOGR("/home/francisco/Downloads/shapes/29MUE250GC_SIR.shp")
br <- readOGR("/home/francisco/Downloads/shapes/UFEBRASIL.shp")
ll <- read_csv("/home/francisco/Downloads/shapes/municipios.csv")

ll <- ll %>% 
    filter(uf == 'BA') %>% 
    select(latitude, longitude)
#ba <- uf
ba <- fortify(uf) %>% 
    mutate(id = as.numeric(id))

br <- fortify(br) %>% 
    mutate(id = as.numeric(id) + .01)

theme_map <- function(...) {
    theme_classic() +
    theme(
        axis.line = element_line(size=.2),
        legend.position = "bottom",
        legend.direction = "horizontal",
        plot.title = element_text(family="Libre Franklin", size=16, face="bold", color="#111111"),
        plot.subtitle = element_text(family="Libre Franklin Thin", size=12,color="#333333"),
        ...
    )
}

ggplot() + 
    geom_polygon(data=br, aes(long, lat, group=group, fill=id))  +
    #geom_path(data=br, aes(long, lat, group = group), color = "white", size = 0.1) +
    geom_path(data=ba, aes(long, lat, group = group), color = "white", size = 0.1) +
    #geom_point(data=ll, aes(longitude, latitude), color="red") +
    #theme_map() +
    theme_ipsum() +
    labs(
        title = "\nCisco Smart Install (SMI) Proble/Attack Summary",
        subtitle= "Todos os municípios recentes e concretos no estado da Bahia",
        x = "Alguma altura",
        y = "Ocorrências",
        fill = "Ordenação"
    ) +
    coord_equal()
