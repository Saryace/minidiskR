
# Library for path  -------------------------------------------------------

library(fs)
library(purrr)

list_scripts <- dir_ls("scripts")


# running all scripts -----------------------------------------------------

purrr::walk(list_scripts, source)


