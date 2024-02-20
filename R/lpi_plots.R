#########
## Plots for LPI Data
#########




### Boxplot of percent cover of a single species across plot types
# @param species character string of species to filter
lpi_onesp_pc <- function(species, start_date, end_date){
  
  # filter df to single species
  plot_df <- dplyr::filter(lpi_long, Species %in% species)
  
  # filter df dates
  plot_df <- lpi_long %>%
    dplyr::filter(Date >= start_date) %>%
    dplyr::filter(Date <= end_date)

  
  # build plot
  p <- ggplot(plot_df, aes(x = Plot_Type, y = Percent_Cover)) + 
    geom_boxplot(alpha = 0) + 
    theme_bw() + 
    labs(x = "Plot Type", y = "Percent Cover",
         title = paste0(species, " Percent Coverage by Plot Type"))
  
  return(p)
}
