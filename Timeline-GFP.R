
library(ggplot2)
library(ggrepel)

#Read the data
df_timeline <- read.delim("Data-GFP-timeline.txt", sep = '\t' )

#Create a datafram with all years between first and last year of the timeline data
df_yrs <- data.frame(Year=min(df_timeline$Year):max(df_timeline$Year))

#Defining the plot and the theme

ggplot(df_timeline, aes(x=1, y=Year, color=as.factor(Year))) +
  #Create the vertical line
  geom_vline(xintercept = 1.0, size=0.1) +
  #Define the labels
  geom_label_repel(aes(label=Event),
                   fill         = "white",
                   alpha        = 1,
                   nudge_x      = 0.05,
                   direction    = "y",
                   hjust        = 0,
                   segment.size = 0.4,
                   size         = 3,
                   fontface     = "bold",
                   label.r      = 0.1
  ) +
  #Large, open circles are plotted for each event
  geom_point(shape=21, size=3, fill="white") +
  #Small dots are defined for each year
  geom_point(data = df_yrs, aes(x=1), size=0.5, color="grey20") +
  #Set limits for y-axis and define the ticks+labels
  scale_y_continuous(limits = c(1962,2025), breaks = c(seq(1965, 2024, by=5))) +
  #Set limits of the x-axis (which is invisible). Adjust to optimize the layout
  scale_x_continuous(expand = c(0.01, 0), limits = c(1.0,1.5)) +
  theme_minimal(base_size = 14)+
  theme(legend.position = "none",
        panel.grid = element_blank(),
        axis.title = element_blank(), 
        axis.text.x = element_blank(),
        axis.ticks.y.left = element_line(color="grey", linetype = 1)
  ) +
  #Set the title of the figure
  labs(title = "60 years of GFP discovery and engineering") +
  NULL

ggsave("Timeline-GFP.png", device = "png", width = 2000, height = 2400, units="px", dpi=300, bg="white")
