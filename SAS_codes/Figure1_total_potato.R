library(tidyverse)
library(readxl)

spline <- read_excel("C:/Users/Vira/Documents/dose.xlsx")

tpotat <- spline %>%
  mutate(value = as.numeric(value),
         estimate = as.numeric(estimate),
         lower = as.numeric(lower),
         upper = as.numeric(upper))

plot<-tpotat %>% 
  ggplot(aes(x = value, y = estimate)) +
  geom_line()+
  geom_ribbon(aes(x = value, ymin = lower, ymax = upper), fill = "#90d2d8", alpha = 0.5) +
  scale_y_continuous(limits = c(0.9, 1.3), breaks = seq(0.9, 1.3, 0.1)) +
  scale_x_continuous(limits = c(0, 6), breaks = seq(0, 6, 1)) +
  theme_light() +
  geom_hline(yintercept = 1, linetype="dashed", linewidth=0.5)+
  xlab("Total potato(servings/week)") +
  ylab("Hazard Ratio (95% CI)") +
  theme(axis.text=element_text(size=16),
        axis.title.y.left=element_text(size=18, face="bold", vjust = 2),
        axis.title.x=element_text(size=18, face="bold", vjust = 0),
        plot.title = element_text(face="bold", size = 20))

print(plot)

ggsave("plot.pdf", plot = plot, width = 11, height = 8.5, path = "C:/Users/Vira/Documents/")