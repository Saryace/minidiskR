
# Library for path  -------------------------------------------------------

library(fs)

list_scripts <- dir_ls("scripts")


# running all scripts -----------------------------------------------------

walk(list_scripts, source)

