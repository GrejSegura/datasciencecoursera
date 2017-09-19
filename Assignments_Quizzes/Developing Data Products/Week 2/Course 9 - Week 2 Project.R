
library(leaflet)
library(RCurl)

url <- getURL("https://raw.githubusercontent.com/GrejSegura/DataBank/master/Philippine%2520Open%2520Data/SY%202015%20ENROLMENT%20DATA%20with%20GEOLOCATIONS%20-%20SECONDARY%20(1).csv")

data <- read.csv(text = url, sep = ",", header = T)
data <- data[data$province == "Compostela Valley"|data$province == "Davao Del Norte"|data$province == "Davao Del Sur"|data$province == "Davao Oriental", ]
data <- data[, c("school_name", "latitude", "longitude")]

na <- colSums(is.na(data))

data <- data[!(is.na(data$latitude)) | !(is.na(data$longitude)), ]
names(data)[c(2,3)] <- c("lat", "lng")
data_final <- data[, c(2,3)]

## make a map with icons

icon <- makeIcon(iconUrl = "https://cdn0.iconfinder.com/data/icons/education-flat-icons-set/128/school-building-512.png",
                 iconWidth = 31*215/230, iconHeight = 31,
                 iconAnchorX = 31*215/230/2, iconAnchorY = 16
                 )

map <- data_final %>% leaflet() %>% addTiles() %>%
  addMarkers(popup = as.character(data$school_name),
             icon = icon,
             clusterOptions = markerClusterOptions())
map