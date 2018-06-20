library(googlesheets)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(scales)
library(extrafont)

# Clear plot window
while (dev.cur() > 1)
  dev.off()

# This is the key for the relevant Google Sheets
starSheet <- gs_key("1s0Eyl4VLgc0dFrBsJFnrq8o_ghwFk6OchLI7GRsKfuo")

# Load and cleanse the Google Sheets
flutter <- starSheet %>% gs_read(ws = "Flutter", range = "A1:B20")
flutter$Date <- as.Date(flutter$Date, format = "%m/%d/%Y")
flutter$project <- "Flutter"
colnames(flutter) <- c("date", "stars", "project")

# Now plot
ggplot(flutter, aes(date, stars)) +
  geom_area(colour = "#0298e7", fill = "#0298e7") +
  geom_vline(xintercept = c(as.Date("2018/02/27"), as.Date("2018/05/07")), colour = "#003d75") +
  geom_label(aes(x = as.Date("2018/02/27"), y = 25000, label = "Beta 1"),
             size = 3,
             family = "Open Sans") +
  geom_label(aes(x = as.Date("2018/05/07"), y = 25000, label = "I/O"),
             size = 3,
             family = "Open Sans") +
  labs(title = "GitHub stars by date",
       caption = "Source: http://timqian.com/star-history/") +
  scale_x_date(date_breaks = "3 months", date_minor_breaks = "1 month",
               labels = date_format("%b %y")) +
  scale_y_continuous(label = comma) +
  coord_cartesian(xlim = c(as.Date("2015/07/01"), as.Date("2018/06/20")), expand = FALSE) +
  theme_fivethirtyeight() +
  theme(legend.position = "none",
        plot.title = element_text(margin = margin(0, 0, 20, 0)),
        plot.background = element_rect(fill = "white"),
        plot.caption = element_text(size = 9, margin = margin(20, 0, 0, 0)),
        text = element_text(family = "Open Sans"))
