# InteractivePlot
Solution to MED02836 exercise as part of the application as Research Software Engineer (Web Development) at Imperial College London, DIDE

## Run locally
Download the code using:
```
git clone https://github.com/muppi1993/InteractivePlot
```
In a R console, go into this folder and run:
```
library(shiny)
runApp()
```

If using RStudio, it's also possible to select 'Run App' in the top right corner of the source pane when app.R is opened.
Make sure to set the working directory correctly by running:

```
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
```

## Run online
Visit http://muppi1993.shinyapps.io/interactiveplot to see the web version of the app.

## Use of the Interactive visualisation tool
The use should be very intuitive. 

In the sidebar on the left the user can select different options for both the y-axis and the factor of interest to group the data. 

The plot in the main panel reacts automatically to changes to the radio buttons.
