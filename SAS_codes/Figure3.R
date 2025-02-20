library(readxl)
library(ggplot2)
library(dplyr)
library(forcats)
library(patchwork)

all <- read_excel("C:/Users/Vira/Documents/cat.xlsx", na=".")
wgrains<- all %>% filter(exp == "Whole grains") %>%
  mutate(hr = as.character(hr),
         lower = as.character(lower),
         upper = as.character(upper))


df_tr <- data.frame(
  order = "a",
  target = "Substitute whole grains for",
  exp = "",
  hr = "",
  lower = "",
  upper = "",
  hrlab = "Hazard Ratio (95% CI)"
)

wgrains <- df_tr %>%
  bind_rows(wgrains) %>%
  mutate(order = fct_rev(fct_relevel(order, "a")))

tr <- wgrains %>%
  ggplot(aes(x = as.numeric(hr), y = order, xmin = as.numeric(lower), xmax = as.numeric(upper))) +
  geom_point(size = 3) +
  geom_errorbarh(height = 0.2, linewidth = 0.8) +
  geom_vline(xintercept = 1, linetype = "dotted") +
  scale_x_continuous(breaks = seq(0.7, 1.1, 0.1), limits = c(0.7, 1.1)) +
  labs(x = "Hazard Ratio (95% CI)") +
  theme_minimal() +
  theme(axis.line.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        axis.line.x = element_line(linewidth = 1),
        axis.text.x = element_text(size = 15),
        axis.title.x = element_text(size = 13))

tr

p1_tr <- wgrains %>%
  ggplot(aes(y = order)) +
  geom_text(
    size = 6,
    aes(x = 0, label = target),
    hjust = 0,
    fontface = ifelse(wgrains$target == "Substitute whole grains for", "bold", "plain")
  )+
  theme_void() +
  coord_cartesian(xlim = c(0, 4))
p1_tr

p2_tr <- wgrains %>%
  ggplot(aes(y = order)) +
  geom_text(
    size = 6,
    aes(x = 2, label = hrlab),
    hjust = 0,
    fontface = ifelse(wgrains$hrlab == "Hazard Ratio (95% CI)", "bold", "plain")
  ) +
  theme_void() +
  coord_cartesian(xlim = c(0, 4))
p2_tr


layout <- c(
  area(t = 0, l = 0, b = 15, r = 10), # left plot, starts at the top of the page (0) and goes 30 units down and 3 units to the right
  area(t = 1, l = 11, b = 15, r = 25), # middle plot starts a little lower (t=1) because there's no title. starts 1 unit right of the left plot (l=4, whereas left plot is r=3), goes to the bottom of the page (30 units), and 6 units further over from the left plot (r=9 whereas left plot is r=3)
  area(t = 0, l = 20, b = 15, r = 33),
  area(t = 0, l = 31, b = 15, r = 35)# right most plot starts at top of page, begins where middle plot ends (l=9, and middle plot is r=9), goes to bottom of page (b=30), and extends two units wide (r=11)
)
a <- p1_tr + tr + p2_tr + 
  plot_layout(design = layout)
a

ggsave("C:/Users/Vira/Documents/plot.pdf", plot = a, device = "pdf", width = 13, height = 6)


