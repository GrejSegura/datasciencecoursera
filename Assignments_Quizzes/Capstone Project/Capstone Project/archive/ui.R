

'
shinyUI(fluidPage(
                fluidRow(column(12, align="center",
                        h4(" ", style="padding:20px;"))),
                fluidRow(column(12, align='center',
                        h1('Word Suggest'))),
#                fluidRow(column(12, align="center",
#                        textOutput(" "))),
#                fluidRow(column(12, align="center",
#                        textOutput(" "))),
                fluidRow(column(12, align="center",
                        h4(" ", style="padding:20px;"))),
                fluidRow(column(12, align="center",
                        textInput(inputId ='searchBar', label = '', value = '', width = '600px'))),
                fluidRow(column(12, align="center",
                        actionButton(inputId = 'nextFive', label = 'Clear All'))),
                fluidRow(column(12, align="center",
                        h4(" ", style="padding:20px;"))),
                fluidRow(column(12, align="center",
                        textOutput("text1"))),
                fluidRow(column(12, align="center",
                        h4(" ", style="padding:10px;"))),
                fluidRow(column(12, align="center",
                        textOutput("predict")))
                )
        )'