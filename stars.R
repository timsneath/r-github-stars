library(googlesheets)
library(dplyr)
library(ggplot2)
library(ggthemes)

# Clear plot window
while (dev.cur()>1) dev.off()

# This is the key for the relevant Google Sheets
starSheet <- gs_key("1s0Eyl4VLgc0dFrBsJFnrq8o_ghwFk6OchLI7GRsKfuo")

# Load and cleanse the Google Sheets
flutter <- starSheet %>% gs_read(ws = "Flutter", range = "A1:B20")
flutter$Date <- as.Date(flutter$Date, format = "%m/%d/%Y")
flutter$project <- "Flutter"
colnames(flutter) <- c("date", "stars", "project")

angular <- starSheet %>% gs_read(ws = "Angular", range = "A1:B16")
angular$Date <- as.Date(angular$Date, format = "%m/%d/%Y")
angular$project <- "Angular"
colnames(angular) <- c("date", "stars", "project")

go <- starSheet %>% gs_read(ws = "Go", range = "A1:B17")
go$Date <- as.Date(go$Date, format = "%m/%d/%Y")
go$project <- "Go"
colnames(go) <-c("date", "stars", "project")

repos <- rbind(flutter, angular, go)

# Now plot
ggplot(repos, aes(date, stars)) +
  geom_line(aes(color = project)) +
  labs(title = "GitHub stars by date",
       caption = "Source: http://timqian.com/star-history/") + 
  theme_fivethirtyeight() + 
  scale_color_fivethirtyeight() +
  theme(legend.position = "top", 
        legend.title = element_blank())