
source("./src/stpdBackOffAlgorithm.R")
source("./src/replaceText.R")


shinyServer(function(input, output){
        output$predict <- renderText({
                sentence <- input$searchBar
                #                sentence <- 'you have to go to'
                wordBreakDown <- unlist(replaceText(sentence))
                wordBreakDown <- strsplit(wordBreakDown, split = " ")[[1]]
                numberWords <- length(wordBreakDown)
                scoreTable <- data.frame()
                if(numberWords == 0){
                        return('')
                } else if(numberWords == 1){
                        return(as.character(unlist(unigramDta[1:5,1])))
                } else if(numberWords >= 1){
                        # match 4 words with nGramData
                        if (numberWords > 4){
                                numberWords = 4
                        }
                        scoreTable <- data.frame()
                        for (i in 1:numberWords){
                                lastWords <- wordBreakDown[(length(wordBreakDown)-i):numberWords]
                                lastWords <- paste(lastWords, collapse = " ")
                                setOfNextWord <- nGramData[nGramData$typedWord %in% lastWords, ]
                                countWords <- setOfNextWord %>% group_by(nextWord) %>% 
                                        summarise(frequency = n()) %>% arrange(desc(frequency)) %>% top_n(n = 5, wt = frequency) %>%
                                        mutate(score = ((0.4^((numberWords+1)-i))*frequency)/nrow(setOfNextWord))
                                scoreTable <- as.data.frame(rbind(scoreTable, countWords))
                                scoreTable <- scoreTable %>% top_n(n = 5, wt = score)
                                scoreTable <- scoreTable[!(is.na(scoreTable$nextWord)),]
                                if (nrow(scoreTable) < 5){
                                        addUniGram$nextWord <- unigramDta[1:nrow(scoreTable), 1]
                                        scoreTable <- rbind(scoreTable, addUniGram)
                                        return(as.character(unlist(scoreTable[, c('nextWord')])))
                                }
                                return(as.character(unlist(scoreTable[, c('nextWord')])))
                        }
                        #mutate(score = ((0.4^(i))*frequency)/nrow(setOfNextWord))
                }
        })
})                        
