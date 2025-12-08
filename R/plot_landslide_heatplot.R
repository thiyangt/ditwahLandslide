#'Heatmap of Transitions Between Landslide Warning Levels
#'
#'Temporal progression of landslide warning state
#'@param district District name
#'@param province Province name
#'@param interactivity if TRUE interactive plot will be generated, if FALSE static plot will be generated
#'@param data name of the dataset, by default ditwah_landslides_warnings
#'@param ang angle of the x-axis lables
#'@return Heatmap plot of landslide warnings
#'@importFrom dplyr mutate
#'@importFrom stringr str_squish
#'@importFrom lubridate ymd_hm
#'@importFrom ggplot2 ggplot
#'@importFrom plotly ggplotly
#'@importFrom dplyr filter
#'@importFrom dplyr if_else
#'@importFrom ggplot2 annotate
#'@importFrom dplyr case_when
#'@importFrom ggplot2 theme_void
#'@importFrom ggplot2 geom_rect
#'@importFrom ggplot2 scale_y_continuous
#'@importFrom ggplot2 scale_fill_manual
#'@importFrom ggplot2 element_text
#'@importFrom ggplot2 element_blank
#'@importFrom ggplot2 aes
#'@importFrom ggplot2 layer
#'@importFrom ggplot2 labs
#'@importFrom ggplot2 scale_x_datetime
#'@importFrom ggplot2 theme
#'@author Thiyanga S. Talagala, Geethma R. Jayasinghe, Y. M. Amali P. Rajapaksha
#'@export
viz_landslide_warnings_from_to <- function(district,
                                   province,
                                   interactivity= TRUE,
                                   data = ditwah_landslides_warnings,ang=90){

  province_districts = list(
    "Central" = c("Kandy", "Matale", "Nuwara Eliya"),
    "Western" = c("Colombo", "Gampaha", "Kalutara"),
    "Southern" = c("Galle", "Matara", "Hambantota"),
    "Northern" = c("Jaffna", "Kilinochchi", "Mannar", "Vavuniya", "Mullaitivu"),
    "Eastern" = c("Batticaloa", "Trincomalee", "Ampara"),
    "North Western" = c("Kurunegala", "Puttalam"),
    "North Central" = c("Anuradhapura", "Polonnaruwa"),
    "Uva" = c("Badulla", "Monaragala"),
    "Sabaragamuwa" = c("Ratnapura", "Kegalle")
  )

  # Data preprocessing
  data <- data |>
    mutate(
      Location = str_squish(Location),
      District = str_squish(District),
      Valid_From_Time = if_else(is.na(Valid_From_Time) | Valid_From_Time == "", "00:00", Valid_From_Time),
      Valid_To_Time   = if_else(is.na(Valid_To_Time) | Valid_To_Time == "", "23:59", Valid_To_Time),
      valid_from_dt = ymd_hm(paste(Valid_From_Date, Valid_From_Time)),
      valid_to_dt   = ymd_hm(paste(Valid_To_Date, Valid_To_Time)),
      level = case_when(
        Level == 1 ~ "Low",
        Level == 2 ~ "Medium",
        Level == 3 ~ "High",
        TRUE ~ "Unknown"
      ),
      level = factor(level, levels = c("Low", "Medium", "High", "Unknown")),
      province = case_when(
        District %in% province_districts[["Central"]] ~ "Central",
        District %in% province_districts[["Western"]] ~ "Western",
        District %in% province_districts[["Southern"]] ~ "Southern",
        District %in% province_districts[["Northern"]] ~ "Northern",
        District %in% province_districts[["Eastern"]] ~ "Eastern",
        District %in% province_districts[["North Western"]] ~ "North Western",
        District %in% province_districts[["North Central"]] ~ "North Central",
        District %in% province_districts[["Uva"]] ~ "Uva",
        District %in% province_districts[["Sabaragamuwa"]] ~ "Sabaragamuwa",
        TRUE ~ "Unknown"
      )
    )


  # Filter by province/district

  if (!is.null(province) && province != "All") {
    data <- data |> filter(province == province)
  }

  if (!is.null(district) && district != "All") {
    data <- data |> filter(District == district)
  }


  # Handle no data
  if (nrow(data) == 0) {
    return(
      ggplot() +
        annotate("text", x = 1, y = 1, label = "No data available", size = 6) +
        theme_void()
    )
  }


  # Locations for y-axis

  locations_to_plot <- unique(data$Location)

  # Generate heatmap

  staticplot <- ggplot(data) +
    geom_rect(aes(
      xmin = valid_from_dt,
      xmax = valid_to_dt,
      ymin = as.numeric(factor(Location, levels = locations_to_plot)) - 0.4,
      ymax = as.numeric(factor(Location, levels = locations_to_plot)) + 0.4,
      fill = level
    ),  alpha=0.5) +
    scale_y_continuous(
      breaks = 1:length(locations_to_plot),
      labels = locations_to_plot
    ) +
    scale_fill_manual(
      values = c("Low" = "#FFFF00", "Medium" = "#D79334", "High" = "red", "Unknown" = "grey90"),
      na.value = "grey90"
    ) +
    labs(x = "Timeline of Warning Level(Date and Time)", y = "Location", fill = "Warning Level") +
    scale_x_datetime(
      date_labels = "%b %d %H:%M",
      date_breaks = "8 hours"
    ) +
    theme(
      axis.text.x = element_text(angle = ang, hjust = 1),
      axis.ticks = element_blank(),
     # panel.grid = element_blank(),
      panel.border = element_blank(),
     legend.position="bottom"
    )

  if(interactivity==TRUE){
    staticplot
  } else {
    plotly::ggplotly(staticplot)
  }
}
#'@example
#'viz_landslide_warnings_from_to(province = "Central", district = "Kandy", interactivity=FALSE)
