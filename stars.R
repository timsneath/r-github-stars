library(googlesheets)
library(dplyr)
library(ggplot2)
library(ggthemes)

# This is the key for the relevant Google Sheets
starSheet <- gs_key("1s0Eyl4VLgc0dFrBsJFnrq8o_ghwFk6OchLI7GRsKfuo")

# Load and cleanse the Google Sheets
flutterStars <- starSheet %>% gs_read(ws="Flutter", range="A1:B16")
flutterStars$Date <- as.Date(flutterStars$Date, format="%m/%d/%Y")
colnames(flutterStars) <- c("Date", "Stars")

angularStars <- starSheet %>% gs_read(ws="Angular", range="A1:B16")
angularStars$Date <- as.Date(angularStars$Date, format="%m/%d/%Y")
colnames(angularStars) <- c("Date", "Stars")

goStars <- starSheet %>% gs_read(ws="Go", range="A1:B16")
goStars$Date <- as.Date(goStars$Date, format="%m/%d/%Y")
colnames(goStars) <- c("Date", "Stars")

# Now plot
graph <- ggplot(flutterStars, aes(Date, Stars)) +
  geom_line() +
  geom_line(data=angularStars) +
  geom_line(data=goStars) +
  ggtitle("GitHub Stars by Date") + 
  theme_fivethirtyeight()
graph