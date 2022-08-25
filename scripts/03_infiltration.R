
# sqrt and infiltration per soil ------------------------------------------
data_nested_bysoilID <-
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
    fit = map(data, ~ lm(infiltration ~ poly(sqrt_time, 2, raw = TRUE), data = .x)),
    tidied = map(fit, tidy)
  ) %>% 
  unnest(tidied) 

# parameters --------------------------------------------------------------
parameters_bysoilID <-
data_nested_bysoilID %>%
  pivot_longer(`0.5cm`:`7cm`,
               names_to = "suction_table",
               values_to = "values_suction") %>%
  filter(suction_table == suction) %>%
  filter(term == "poly(sqrt_time, 2, raw = TRUE)2") %>% 
  mutate(
    suction_num = -as.numeric(parse_number(suction)),
    parameter_A = (11.65*(`n/ho`^(0.1)-1)*exp(ifelse(`n/ho`<1.9,7.5,2.92)*(`n/ho`-1.9)*alpha*suction_num))/((alpha*2.25)^(0.91)),
    parameter_C = estimate,
    parameter_K = parameter_C / parameter_A
  ) %>% 
  dplyr::select(soil,suction,solution,texture,parameter_A,parameter_C,parameter_K)

# slope analysis ----------------------------------------------------------
parameters_bysoilID %>% 
  pivot_longer(parameter_A:parameter_K, names_to = "parameter", values_to = "parameter_value") %>% 
  pivot_wider(names_from = solution, values_from = parameter_value) %>% 
  filter(parameter == "parameter_C") %>% 
  group_by(soil,suction) %>% 
  summarise(R = 1.95 * (alcohol / water))
  


