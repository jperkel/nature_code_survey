library(tidyverse)

df <- read_csv("~/tmp/survey_results-20210211.csv")
p <- ggplot(df) + 
  geom_col(mapping = aes(x = reorder(tool, count), y = count)) + 
  xlab("tool") +
  labs(title = "'Code that transformed science' survey results",
       subtitle = "as of 11 Feb 2021") +
  coord_flip()
print(p)
ggsave("~/tmp/survey-results-20210211.jpg")