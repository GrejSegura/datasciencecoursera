## THIS IS A SHINY APP I MADE FOR THE COMPLIANCE OF MY WEEK 4 DEVELOPING DATA PRODUCTS PEOJECT IN COURSERA ##
## DATA TAKEN FROM PIDS.GOV.PH ##

rm(list = ls())
library(shiny)
library(data.table)

data <- read.csv("./philippines economic indicators.csv", header = TRUE)
data <- setDT(data)

row1 <- t(data[1, ])

colnames(data) <- row1
data <- data[-1, ]

data <- t(data)
data <- t(data)
data <- as.data.frame(data)

data[] <- apply(data, 2, function(x) gsub("[^0-9.]", "", x))
data[] <- apply(data, 2, function(x) as.numeric(x))

sumNA <- colSums(is.na(data))/nrow(data)
sumNA <- which(sumNA > 0.7)
data1 <- data[, -sumNA]

names <- names(data1)

data1 <- data1[, 1:49]
data1 <- data1[, -c(8:18, 21, 23,24, 26:42, 43, 44, 47:49)]
names(data1) <- c("Year", "Population", "Population Density", "Population Annual Growth", "Urban Population - Percent of Total Population", "Labor Force (thousand)", "Employed", "Unemployed", "Unemployment Rate", "Labor Force Participation Rate", "GDP", "Net Factor Income from Abroad", "GNI")

varNames <- names(data1)
write.csv(data1, "./data.csv")

###################################################################################################
###################################################################################################

ui <- shinyUI(fluidPage(
        
        # Application title
        titlePanel("Relationship of Economic Indicators in the Philippines"),
        
        # Sidebar
        sidebarLayout(
                sidebarPanel(
                        selectInput(varNames,
                                    varNames,
                                    min = 1,
                                    max = 50,
                                    value = 30)
                ),
                
                # Show a plot of the relationship
                mainPanel(
                        plotOutput("scatterPlot")
                )
        )
))




server <- shinyServer(function(input, output) {
        
        output$scatterPlot <- renderPlot({
                
                # generate bins based on input$bins from ui.R
                # data1 <- setDT(data1)
                x    <- data1[, input$varNames]
                varNames <- names(data1)
                
                # draw the histogram with the specified number of bins
                ggplot(data1, aes(x = x, y = y, size = as.factor(data1$Year), fill = as.factor(data1$Year))) + geom_point(alpha = 0.7)
                
        })
        
})
