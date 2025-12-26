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
length(files) # 32 by 18 Dec 2025 #40 by 26 Dec 2025
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
f18 <- read_excel(files[18])
f19 <- read_excel(files[19])
f20 <- read_excel(files[20])
f21 <- read_excel(files[21])
f22 <- read_excel(files[22])
f23 <- read_excel(files[23])
f24 <- read_excel(files[24])
f25 <- read_excel(files[25])
f26 <- read_excel(files[26])
f27 <- read_excel(files[27])
f28 <- read_excel(files[28])
f29 <- read_excel(files[29])
f30 <- read_excel(files[30])
f31 <- read_excel(files[31])
f32 <- read_excel(files[32])
f33 <- read_excel(files[33])
f34 <- read_excel(files[34])
f35 <- read_excel(files[35])
f36 <- read_excel(files[36])
f37 <- read_excel(files[37])
f38 <- read_excel(files[38])
f39 <- read_excel(files[39])
f40 <- read_excel(files[40])

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
glimpse(f18)
glimpse(f19)
glimpse(f20)
glimpse(f21)
glimpse(f22)
glimpse(f23)
glimpse(f24)
glimpse(f25)
glimpse(f26)
glimpse(f27)
glimpse(f28)
glimpse(f29)
glimpse(f30)
glimpse(f31)
glimpse(f32)
glimpse(f33)
glimpse(f34)
glimpse(f35)
glimpse(f36)
glimpse(f37)
glimpse(f38)
glimpse(f39)
glimpse(f40)

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
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f18)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f19)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f20)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f21)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f22)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f23)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f24)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f25)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f26)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f27)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f28)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f29)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f30)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f31)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f32)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f33)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f34)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f35)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f36)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f37)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f38)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f39)
ditwah_landslides_warnings <- bind_rows(ditwah_landslides_warnings, f40)








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


#usethis::use_data(ditwah_landslides_warnings, overwrite = TRUE)

## Fix location names
sort(unique(ditwah_landslides_warnings$Location))

# "Aranayaka"      "Aranayake"
# "Bulathsinghala"      "Bulathsinhala"
# "Dehiowita"           "Dehowita"
# "Hali Ela"            "Hali_Ela"
# "Kirinda Puhulwella"  "Kirinda_Puhulwella"
# "Kothmale East"      "Kotmale East"
# "Kothmale West"    "Kotmale West"
# "Nildandahinna"  "Nidandahinna"

library(dplyr)

ditwah_landslides_warnings <- ditwah_landslides_warnings |>
  mutate(
    Location = recode(
      Location,
      "Aranayake"            = "Aranayaka",
      "Bulathsinhala"        = "Bulathsinghala",
      "Dehowita"             = "Dehiowita",
      "Hali_Ela"             = "Hali Ela",
      "Kirinda_Puhulwella"   = "Kirinda Puhulwella",
      "Kotmale East"         = "Kothmale East",
      "Kotmale West"         = "Kothmale West",
      "Nidandahinna"         = "Nildandahinna"
    )
  )
usethis::use_data(ditwah_landslides_warnings, overwrite = TRUE)
