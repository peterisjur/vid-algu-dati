library(tidyverse)
library(ggplot2)
library(ggthemes)

 processed_vid_data <- readRDS("data/processed_vid_data.rds")
str(processed_vid_data)


result <- processed_vid_data %>%
  filter(profesijas_kods %in% c("111110")) %>%
  select(profesijas_kods, datu_menesis, darba_vietu_skaits)%>%
  arrange(datu_menesis)
  




str(result)

ggplot(result, aes(x = datu_menesis, y = darba_vietu_skaits, color = profesijas_kods, group = profesijas_kods)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2.5) +
  labs(
    title = "Darba vietu skaits pa mēnešiem",
    subtitle = "Salīdzinājums profesiju kodiem 111110 Saeimas DEPUTĀTS un 111224 Valsts SEKRETĀRA VIETNIEKS",
    x = "Mēnesis",
    y = "Darba Vietu Skaits",
    color = "Profesijas Kods"
  ) +
  scale_x_date(date_breaks = "4 months", date_labels = "%m.%Y") + # <-- Mainiet intervālu šeit
  theme_fivethirtyeight(base_size = 16) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "top"
  )
