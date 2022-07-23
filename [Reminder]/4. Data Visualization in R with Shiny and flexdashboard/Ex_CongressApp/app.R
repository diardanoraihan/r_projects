#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(shiny)

# data import
dat <- read_csv("cel_dataset_coursera.csv")

# data wrangling
dat <- dat %>%
  select(c(Congress = congress, Ideology = dwnom1, Party = dem))

dat$Party <- recode(dat$Party, '1' = "Democrat", '0' = "Republican")

dat = drop_na(dat)

# make the static visualization for practice (this won't be displayed on the app)
ggplot(dat, aes(x = Ideology, color = Party, fill = Party))+
  geom_density(alpha = 0.5)+
  xlim(-1.5, 1.5)+
  labs(x = "Ideology - Nominate Score", 
       y = "Density")+
  scale_fill_manual(values = c("blue", "red"))+
  scale_color_manual(values = c("blue", "red"))

# add facet wrap to see change over time for practice (this won't be displayed on the app)
ggplot(dat, aes(x = Ideology, color = Party, fill = Party))+
  geom_density(alpha = 0.5)+
  xlim(-1.5, 1.5)+
  labs(x = "Ideology - Nominate Score", 
       y = "Density")+
  scale_fill_manual(values = c("blue", "red"))+
  scale_color_manual(values = c("blue", "red"))+
  facet_wrap(~Congress)

# Define UI for application that draws a figure
ui <- fluidPage(

    # Application title
    titlePanel("Ideology in Congress"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "my_cong", # the input variable that will be used to access the value
                        label = "Congress:",
                        min = 93,
                        max = 114,
                        value = 93)
        ),
        # Show a plot of the generated distribution
        mainPanel(
           plotOutput(outputId = "congress_distplot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$congress_distplot <- renderPlot({
     
      ggplot(
        filter(dat, Congress == input$my_cong), 
        # if the slider was set to thee 93, this filter line would look like this:
        # filter(dat, Congress == 93)
        # the value from the slider, assigned to "my_cong" in the UI goes into input$my_cong in
        # the server function.
        aes(x = Ideology, color = Party, fill = Party))+
        geom_density(alpha = 0.5)+
        xlim(-1.5, 1.5)+
        labs(x = "Ideology - Nominate Score", 
             y = "Density")+
        scale_fill_manual(values = c("blue", "red"))+
        scale_color_manual(values = c("blue", "red"))+
        facet_wrap(~Congress)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
