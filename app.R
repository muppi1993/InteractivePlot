library(readr)
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(shinycssloaders)

#set working directory when running locally:
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

input_data <- read_csv("data/MED02836_line_list.csv",col_types = cols(`Sampling date` = col_datetime(format = "%Y-%m-%d"), `Penicillin resistance` = col_factor(levels = c("Sensitive", "Resistant")), `Macrolide resistance` = col_factor(levels = c("Sensitive", "Resistant"))))

# Define UI
ui <- fluidPage( 
    
    # title
    title="Interactive visualisation",
    titlePanel(h2("Interactive visualisation of epidemiological data", align="center")),
    
    # Sidebar layout
    sidebarLayout(
        
        #sidebarwith radio buttons
        sidebarPanel(width=3, style='margin: 30px 0 0 0',
                     
                     #selection of a grouping factor
                     radioButtons(inputId = "grouping_factor", label = "Grouping factor:",
                                  c("Type" = "Type",
                                    "Penicillin resistance" = "Penicillin resistance",
                                    "Macrolide resistance" = "Macrolide resistance"
                                  )),
                     
                     #selection of y-axis variable
                     radioButtons(inputId = "y", label = "Y-Axis:",
                                  c("Relative Frequency" = "Relative Frequency",
                                    "Absolute count" = "Absolute count"
                                  ))
        ),
        
        # main panel with resulting plot
        mainPanel(width=9,
                  plotlyOutput("plot") %>% withSpinner(color="#6495ed")
                  
        )
    )
)

# Define server logic
server <- function(input, output) {
    output$plot <- renderPlotly({
        
        #preprocessing data
        proc_data<- input_data %>%
            mutate(Year=format(`Sampling date`, format="%Y"))%>%
            group_by(Country,Year) %>%
            count(grouping_factor=get(input$grouping_factor), name="Absolute count") %>%
            mutate(`Relative Frequency`=`Absolute count`/sum(`Absolute count`))
        
        #create ggplot
        ggplot1<-ggplot(proc_data, aes(x=Year,y=get(input$y), group=grouping_factor)) +
            geom_point(aes(colour = proc_data$grouping_factor, text = paste(Year,":",round(get(input$y),3))))+ #will give a warning, but "text" will be used later by ggplotly() tooltip
            geom_line(aes(colour = proc_data$grouping_factor))+
            facet_grid(Country ~ .)+
            theme(legend.title = element_blank(), axis.text.x = element_text(angle = 90), axis.title.x = element_blank(),axis.title.y = element_blank(), strip.text.y = element_text(size = 12)) #axis & legend titles will be given in plotly() for better layout
        
        #make it an interactive plotly object
        ggplotly(ggplot1, tooltip = c("text"), height = 550)%>%
            config(modeBarButtonsToRemove = c('toImage','select2d','lasso2d','autoScale2d','toggleSpikelines','hoverCompareCartesian','hoverClosestCartesian'))%>%config(displaylogo = FALSE)%>% #remove redundant buttons & logo
            layout(legend = list(orientation = "h",xanchor = "center", x=0.5, y = -0.25, title=list(text=input$grouping_factor, size=12)), #position legend on bottom & give title
                   xaxis = list(title=list(text="Year", standoff = 8), titlefont=list(size=18)), #add xaxis title
                   margin = list(l=60) #prevent yaxis title to disappear when changing windowsize
            )%>%
            layout(annotations=list(xref = "paper", xanchor="right", x=0, xshift=-40, yref="paper", yanchor = "center", y=0.5, text=input$y,showarrow=F, textangle=-90))%>% #add yaxis title as annotation to have fixed position
            layout(font=list(size=18))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
