suppressPackageStartupMessages({
  library(shiny)
  library(shinydashboard)
  library(tidyverse)
  library(lubridate)
  library(ditwahLandslide)
})

# -------------------------------
# Province → District list
# -------------------------------
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

# -------------------------------
# Prepare data
# -------------------------------
ditwah_landslides_warnings2 <- ditwah_landslides_warnings %>%
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

# -------------------------------
# UI
# -------------------------------
ui <- dashboardPage(
  dashboardHeader(title = "DITWAH Landslide Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("chart-bar")),
      selectInput(
        "province",
        "Select Province:",
        choices = names(province_districts),
        selected = names(province_districts)[1]  # default to first province
      ),

      # District choices will be updated dynamically
      selectInput(
        "district",
        "Select District:",
        choices = province_districts[[names(province_districts)[1]]],  # default to first province's districts
        selected = province_districts[[names(province_districts)[1]]][1]
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              box(title = "Landslide Warnings Heatmap", status = "primary", solidHeader = TRUE,
                  width = 12, plotOutput("heatmap", height = "600px")
              )
      )
    )
  )
)

# -------------------------------
# SERVER
# -------------------------------
server <- function(input, output, session) {

  # Update district dropdown based on province
  observe({
    if (input$province == "All") {
      updateSelectInput(session, "district", choices = "All", selected = "All")
    } else {
      updateSelectInput(session, "district",
                        choices = c("All", province_districts[[input$province]]),
                        selected = "All")
    }
  })

  # Render heatmap
  output$heatmap <- renderPlot({

    filtered_data <- ditwah_landslides_warnings2

    # Filter by province
    if (!is.null(input$province) && input$province != "All") {
      filtered_data <- filtered_data %>% filter(province == input$province)
    }

    # Filter by district
    if (!is.null(input$district) && input$district != "All") {
      filtered_data <- filtered_data %>% filter(District == input$district)
    }

    if (nrow(filtered_data) == 0) {
      ggplot() + annotate("text", x = 1, y = 1, label = "No data available", size = 6) + theme_void()
    } else {
      # Locations relevant to filtered data
      locations_to_plot <- unique(filtered_data$Location)

      ggplot(filtered_data) +
        geom_rect(aes(
          xmin = valid_from_dt,
          xmax = valid_to_dt,
          ymin = as.numeric(factor(Location, levels = locations_to_plot)) - 0.4,
          ymax = as.numeric(factor(Location, levels = locations_to_plot)) + 0.4,
          fill = level
        ), alpha=0.5) +
        scale_y_continuous(
          breaks = 1:length(locations_to_plot),
          labels = locations_to_plot
        ) +
        scale_fill_manual(
          values = c("Low" = "#FFFF00", "Medium" = "#D79334", "High" = "red", "Unknown" = "grey90"),
          na.value = "grey90"
        ) +
        labs(x = "Datetime", y = "Location", fill = "Warning Level") +
        scale_x_datetime(date_labels = "%b %d %H:%M", date_breaks = "8 hours") +
        theme_minimal() +
        theme(
          axis.text.x = element_text(angle = 45, hjust = 1),
          axis.ticks = element_blank(),
          panel.grid = element_blank(),
          panel.border = element_blank()
        )
    }

  })

}

# -------------------------------
# Run App
# -------------------------------
shinyApp(ui, server)
