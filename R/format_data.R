# data formatting for working into shiny apps

library(dplyr)
library(lubridate)
library(stringr)

# load data
biomass <- read.csv("./data/biomass.csv")
floral <- read.csv("./data/floral_density.csv")
lpi <- read.csv("./data/master_foliar.csv")
bt <- read.csv("./data/belt_transect.csv")
rb <- read.csv("./data/robel_mean.csv")
lpi_bg <- read.csv("./data/lpi_bg.csv")

# convert dates to date objects and add separate columns for just year and month

convert_dates <- function(df) {
  df <- df %>%
    dplyr::mutate(Date = lubridate::mdy(Date)) %>%
    dplyr::mutate(Year = lubridate::year(Date)) %>%
    dplyr::mutate(Month = lubridate::month(Date, label = T))
  
  return(df)
}

biomass <- convert_dates(biomass)
floral <- convert_dates(floral)
lpi <- convert_dates(lpi)
bt <- convert_dates(bt)
rb <- convert_dates(rb)
lpi_bg <- convert_dates(lpi_bg)

# pivot lpi so all species are in single column
lpi_long <- lpi %>%
  tidyr::pivot_longer(ABLA:WYHE2.DEAD, 
                      names_to = "Species", 
                      values_to = "Percent_Cover")

# extract lpi plot type 
lpi_long <- lpi_long %>%
  dplyr::mutate(Plot_Type = if_else(stringr::str_detect(Plot, "Grass"), "Grass",
                            if_else(stringr::str_detect(Plot, "Open"), "Open Conifer",
                            if_else(stringr::str_detect(Plot, "Sage"), "Sagebrush", "Tall Forb"))))

# add factor if plot is an exclosure
lpi_long <- lpi_long %>%
  dplyr::mutate(Exclosure = if_else(str_detect(Plot, "Ex"), 1, 0))

# extract plot number
lpi_long <- lpi_long %>%
  dplyr::mutate(Plot_Name = as.numeric(stringr::str_extract_all(Plot, "[0-9]+")))
