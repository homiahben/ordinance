
# Ghana Colonial Green Spaces Mapping Starter
# Install once if needed:
# install.packages(c("sf", "leaflet", "tidyverse", "ggplot2", "viridis"))

library(sf)
library(leaflet)
library(tidyverse)
library(ggplot2)

green_spaces <- read_csv("green_spaces.csv", show_col_types = FALSE)
events <- read_csv("events.csv", show_col_types = FALSE)
purpose_categories <- read_csv("purpose_categories.csv", show_col_types = FALSE)

# Keep only records with coordinates
green_spaces_xy <- green_spaces %>%
  filter(!is.na(latitude), latitude != "", !is.na(longitude), longitude != "") %>%
  mutate(
    latitude = as.numeric(latitude),
    longitude = as.numeric(longitude)
  )

green_sf <- st_as_sf(
  green_spaces_xy,
  coords = c("longitude", "latitude"),
  crs = 4326,
  remove = FALSE
)

# Join color labels
green_sf <- green_sf %>%
  left_join(purpose_categories, by = c("purpose_primary" = "purpose_code"), suffix = c("", "_category"))

# Leaflet map
pal <- colorFactor(
  palette = unique(green_sf$color_hex),
  domain = green_sf$purpose_primary
)

leaflet(green_sf) %>%
  addProviderTiles("OpenStreetMap") %>%
  addCircleMarkers(
    radius = 7,
    color = ~color_hex,
    fillColor = ~color_hex,
    fillOpacity = 0.85,
    weight = 2,
    popup = ~paste0(
      "<b>", site_name, "</b><br>",
      "Type: ", site_type, "<br>",
      "Creation year: ", creation_year, "<br>",
      "Purpose: ", purpose_primary, "<br>",
      "Legal basis: ", legal_basis, "<br>",
      "Verification: ", verification_status, "<br>",
      "Evidence: ", evidence_note
    )
  ) %>%
  addLegend(
    position = "bottomright",
    colors = purpose_categories$color_hex,
    labels = purpose_categories$label,
    title = "Purpose / ideology"
  )

# ggplot2 static map of coordinate-verified points
ggplot(green_sf) +
  geom_sf(aes(color = purpose_primary), size = 3) +
  theme_minimal() +
  labs(
    title = "Colonial Ghana Green Spaces Dataset, 1876-1957",
    subtitle = "Only records with available coordinates are plotted. Replace points with WDPA or archival polygons where possible.",
    color = "Purpose"
  )

# Event timeline
events %>%
  mutate(year_num = suppressWarnings(as.numeric(str_extract(year, "\\d{4}")))) %>%
  filter(!is.na(year_num)) %>%
  ggplot(aes(x = year_num, y = reorder(event_name, year_num), color = purpose_code)) +
  geom_point(size = 3) +
  geom_segment(aes(xend = year_num, yend = event_name), x = 1876, linewidth = 0.3) +
  theme_minimal() +
  labs(
    title = "Legal, Protest, and Administrative Events Underpinning Green Spaces",
    x = "Year",
    y = NULL,
    color = "Purpose code"
  )
