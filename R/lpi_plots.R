#########
## Plots for LPI Data
#########


### -- FILTER DATA FOR PLOTTING
#' filter df
#' @description filter lpi data by date, species for plotting
#' @param species character string of species to filter
#' @param start_date starting date of time period to visualize
#' @param end_date end date of time period to visualize
#' 
#' @import dplyr
lpi_plot_df <- function(species, start_date, end_date) {
  
  # filter df to selected subspecies
  plot_df <- dplyr::filter(lpi_long, Species %in% species)
  
  # filter df dates
  plot_df <- lpi_long %>%
    dplyr::filter(Date >= start_date) %>%
    dplyr::filter(Date <= end_date)
  
  return(plot_df)
} 


### - PLOTTING FUNCTIONS

#' @description Boxplot of percent cover of a single species across plot types
#' @param species character string of species to filter
#' @param start_date starting date of time period to visualize
#' @param end_date end date of time period to visualize
#' @param plot_type type of plot to generate
#' 
#' @import dplyr
#' @import ggplot2
#' 
#' @export
lpi_subsp_plot <- function(species, start_date, end_date, plot_type){
  
  # get df for plotting 
  plot_df <- lpi_plot_df(species, start_date, end_date)
  
  # build base plot depending on plot type
  if(plot_type == "boxplot") {
    p <- ggplot2::ggplot(plot_df, aes(x = Plot_Type, y = Percent_Cover)) + 
      ggplot2::geom_boxplot(aes(fill = species), alpha = 0.5) +
      ggplot2::facet_wrap(vars(Plot_Type))
      
  }
  if(plot_type == "barplot") {
    p <- ggplot2::ggplot(plot_df, aes(x = Plot_Name, y = Percent_Cover)) + 
      ggplot2::geom_col(aes(fill = species), 
                               alpha = 0.5, position = "dodge") + 
      ggplot2::facet_wrap(vars(Plot_Type), scales = "free_x")
  }
  
  # add plot aesthetics
  p <- p + 
    theme_bw() + 
    labs(x = "Plot", y = "Percent Cover",
         title = paste0(paste(species, collapse = ", "), 
                        " Percent Coverage by Plot Type"))
  
  
  return(p)
}

