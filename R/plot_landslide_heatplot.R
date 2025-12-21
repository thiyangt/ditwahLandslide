#'Heatmap of Transitions Between Landslide Warning Levels
#'
#'Temporal progression of landslide warning state
#'@param data name of the dataset, by default ditwah_landslides_warnings
#'@param district District name or All, if no district put NULL
#'@param province Province name or All, if no province put NULL
#'@param interactivity if TRUE interactive plot will be generated, if FALSE static plot will be generated
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
viz_landslide_warnings_from_to <- function(data, district = NULL,
                                           province = NULL,
                                           interactivity = TRUE,
                                           ang = 90) {

  province_districts <- list(
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

  # Flatten all districts to check validity
  all_districts <- unlist(province_districts)

  # Validate user inputs
  if (!is.null(province) && province != "All" && !province %in% names(province_districts)) {
    stop("Invalid province name provided.")
  }
  if (!is.null(district) && district != "All" && !district %in% all_districts) {
    stop("Invalid district name provided.")
  }

  # Data preprocessing
  data <- data |>
    dplyr::mutate(
      Location = stringr::str_squish(Location),
      District = stringr::str_squish(District),
      Valid_From_Time = if_else(is.na(Valid_From_Time) | Valid_From_Time == "", "00:00", Valid_From_Time),
      Valid_To_Time   = if_else(is.na(Valid_To_Time) | Valid_To_Time == "", "23:59", Valid_To_Time),
      valid_from_dt = lubridate::ymd_hm(paste(Valid_From_Date, Valid_From_Time)),
      valid_to_dt   = lubridate::ymd_hm(paste(Valid_To_Date, Valid_To_Time)),
      level = case_when(
        Level == 1 ~ "Low",
        Level == 2 ~ "Medium",
        Level == 3 ~ "High",
        TRUE ~ "Unknown"
      ),
      level = factor(level, levels = c("Low", "Medium", "High", "Unknown"))
    )

  # Filter based on province and district
  filtered_data <- data

  if (!is.null(province) && province != "All") {
    districts_in_prov <- province_districts[[province]]
    if (!is.null(district) && district != "All") {
      # Both province and district specified: match both
      filtered_data <- filtered_data |>
        dplyr::filter(District %in% districts_in_prov & District == district)
    } else {
      # Only province specified: include all districts in that province
      filtered_data <- filtered_data |>
        dplyr::filter(District %in% districts_in_prov)
    }
  } else if (!is.null(district) && district != "All") {
    # Only district specified: include only that district
    filtered_data <- filtered_data |>
      dplyr::filter(District == district)
  }

  # Handle no data
  if (nrow(filtered_data) == 0) {
    return(
      ggplot2::ggplot() +
        ggplot2::annotate("text", x = 1, y = 1, label = "No data available", size = 6) +
        ggplot2::theme_void()
    )
  }

  # Locations for y-axis
  locations_to_plot <- unique(filtered_data$Location)

  # Generate heatmap
  staticplot <- ggplot2::ggplot(filtered_data) +
    ggplot2::geom_rect(aes(
      xmin = valid_from_dt,
      xmax = valid_to_dt,
      ymin = as.numeric(factor(Location, levels = locations_to_plot)) - 0.4,
      ymax = as.numeric(factor(Location, levels = locations_to_plot)) + 0.4,
      fill = level
    ), alpha = 0.5) +
    ggplot2::scale_y_continuous(
      breaks = 1:length(locations_to_plot),
      labels = locations_to_plot
    ) +
    ggplot2::scale_fill_manual(
      values = c("Low" = "#FFFF00", "Medium" = "#D79334", "High" = "red", "Unknown" = "grey90"),
      na.value = "grey90"
    ) +
    ggplot2::labs(x = "Timeline of Warning Level (Date and Time)", y = "Location", fill = "Warning Level") +
    ggplot2::scale_x_datetime(
      date_labels = "%b %d %H:%M",
      date_breaks = "8 hours"
    ) +
    ggplot2::theme(
      axis.text.x = element_text(angle = ang, hjust = 1),
      legend.position = "bottom"
    )

  if (interactivity) {
    plotly::ggplotly(staticplot)
  } else {
    staticplot
  }
}
#'@example
#'viz_landslide_warnings_from_to(data = ditwah_landslides_warnings,
#'province = "", district = "Badulla", interactivity=FALSE)
