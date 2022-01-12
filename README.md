# InteractivePlot
Solution to MED02836 exercise as part of the application as Research Software Engineer (Web Development) at Imperial College London.

This app was built using R shiny.

## Run locally
Download the code with:
```
git clone https://github.com/muppi1993/InteractivePlot
```
In an R console, go into this folder and run:
```
library(shiny)
runApp()
```

If using RStudio, it's also possible to select 'Run App' in the top right corner of the source pane when app.R is opened.
Make sure to set the working directory correctly by running:

```
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
```
The following R packages are required: `readr`,`shiny`,`dplyr`,`ggplot2`,`plotly` and `shinycssloaders`. If necessary install them with `install.packages("packagename")`.

## Run online
Visit http://muppi1993.shinyapps.io/interactiveplot to see the web version of the app.

## Use of the Interactive visualisation tool
The use should be very intuitive. 

In the sidebar on the left the user can select different options for both the y-axis and the factor of interest to group the data. 

The plot in the main panel reacts automatically to changes to the radio buttons. By clicking on the legend items the groups can be plotted separately. The buttons in the top right corner allow the user to adjust the displayed area.
