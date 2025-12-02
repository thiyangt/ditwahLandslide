library(hexSticker)
library(here)
sticker(
  here("data-raw","hex", "lsblack.png"),
  package = "ditwahLandslide",
  p_color = "#d94801",
  p_size = 15,
  s_x = 1,          # center horizontally (1 is right, 0.5 is middle; depends on coordinate system)
  s_y = 0.85,       # slightly above center vertically
  s_width = 0.5,    # increase width
  s_height = 0.5,   # optional, set height explicitly
  h_fill = "#0d0887",
  h_color = "#d94801",
  filename = "data-raw/hex/hex.png"
)
