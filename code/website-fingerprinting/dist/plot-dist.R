require(ggplot2)
library(scales)
library(grid)

args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]

cairo_pdf("dist-1kx100+100k.pdf", height=2.6, width=3)
data <- read.csv(input_file, header=TRUE)

df <- data.frame(x = data$offset,
                 y = data$wf,
                 Attack = "wf")

df <- rbind(df, data.frame(x = data$offset,
                           y = data$pchp,
                           Attack = "pc-hp"))

df <- rbind(df, data.frame(x = data$offset,
                           y = data$uchp,
                           Attack = "uc-hp"))

df <- rbind(df, data.frame(x = data$offset,
                           y = data$prhp,
                           Attack = "pr-hp"))

df <- rbind(df, data.frame(x = data$offset,
                           y = data$urhp,
                           Attack = "ur-hp"))

ggplot(df, aes(x, y, colour = Attack,
                     linetype = Attack,
                     shape = Attack)) +
    geom_point(size=2.5) +
    geom_line() +
    labs(x = "Alexa site rank (log)") +
    labs(y = "Precision") +
    theme_minimal() +
    theme(legend.key.width = unit(2, "line"),
          legend.justification = c(1, 0),
          legend.position = c(1.05, 0.05),
          legend.key.height = unit(0.8, "line"),
          legend.background = element_rect(colour = "gray", fill = "white", size = 0.3),
          legend.key = element_rect(colour = "transparent", fill = "transparent"),
          axis.text = element_text(colour = "gray50"),
          axis.ticks = element_line(colour = "gray90"),
          axis.ticks.x = element_line(size = 0.25),
          axis.ticks.y = element_line(size = 0.25)) +
    scale_color_brewer(palette = "Set1") +
    scale_x_continuous(trans = "log10",
                       breaks = trans_breaks("log10", function(x) 10^x),
                       labels = trans_format("log10", math_format(10^.x)))

dev.off()
