# Saves a corpus of n-grams using the function created in 3_createNGramData.R



if(!file.exists("./dta/nGramData.csv") | !file.exists("./dta/unigram.RData")){
        source("./src/1_preprocess.R")
        source("./src/replaceText.R")
        source("./src/3_createNGramData.R")
        load("./dta/textDta.RData")
        
        textDta <- textDta[sample(1:nrow(textDta), 0.3*nrow(textDta)),] ## use only 50% of the data to minimize memory
        
        createUniGram(textDta)
        createBiGram(textDta)
        createTriGram(textDta)
        createQuadGram(textDta)
        createFiveGram(textDta)
        
        bigramDta <- readRDS('./dta/bigram.RData')
        trigramDta <- readRDS('./dta/trigram.RData')
        quadgramDta <- readRDS('./dta/quadgram.RData')
        fivegramDta <- readRDS('./dta/fivegram.RData')
        
        nGramData <- setDT(as.data.frame(rbind(bigramDta, trigramDta, quadgramDta, fivegramDta)) )
        nGramData <- nGramData[, count := seq_len(.N), by = nextWord]
        nGramData <- nGramData[count > 4,]
        nGramData <- nGramData[, count := NULL]
        
        fwrite(nGramData, './dta/nGramData.csv')
} else {print('File already loaded!')}

