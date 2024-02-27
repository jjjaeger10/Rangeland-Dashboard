#### Intro to Shiny

# This script will load our first examples of Shiny apps. Shiny is an R package that allows you to build
# interactive web applications inside R. This will allow us to format and share data from the USSES in
# an accessible, customisable way with stakeholders and the public.

# If you have not already done so, please install the package. 
install.packages("shiny")

# Once you've installed R Shiny, you can load it in your environment:
library(shiny)

# Lets  run a few examples
runExample("01_hello")      # a histogram
runExample("02_text")       # tables and data frames
runExample("03_reactivity") # a reactive expression
runExample("04_mpg")        # global variables
runExample("05_sliders")    # slider bars
runExample("06_tabsets")    # tabbed panels
runExample("07_widgets")    # help text and submit buttons
runExample("08_html")       # Shiny app built from HTML
runExample("09_upload")     # file upload wizard
runExample("10_download")   # file download wizard
runExample("11_timer")      # an automated timer