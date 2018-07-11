


shinyUI(fluidPage(
        # Application title
                titlePanel("Word Suggest"),
        
        # Sidebar
#        sidebarLayout(        
#                sidebarPanel(        #selectInput("varNames1",
                        #            "Select X-axis:",
                        #            selected = varNames[2],
                        #            varNames
                        #),
                        #selectInput("varNames2",
                        #            "Select Y-axis:",
                        #            selected = varNames[3],
                        #            varNames
                        #),
                        #selectInput("varNames3",
                        #           "Select Size Scale:",
                        #            selected = varNames[5],
                        #            varNames
                        #),
                        #width = 3'
                        #),
                textInput(inputId = 'searchBar', label = '', value = ''),
#                mainPanel(
                textOutput("predict"), 
                actionButton(inputId = 'nextFive', label = 'next 5 words')
                )
                #)        
        )