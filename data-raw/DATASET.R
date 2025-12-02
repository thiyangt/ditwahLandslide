## code to prepare `DATASET` dataset goes here

library(readxl)
library(purrr)
library(dplyr)
library(here)
library(lubridate)

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


glimpse(f1)
glimpse(f2)
glimpse(f3)
glimpse(f4)
glimpse(f5)
glimpse(f6)
glimpse(f7)
glimpse(f8)
glimpse(f9)
glimpse(f10)
glimpse(f11)
glimpse(f12)
glimpse(f13)
glimpse(f14)
glimpse(f15)
glimpse(f16)
glimpse(f17)


ditwah_landslides_warnings <- bind_rows(f1, f2)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f3)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f4)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f5)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f6)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f7)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f8)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f9)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f10)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f11)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f12)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f13)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f14)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f15)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f16)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f17)

ditwah_landslides_warnings$Report_Time <- format(ditwah_landslides_warnings$Report_Time, "%H:%M")
ditwah_landslides_warnings$Valid_From_Time <- format(ditwah_landslides_warnings$Valid_From_Time, "%H:%M")
ditwah_landslides_warnings$Valid_To_Time<- format(ditwah_landslides_warnings$Valid_To_Time, "%H:%M")


usethis::use_data(ditwah_landslides_warnings, overwrite = TRUE)


