library(tidyverse)

df <- read_csv("survey_results-20210212.csv")
p <- ggplot(df) + 
  geom_col(mapping = aes(x = reorder(tool, count), y = count)) + 
  xlab("tool") +
  labs(title = "'Code that transformed science' survey results",
       subtitle = "as of 11 Feb 2021") +
  coord_flip()
ggsave("survey-results-20210212.jpg", p)
