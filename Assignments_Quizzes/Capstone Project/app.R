source("./src/replaceText.R")

nGramData <- fread('./dta/nGramData.csv')
unigramData <- readRDS('./dta/unigram.RData')

ui <- shinyUI(
        fluidPage(theme = "bootstrap.css",
                tabsetPanel(
                        tabPanel(div(style = "font-weight:bold; font-size:12px; color:#2471A3", 'Home'),
                                fluidRow(column(12, align="center",
                                        h4(" ", style="padding:20px;"))),
                                fluidRow(column(12, align="center",
                                        img(src='logo.png', align='center', width = 450, height = 180))),
                                fluidRow(column(12, align="center",
                                        h4(" ", style="padding:20px;"))),
                                fluidRow(column(12, align="center",
                                        h6(" "))),
                                fluidRow(column(12, align="center",
                                        textInput(inputId ='searchBar', label = div(style = "font-weight: normal; font-size:16px; color:#707B7C",'Type a phrase here (English only):'), value = '', width = '600px'))),
                                fluidRow(column(12, align="center",
                                        h4(" ", style="padding:20px;"))),
                                fluidRow(column(12, align="center",
                                        div(style = "font-size:16px; color:#707B7C","Top predicted next word:"))),
                                fluidRow(column(12, align="center",
                                        h4(" ", style="font-size:16px; padding:1px;"))),
                                fluidRow(column(12, align="center",
                                        div(style = "font-weight:bold; font-size:22px; color:#2471A3", textOutput("predict"))))
                                ),  #this closes the tabPanel1
                        tabPanel(div(style = "font-weight:bold; font-size:12px; color:#2471A3", 'About the App'),
                                 fluidRow(column(12, align="center",
                                        img(src='logo.png', align='center', width = 400, height = 160)))
                                 ) #this closes the tabPanel2
                        ) #this closes the tabsetPanels
                ) #this closes the fluidPage
        ) #this closes the shiny UI


##################################################################################################################################
##################################################################################################################################


server <- shinyServer(function(input, output){
        output$predict <- renderText({
                sentence <- input$searchBar
                wordBreakDown <- unlist(replaceText(sentence))
                wordBreakDown <- strsplit(wordBreakDown, split = " ")[[1]]
                numberWords <- length(wordBreakDown)
                scoreTable <- data.frame()
                if(numberWords == 0){
                        return('')
                } else if(numberWords >= 1){
                        # match 4 words with nGramData
                        if (numberWords > 4){
                                numberWords = 4
                        }
                        scoreTable <- data.frame()
                        for (i in 1:numberWords){
                                lastWords <- wordBreakDown[(length(wordBreakDown)-i):length(wordBreakDown)]
                                lastWords <- paste(lastWords, collapse = " ")
                                setOfNextWord <- nGramData[nGramData$typedWord %in% lastWords, ]
                                countWords <- setOfNextWord %>% group_by(nextWord) %>% 
                                        summarise(frequency = n()) %>% arrange(desc(frequency)) %>% top_n(n = 5, wt = frequency) %>%
                                        mutate(score = ((0.4^((numberWords+1)-i))*frequency)/nrow(setOfNextWord))
                                scoreTable <- as.data.frame(rbind(scoreTable, countWords))
                                scoreTable <- scoreTable %>% top_n(n = 5, wt = score)
                                scoreTable <- scoreTable[!(is.na(scoreTable$nextWord)),]
                                if (nrow(scoreTable) < 5){
                                        addUniGram <- as.data.frame(unigramData[1:(5-nrow(scoreTable)), c('nextWord')])
                                        scoreTable <- as.data.frame(full_join(scoreTable, addUniGram, by = 'nextWord'))
                                        return(as.character(unlist(scoreTable[, c('nextWord')])))
                                }
                                return(as.character(unlist(scoreTable[1:5, c('nextWord')])))
                        }
                }
        })
})                        

shinyApp(ui = ui, server = server)