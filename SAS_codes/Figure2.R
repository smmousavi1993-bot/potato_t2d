library(readxl)
library(ggplot2)
library(dplyr)
library(forcats)
library(patchwork)

all <- read_excel("C:/Users/Vira/Documents/cat.xlsx", na=".")
all[all$pval == "4.0000000000000001E-3",]$pval <- "0.004"
tpotat <- all %>% filter(exp == "Total potato") %>%
  mutate(hr = as.character(hr),
         lower = as.character(lower),
         upper = as.character(upper))
prmeat <- all %>% filter(exp == "Baked, boiled, mashed potato") %>%
  mutate(hr = as.character(hr),
         lower = as.character(lower),
         upper = as.character(upper))
urmeat <- all %>% filter(exp == "French fries") %>%
  mutate(hr = as.character(hr),
         lower = as.character(lower),
         upper = as.character(upper))

df_tr <- data.frame(
  order = "a",
  target = "Substitute total potato with",
  exp = "",
  hr = "",
  lower = "",
  upper = "",
  hrlab = "Hazard Ratio (95% CI)",
  pval = "P-value"
)

tpotat <- df_tr %>%
  bind_rows(tpotat) %>%
  mutate(order = fct_rev(fct_relevel(order, "a")))

tr <- tpotat %>%
  ggplot(aes(x = as.numeric(hr), y = order, xmin=as.numeric(lower), xmax=as.numeric(upper))) +
  geom_point(shape = 22, size = 3, fill = "black") +
  geom_errorbarh(height=.2, linewidth =0.8) +
  geom_vline(xintercept = 1, linetype="dotted") +
  scale_x_continuous(breaks = seq(0.7, 1.3, 0.1), limits = c(0.7, 1.3)) +
  labs(x="Hazard Ratio (95% CI)") +
  theme_minimal() +
  theme(axis.line.y = element_blank(),
        axis.ticks.y= element_blank(),
        axis.text.y= element_blank(),
        axis.title.y= element_blank(),
        axis.line.x = element_line(size = 1),
        axis.text.x = element_text(size = 15),
        axis.title.x = element_text(size = 13))
tr

p1_tr <- tpotat %>%
  ggplot(aes(y = order)) +
  geom_text(
    size = 6,
    aes(x = 0, label = target),
    hjust = 0,
    fontface = ifelse(tpotat$target == "Substitute total potato with", "bold", "plain")
  )+
  theme_void() +
  coord_cartesian(xlim = c(0, 4))
p1_tr

p2_tr <- tpotat %>%
  ggplot(aes(y = order)) +
  geom_text(
    size = 6,
    aes(x = 2, label = hrlab),
    hjust = 0,
    fontface = ifelse(tpotat$hrlab == "Hazard Ratio (95% CI)", "bold", "plain")
  ) +
  theme_void() +
  coord_cartesian(xlim = c(0, 4))
p2_tr

p3_tr <- tpotat %>%
  ggplot() +
  geom_text(
    size = 6,
    aes(x = 0, y = order, label = pval),
    hjust = 0,
    fontface = ifelse(tpotat$pval == "P-value", "bold", "plain")
  ) +
  theme_void() 
p3_tr

layout <- c(
  area(t = 0, l = 0, b = 15, r = 10), # left plot, starts at the top of the page (0) and goes 30 units down and 3 units to the right
  area(t = 1, l = 11, b = 15, r = 25), # middle plot starts a little lower (t=1) because there's no title. starts 1 unit right of the left plot (l=4, whereas left plot is r=3), goes to the bottom of the page (30 units), and 6 units further over from the left plot (r=9 whereas left plot is r=3)
  area(t = 0, l = 20, b = 15, r = 33),
  area(t = 0, l = 31, b = 15, r = 35)# right most plot starts at top of page, begins where middle plot ends (l=9, and middle plot is r=9), goes to bottom of page (b=30), and extends two units wide (r=11)
)
a <- p1_tr + tr + p2_tr + p3_tr + 
  plot_layout(design = layout)
a

###
df_pr <- data.frame(
  order = "a",
  target = "Substitute Baked, boiled, mashed potato with",
  exp = "",
  hr = "",
  lower = "",
  upper = "",
  hrlab = "Hazard Ratio (95% CI)",
  pval = "P-value"
)

prmeat <- df_pr %>%
  bind_rows(prmeat) %>%
  mutate(order = fct_rev(fct_relevel(order, "a")))

pr <- prmeat %>%
  ggplot(aes(x = as.numeric(hr), y = order, xmin=as.numeric(lower), xmax=as.numeric(upper))) +
  geom_point(shape = 22, size = 3, fill = "black") +
  geom_errorbarh(height=.2, linewidth =0.8) +
  geom_vline(xintercept = 1, linetype="dotted") +
  scale_x_continuous(breaks = seq(0.7, 1.3, 0.1), limits = c(0.7, 1.3)) +
  labs(x="Hazard Ratio (95% CI)") +
  theme_minimal() +
  theme(axis.line.y = element_blank(),
        axis.ticks.y= element_blank(),
        axis.text.y= element_blank(),
        axis.title.y= element_blank(),
        axis.line.x = element_line(size = 1),
        axis.text.x = element_text(size = 15),
        axis.title.x = element_text(size = 13))
pr

p1_pr <- prmeat %>%
  ggplot(aes(y = order)) +
  geom_text(
    size = 6,
    aes(x = 0, label = target),
    hjust = 0,
    fontface = ifelse(prmeat$target == "Substitute Baked, boiled, mashed potato with", "bold", "plain")
  )+
  theme_void() +
  coord_cartesian(xlim = c(0, 4))
p1_pr

p2_pr <- prmeat %>%
  ggplot(aes(y = order)) +
  geom_text(
    size = 6,
    aes(x = 2, label = hrlab),
    hjust = 0,
    fontface = ifelse(prmeat$hrlab == "Hazard Ratio (95% CI)", "bold", "plain")
  ) +
  theme_void() +
  coord_cartesian(xlim = c(0, 4))
p2_pr

p3_pr <- prmeat %>%
  ggplot() +
  geom_text(
    size = 6,
    aes(x = 0, y = order, label = pval),
    hjust = 0,
    fontface = ifelse(prmeat$pval == "P-value", "bold", "plain")
  ) +
  theme_void() 
p3_pr

layout <- c(
  area(t = 0, l = 0, b = 15, r = 10), # left plot, starts at the top of the page (0) and goes 30 units down and 3 units to the right
  area(t = 1, l = 11, b = 15, r = 25), # middle plot starts a little lower (t=1) because there's no title. starts 1 unit right of the left plot (l=4, whereas left plot is r=3), goes to the bottom of the page (30 units), and 6 units further over from the left plot (r=9 whereas left plot is r=3)
  area(t = 0, l = 20, b = 15, r = 33),
  area(t = 0, l = 31, b = 15, r = 35)# right most plot starts at top of page, begins where middle plot ends (l=9, and middle plot is r=9), goes to bottom of page (b=30), and extends two units wide (r=11)
)
b <- p1_pr + pr + p2_pr + p3_pr + 
  plot_layout(design = layout)
b


###
df_ur <- data.frame(
  order = "a",
  target = "Substitute French fries with",
  exp = "",
  hr = "",
  lower = "",
  upper = "",
  hrlab = "Hazard Ratio (95% CI)",
  pval = "P-value"
)

urmeat <- df_ur %>%
  bind_rows(urmeat) %>%
  mutate(order = fct_rev(fct_relevel(order, "a")))

ur <- urmeat %>%
  ggplot(aes(x = as.numeric(hr), y = order, xmin=as.numeric(lower), xmax=as.numeric(upper))) +
  geom_point(shape = 22, size = 3, fill = "black") +
  geom_errorbarh(height=.2, linewidth =0.8) +
  geom_vline(xintercept = 1, linetype="dotted") +
  scale_x_continuous(breaks = seq(0.7, 1.3, 0.1), limits = c(0.7, 1.3)) +
  labs(x="Hazard Ratio (95% CI)") +
  theme_minimal() +
  theme(axis.line.y = element_blank(),
        axis.ticks.y= element_blank(),
        axis.text.y= element_blank(),
        axis.title.y= element_blank(),
        axis.line.x = element_line(size = 1),
        axis.text.x = element_text(size = 15),
        axis.title.x = element_text(size = 13))
ur

p1_ur <- urmeat %>%
  ggplot(aes(y = order)) +
  geom_text(
    size = 6,
    aes(x = 0, label = target),
    hjust = 0,
    fontface = ifelse(urmeat$target == "Substitute French fries with", "bold", "plain")
  )+
  theme_void() +
  coord_cartesian(xlim = c(0, 4))
p1_ur

p2_ur <- urmeat %>%
  ggplot(aes(y = order)) +
  geom_text(
    size = 6,
    aes(x = 2, label = hrlab),
    hjust = 0,
    fontface = ifelse(urmeat$hrlab == "Hazard Ratio (95% CI)", "bold", "plain")
  ) +
  theme_void() +
  coord_cartesian(xlim = c(0, 4))
p2_ur

p3_ur <- urmeat %>%
  ggplot() +
  geom_text(
    size = 6,
    aes(x = 0, y = order, label = pval),
    hjust = 0,
    fontface = ifelse(urmeat$pval == "P-value", "bold", "plain")
  ) +
  theme_void() 
p3_ur

layout <- c(
  area(t = 0, l = 0, b = 15, r = 10), # left plot, starts at the top of the page (0) and goes 30 units down and 3 units to the right
  area(t = 1, l = 11, b = 15, r = 25), # middle plot starts a little lower (t=1) because there's no title. starts 1 unit right of the left plot (l=4, whereas left plot is r=3), goes to the bottom of the page (30 units), and 6 units further over from the left plot (r=9 whereas left plot is r=3)
  area(t = 0, l = 20, b = 15, r = 33),
  area(t = 0, l = 31, b = 15, r = 35)# right most plot starts at top of page, begins where middle plot ends (l=9, and middle plot is r=9), goes to bottom of page (b=30), and extends two units wide (r=11)
)
c <- p1_ur + ur + p2_ur + p3_ur + 
  plot_layout(design = layout)
c
