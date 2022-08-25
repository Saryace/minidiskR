# breakpoint based on Muggeo 2008 Segmented: An R Package to Fit R --------

change_slope <-
  data_example %>%
  mutate(
    sqrt_time = sqrt(time),
    volume_infiltrated = case_when(row_number() == 1 ~ 0,
                                   TRUE ~ abs(volume - first(volume))),
    infiltration = volume_infiltrated / (pi * 2.25 ^ 2)
  ) %>% 
  group_by(soilID) %>%
  nest() %>% 
  left_join(., soil_data_example) %>% 
  left_join(., vg_parameters_bytexture_radius2.25) %>% 
  separate(soilID, c("soil","suction","solution"), sep = "_") %>% 
  mutate(
    fit_lm = map(data, ~ lm(infiltration ~ sqrt_time, data = .x))) %>% 
  mutate(
    segmented = map2(data, fit_lm, ~ segmented(.y,  ~ sqrt_time, npsi = 1)),
    breakpoint = map_dbl(segmented, ~.$psi[2]),
    lines =  map(segmented, broken.line),
    estimated_break = map_df(lines,~.$fit)
  ) %>% 
  unnest(estimated_break) %>% 
  pivot_longer(
    cols = starts_with("sqrt_time"),
    names_to = "break_fit",
    names_prefix = "sqrt_time",
    values_to = "break_fit_value",
    values_drop_na = TRUE
  ) 

# plot con breakpoint -----------------------------------------------------

change_slope_plot <-
data_nested_bysoilID_plot %>% 
  left_join(change_slope) %>% 
  mutate(data = map(data, 
                    ~ mutate(.x,
                     break_fit_value = break_fit_value))) %>% 
  dplyr::select(soilID,soil,suction, solution, data, texture,breakpoint) %>% 
  distinct() %>% 
  mutate(plot = map2(
    data, soilID, 
    ~ ggplot(data = .x, aes(x = sqrt_time, y = infiltration)) +
      ggtitle(glue("Soil ID:{soilID}
                   Soil : {soil}
                   Suction : {suction}
                   Solution : {solution}")) +
      geom_vline(xintercept = breakpoint) +
      geom_line(data = .x, aes(x = sqrt_time, y = break_fit_value), linetype = "dashed") +
      geom_point()))

change_slope_plot$plot[4] # example

