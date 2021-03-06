################################################################################################################################
################################################################################################################################

rm(list = ls())
library(shiny)
library(ggplot2)
library(ggrepel)
library(extrafont)
library(plotly)
data <- read.csv("./data.csv", sep = ",")
data <- data[, -1]
varNames <- names(data[, -1])
varList <- c("Population (millions)","Population Density (per km. sq.)", "Population Annual Growth", "Urban Population Percent of Total Population",	"Labor Force (thousands)", "Employed (thousands)", "Unemployed (thousands","Unemployment Rate", "Labor Force Participation Rate", "GDP","Net Factor Income from Abroad", "GNI")


################################################################################################################################
################################################################################################################################

ui <- shinyUI(fluidPage(
	
	# Application title
	titlePanel("Relationship of Economic Indicators in the Philippines"),
	
	# Sidebar
	sidebarLayout(
		sidebarPanel(
			selectInput("varNames1",
				    "Select X-axis:",
				    selected = varNames[2],
				    varNames
			),
			selectInput("varNames2",
				    "Select Y-axis:",
				    selected = varNames[3],
				    varNames
			),
			selectInput("varNames3",
				    "Select Size Scale:",
				    selected = varNames[5],
				    varNames
			),
			width = 3
		),
		mainPanel(plotOutput("scatterPlot"), width = 10)
	)))
	
################################################################################################################################
################################################################################################################################


server <- shinyServer(function(input, output) {
        
        output$scatterPlot <- renderPlot({
                
        	index1 <- which(varNames %in% input$varNames1)
        	index2 <- which(varNames %in% input$varNames2)
        	index3 <- which(varNames %in% input$varNames3)
        	index1 <- varList[index1]
        	index2 <- varList[index2]
        	index3 <- varList[index3]
        	
                x <- data[, input$varNames1]
                y <- data[, input$varNames2]
                z <- data[, input$varNames3]
                max <- max(x) + round(max(x)/20)
                min_x <- min(x) - round(max(x)/20)
                
                may <- max(y) + max(y)/5
                min_y <- min(y) - max(y)/5
                
                
                # create 17-color pallette
                colorvalue = c("#046a2f", "#902d08", "#ce1b20", "#126db2", "#2c1d4d", "#101110",
                	       "#ff9999","#111188", "#aa8888", "#229922", "#3f7f40", "#555577",
                	       "#118811","#e50d0b", "#4c3d3d", "#a80100", "#002200")
                g <- ggplot(data, aes(x = x, y = y, size = z, colour = as.factor(data$Year), label = Year)) + geom_point(alpha = 0.9)
                g <- g + scale_radius(range = c(5,30), name = index3)
                g <- g + labs(x = paste("\n",index1), y = paste(index2, "\n"), title = paste(index1,' vs. ',index2, " \n(with ", index3, " as Size)"))
                g <- g + theme_minimal() + theme(panel.background = element_rect(fill = "white", colour = "grey50"))
                g <- g + scale_colour_manual(values = colorvalue, guide = FALSE)
                
                g <- g + xlim(min_x, max) + ylim(min_y, may)
	        g <- g + geom_text_repel(point.padding = NA, size = 3, color = "gray10")
                
                g
        }, height = 600, width = 1400, res = 120)
})

shinyApp(ui = ui, server = server)
################################################################################################################################
################################################################################################################################

