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


#usethis::use_data(ditwah_landslides_warnings, overwrite = TRUE)


library(dplyr)
library(stringr)

# Create a lookup table of correct district names
district_lookup <- c(
  "colombo"      = "Colombo",
  "gampaha"      = "Gampaha",
  "kalutara"     = "Kalutara",
  "kaluthara"    = "Kalutara",

  "kandy"        = "Kandy",
  "matale"       = "Matale",
  "nuwara eliya" = "Nuwara Eliya",

  "galle"        = "Galle",
  "matara"       = "Matara",
  "hambantota"   = "Hambantota",

  "kurunegala"   = "Kurunegala",

  "kegalle"      = "Kegalle",
  "ratnapura"    = "Ratnapura",
  "rathnapura"   = "Ratnapura",

  "badulla"      = "Badulla",

  "moneragala"   = "Monaragala",
  "monaragala"   = "Monaragala",
  "monaragla"    = "Monaragala"
)

# Function to standardize district names
clean_district <- function(x) {
  x_clean <- tolower(str_trim(x))
  out <- district_lookup[x_clean]
  ifelse(is.na(out), str_to_title(x_clean), out)
}

# Example usage:
districts <- c("colombo", "Colombo", "Kaluthara", "Monaragla", "kegalle", "KANDY")

ditwah_landslides_warnings$District <- clean_district(ditwah_landslides_warnings$District)


province_lookup <- c(
  # Western
  "colombo"   = "Western",
  "gampaha"   = "Western",
  "kalutara"  = "Western",
  "kaluthara" = "Western",

  # Central
  "kandy"        = "Central",
  "matale"       = "Central",
  "nuwara eliya" = "Central",

  # Southern
  "galle"      = "Southern",
  "matara"     = "Southern",
  "hambantota" = "Southern",

  # Sabaragamuwa
  "kegalle"     = "Sabaragamuwa",
  "kegalle"     = "Sabaragamuwa",
  "ratnapura"   = "Sabaragamuwa",
  "rathnapura"  = "Sabaragamuwa",

  # Uva
  "badulla"      = "Uva",
  "moneragala"   = "Uva",
  "monaragala"   = "Uva",
  "monaragla"    = "Uva",

  # North Western
  "kurunegala"   = "North Western"
)
add_province <- function(x) {
  x_clean <- tolower(trimws(x))
  x_clean <- str_replace_all(x_clean, "\\s+", " ")
  # If district not in lookup, return Title Case version
  out <- province_lookup[x_clean]
  ifelse(is.na(out), NA, out)
}

ditwah_landslides_warnings <- ditwah_landslides_warnings |>
  mutate(
    Province = add_province(District)
  )


usethis::use_data(ditwah_landslides_warnings, overwrite = TRUE)

