library(shiny)
library(bslib)
library(ggplot2)
library(dplyr)
library(genderforce)

country_choices <- sort(unique(genderforce::labor_force_marital$country))
age_choices <- unique(genderforce::labor_force_marital$age_group)
min_year <- min(genderforce::labor_force_marital$year, na.rm = TRUE)
max_year <- max(genderforce::labor_force_marital$year, na.rm = TRUE)

ui <- page_sidebar(
  title = "GenderForce: Global Labour Force Explorer",
  theme = bslib::bs_theme(bootswatch = "minty"),
  fillable = FALSE,
  sidebar = sidebar(
    title = "Filter Options",

    # Country Selector + Helper Text
    selectInput(
      inputId = "country_select",
      label = "Select Country:",
      choices = country_choices,
      selected = if ("Australia" %in% country_choices) "Australia" else  country_choices[1] ),
    helpText("Choose a country to inspect national labor trends and compare male vs. female participation rates."),

    hr(),

    # Age Group Selecter + Help Text
    selectInput(
        inputId = "age_select",
        label = "Select Age Group:",
        choices = age_choices,
        selected = if ("25-54" %in% age_choices) "25-54" else  age_choices[1]
        ),
    helpText("Filter by demographic age bracket. Note: '15+' represents the total aggregate working-age population."),

    hr(),

# Year Range Slider + Helper Text
sliderInput(
    inputId = "year_range",
    label = "Select Year Range:",
    min = min_year,
    max = max_year,
    value = c(min_year, max_year),
    step = 1,
    sep = ""
    ),
  helpText("Drag the slider handles to narrow or widen the historical timeframe for the trend analysis.")
  ),

  card(
    card_header("Target Audience & Purpose"),
    markdown("
    **Intended User**: General public readers and community advocates interested in global gender equity. <br>
    **Core Question**: *How does marital status impact the gender gap in labor force participation across different countries and age groups over time?*
             ")
    ),

  card(
    card_header("Labour Force Participation Over Time"),
    plotOutput("trend_plot"),
    hr(),
    card_footer(
      markdown("
               **How to Interpret this Plot:** <br>
               * **Line Comparison:** Solid/dashed lines distinguish *Married / Union / Cohabiting* from *Single / Widowed / Divorced* groups. <br>
               * **The Marital Gender Gap:** Observe whether married women show lower participation than married men (the 'marital penalty') and if that gap narrows among single individuals. <br>
               * **Trajectory:** Steep changes over time highlight structural or policy shifts in national workforce dynamics.
               ")
    )
    ),

  card(
    card_header("Executive Summary: Gender Gap Statistics"),
    tableOutput("gap_table"),
    hr(),
    card_footer(
      markdown("
               * **Gender Gap (percentage points):** Calculated as `Male Rate (%) - Female Rate (%)`. <br>
               * **Positive Values:** Indicate higher male participation relative to females. <br>
               * **Key Finding:** Comparing the gap across marital categories shows whether marriage amplifies or diminishes gender workforce disparities for the chosen age bracket.
               ")
    )
    ))


server <- function(input, output, session) {
  # Executive Aggregate Summary Table
  summary_gap_data <- reactive({
    raw_gap <- genderforce::calc_labor_gap(
      target_country = input$country_select,
      target_age = input$age_select
      ) |>
      dplyr::filter( year >= input$year_range[1],
                     year <= input$year_range[2]
                     )
    shiny::validate(
      shiny::need(
        nrow(raw_gap) != 0,
        "No summary available" ) )

    min_yr <- min(raw_gap$year)
    max_yr <- max(raw_gap$year)

    raw_gap |>
      dplyr::group_by(marital_status) |>
      dplyr::summarise(
        `Average Gap (%)` = round(mean(gender_gap, na.rm = TRUE), 2),
        `Latest Gap (%)` = round(gender_gap[year == max_yr][1], 2),
        `Period Change (%)` = round( gender_gap[year == max_yr][1] - gender_gap[year == min_yr][1], 2 ), .groups = "drop" ) |>
      dplyr::rename(`Marital Status` = marital_status)
    })


output$trend_plot <- renderPlot({
  # Store the filtered subset first so we can check for data quality flags
  plot_df <- genderforce::labor_force_marital |>
    dplyr::filter(
    country == input$country_select,
    age_group == input$age_select,
    year >= input$year_range[1],
    year <= input$year_range[2]
    )

  # Check if any row in the current view has a 'Break in series' flag
  has_break <- any(plot_df$data_status == "Break in series", na.rm = TRUE)
  caption_text <- if (has_break) {
    "* ▲ Triangle point indicates year(s) flagged with 'Break in series' (survey methodology change)."
  } else {
    NULL
  }

  # Build the plot with distinct shapes for break points
  plot_df |>
    ggplot(aes(
      x = year,
      y = participation_rate,
      color = sex,
      linetype = marital_status)) +
    geom_line(linewidth = 1) +
    geom_point(
      aes(shape = ifelse(!is.na(data_status) & data_status == "Break in series",
                         "Break in series", "Standard")),
      size = 3) +
    scale_shape_manual(
      values = c("Standard" = 16, "Break in series" = 17),
      name = "Data Quality"
    ) +
    theme_minimal(base_size = 12) +
    labs( title = paste("Participation Rate in",
                        input$country_select, "(Age:", input$age_select, ")"),
          y = "Participation Rate (%)",
          x = "Year",
          color = "Sex",
          linetype = "Marital Status",
          caption = caption_text)
  })

output$gap_table <- renderTable({
  summary_gap_data()
}, digit = 2, align = "c")
}

shinyApp(ui = ui, server = server)
