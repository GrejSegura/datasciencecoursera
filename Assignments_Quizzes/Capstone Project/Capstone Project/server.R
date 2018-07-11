
source("./src/4_stpdBackOffAlgorithm.R")

shinyServer(function(input, output){
        output$predict <- renderText({
        sentence <- input$searchBar
        wordBreakDown <- unlist(replaceText(sentence))
        wordBreakDown <- strsplit(wordBreakDown, split = " ")[[1]]
        numberWords <- length(wordBreakDown)
        
'        fiveWords <- as.data.frame(fiveWordsMatchPredict(sentence))
        fiveWords <- as.data.frame(fiveWords[!(is.na(fiveWords[,1])),])
        k5 <- nrow(fiveWords)
        
        fourWords <- as.data.frame(fourWordsMatchPredict(sentence))
        fourWords <- as.data.frame(fourWords[!(is.na(fourWords[,1])),])
        k4 <- nrow(fourWords)
        
        threeWords <- as.data.frame(threeoWordsMatchPredict(sentence))
        threeWords <- as.data.frame(threeWords[!(is.na(threeWords[,1])),])
        k3 <- nrow(threeWords)
        
        twoWords <- as.data.frame(twoWordsMatchPredict(sentence))
        twoWords <- as.data.frame(twoWords[!(is.na(twoWords[,1])),])
        k2 <- nrow(twoWords)
'
                        
        if(numberWords == 0){
                        return('')
                } else if(numberWords == 1){
                                return(as.character(unlist(unigramDta[1:5,1])))
                } else if(numberWords == 2){
                                return(as.character(twoWordsMatchPredict(sentence)))
                } else if(numberWords == 3){
                                return(as.character(threeWordsMatchPredict(sentence)))
                } else if(numberWords >= 4){
                                return(as.character(fourWordsMatchPredict(sentence)))
                } else {
                                return('Error')
                        }
        })
})