
# plotting by SoilD -------------------------------------------------------

data_nested_bysoilID_plot <-
  data_example %>%
  mutate(
    sqrt_time = sqrt(time),
    volume_infiltrated = case_when(row_number() == 1 ~ 0,
                                   TRUE ~ abs(volume - first(volume))),
    infiltration = volume_infiltrated / (pi * 2.25 ^ 2)
  ) %>% 
  group_by(soilID) %>%
  nest() %>% 
  separate(soilID, c("soil","suction","solution"), sep = "_", remove = FALSE) 

plot_bysoilID <-
data_nested_bysoilID_plot %>% 
  mutate(plot = map2(
    data, soilID, 
    ~ ggplot(data = .x, aes(x = sqrt_time, y = infiltration)) +
      ggtitle(glue("Soil ID:{soilID}
                   Soil : {soil}
                   Suction : {suction}
                   Solution : {solution}")) +
      stat_smooth(method='lm', formula = y~poly(x,2)) +
      geom_point()))

patchwork::wrap_plots(plot_bysoilID$plot, ncol = 2)  

ggsave("figures/plot_bysoilID_plot.png")
  
# plotting by soil --------------------------------------------------------

data_nested_bysoil_plot <-
  data_example %>%
  mutate(
    sqrt_time = sqrt(time),
    volume_infiltrated = case_when(row_number() == 1 ~ 0,
                                   TRUE ~ abs(volume - first(volume))),
    infiltration = volume_infiltrated / (pi * 2.25 ^ 2)
  ) %>% 
  separate(soilID, c("soil","suction","solution"), sep = "_", remove = FALSE) %>% 
  group_by(soil) %>%
  nest() 

plot_bysoil <-
  data_nested_bysoil_plot %>%
  mutate(plot = map2(
    data,
    soil,
    ~ ggplot(
      data = .x,
      aes(
        x = sqrt_time,
        y = infiltration,
        color = suction,
        shape = solution,
        group = interaction(suction, solution)
      )
    ) +
      geom_point() +
      stat_smooth(method = 'lm', formula = y ~ poly(x, 2)) +
      ggtitle(glue(
        "Soil : {soil}"
      ))
  ))

patchwork::wrap_plots(plot_bysoil$plot, ncol = 1)  

ggsave("figures/plot_bysoil_plot.png")

# plotting by suction -----------------------------------------------------

data_nested_bysuction_plot <-
  data_example %>%
  mutate(
    sqrt_time = sqrt(time),
    volume_infiltrated = case_when(row_number() == 1 ~ 0,
                                   TRUE ~ abs(volume - first(volume))),
    infiltration = volume_infiltrated / (pi * 2.25 ^ 2)
  ) %>% 
  separate(soilID, c("soil","suction","solution"), sep = "_", remove = FALSE) %>% 
  group_by(suction) %>%
  nest() 


plot_bysuction <-
  data_nested_bysuction_plot %>%
  mutate(plot = map2(
    data,
    suction,
    ~ ggplot(
      data = .x,
      aes(
        x = sqrt_time,
        y = infiltration,
        color = soil,
        shape = solution,
        group = interaction(soil, solution)
      )
    ) +
      geom_point() +
      stat_smooth(method = 'lm', formula = y ~ poly(x, 2)) +
      ggtitle(glue(
        "Suction : {suction}"
      ))
  ))

patchwork::wrap_plots(plot_bysuction$plot, ncol = 1)  

ggsave("figures/plot_bysuction_plot.png")


# plotting by solution ----------------------------------------------------


data_nested_bysolution_plot <-
  data_example %>%
  mutate(
    sqrt_time = sqrt(time),
    volume_infiltrated = case_when(row_number() == 1 ~ 0,
                                   TRUE ~ abs(volume - first(volume))),
    infiltration = volume_infiltrated / (pi * 2.25 ^ 2)
  ) %>% 
  separate(soilID, c("soil","suction","solution"), sep = "_", remove = FALSE) %>% 
  group_by(solution) %>%
  nest() 


plot_bysolution <-
  data_nested_bysolution_plot %>%
  mutate(plot = map2(
    data,
    solution,
    ~ ggplot(
      data = .x,
      aes(
        x = sqrt_time,
        y = infiltration,
        color = soil,
        shape = suction,
        group = interaction(soil, suction)
      )
    ) +
      geom_point() +
      stat_smooth(method = 'lm', formula = y ~ poly(x, 2)) +
      ggtitle(glue(
        "Solution : {solution}"
      ))
  ))

patchwork::wrap_plots(plot_bysolution$plot, ncol = 1)  

ggsave("figures/plot_bysolution_plot.png")
  
  