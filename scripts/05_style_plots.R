
# Styling plots -----------------------------------------------------------

patchwork::wrap_plots(plot_bysoilID$plot, ncol = 2)  &
  theme_classic() &
  labs(x = "√Time",
       y = "Cumulative infiltration (cm)") 

  