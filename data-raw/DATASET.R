## code to prepare `DATASET` dataset goes here

library(readxl)
library(purrr)
library(dplyr)
library(here)

path <- here("data-raw", "dataxl")

# List all Excel files
files <- list.files(path, pattern = "\\.xlsx?$", full.names = TRUE)
files
length(files)
f1 <- read_excel(files[1])
f2 <- read_excel(files[2])
f3 <- read_excel(files[3])
f4 <- read_excel(files[4])
f5 <- read_excel(files[5])
f6 <- read_excel(files[6])
f7 <- read_excel(files[7])
f8 <- read_excel(files[8])
f9 <- read_excel(files[9])
f10 <- read_excel(files[10])
f11 <- read_excel(files[11])
f12 <- read_excel(files[12])
f13 <- read_excel(files[13])
f14 <- read_excel(files[14])
f15 <- read_excel(files[15])
f16 <- read_excel(files[16])
f17 <- read_excel(files[17])

library(lubridate)
f1$Report_Date <- dmy(f1$Report_Date)

ditwah_landslides_warnings <- bind_rows(f1, f2)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f3)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f4)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f5)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f6)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f7)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f8)



usethis::use_data(DATASET, overwrite = TRUE)
