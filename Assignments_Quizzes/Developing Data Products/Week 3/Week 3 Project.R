


library(data.table)
library(RCurl)
library(plotly)
library(ggplot2)

url <- getURL("https://raw.githubusercontent.com/GrejSegura/DataBank/master/Philippine%2520Open%2520Data/SY%202015%20ENROLMENT%20DATA%20with%20GEOLOCATIONS%20-%20SECONDARY%20(1).csv")

data <- read.csv(text = url, sep = ",", header = T)
data <- setDT(data)
data <- data[municipality == "Davao City", ]

data[, male := year_1_male + year_2_male + year_3_male + year_4_male]
data[, female := year_1_female + year_2_female + year_3_female + year_4_female]
data[, total := male + female]

data <- data[ , c("province","municipality", "school_name", "male", "female", "total")]

any(is.na(data))

plot <- ggplot(data, aes(x = male, y = female)) + geom_jitter(size = 3, alpha = 0.5, aes(color = province)) +
        geom_smooth(method = "lm", se = TRUE, size = 0.3, color = "grey50", alpha = 0.7, show.legend = TRUE)
plot <- plot +  theme_minimal() + theme(text = element_text(color = "gray20"),
                                    plot.title = element_text(size = 14, face = "bold", vjust = 5),
                                    plot.margin = unit(c(.4,.4,.4,.4), "cm"),
                                    #for the legends
                                    legend.title = element_blank(),
                                    legend.text = element_blank(),
                                    
                                    
                                    #for the axis
                                    axis.text = element_text(),
                                    axis.title.x = element_text(vjust = 1, size = 12, face = 'bold'), # move title away from axis, size is the font size
                                    axis.title.y = element_text(vjust = 1, size = 12, face = 'bold'), # move away for axis, size is the font size
                                    axis.ticks.y = element_blank(), # element_blank() is how we remove elements
                                    axis.line = element_blank(),
                                    axis.line.y = element_blank(),
                                    
                                    panel.grid.major = element_blank(),
                                    panel.grid.major.x = element_blank())
plot
ggplotly(plot)



plot2 <- plot_ly(data, x = ~male , y = ~female, mode = "markers", color = as.factor(data$province))
