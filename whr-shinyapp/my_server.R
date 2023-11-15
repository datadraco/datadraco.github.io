source("analysis.R")

my_server <- function(input, output) {

  # Reactive outputs for the introduction tab

  output$whr_table <- renderTable(
    align = "c",
    {
      head(world_happiness_2019_df)
    }
  )

  output$qol_table <- renderTable(
    align = "c",
    {
      head(qol_df)
    }
  )

  # Reactive outputs for the distribution tab

  output$dist_message <- renderText({
    message <- paste("The histogram below displays the distribution of all of the", input$index, "index scores.")

    message
  })

  output$hists <- renderPlot({
    qol_hist_df <- qol_hist_df %>%
      filter(indexes == input$index)

    x_label <- paste(input$index, "Index Scores")

    ggplot(qol_hist_df, aes(value)) +
      geom_histogram(aes(y = ..density..), binwidth = 10, color = "black", fill = "white") +
      geom_density(alpha = .2, fill = "#88419d") +
      theme_minimal() +
      labs(
        title = "Distribution of Scores",
        x = x_label,
        y = "Density of Observations"
      ) +
      theme(plot.title = element_text(hjust = 0.5))
  })

  # Reactive outputs for the mapping happiness tab

  output$map <- renderPlot({
    if (input$map_year == 2015) {
      mapped_data <- mapped_data2015
    }

    if (input$map_year == 2016) {
      mapped_data <- mapped_data2016
    }

    if (input$map_year == 2017) {
      mapped_data <- mapped_data2017
    }

    if (input$map_year == 2018) {
      mapped_data <- mapped_data2018
    }

    if (input$map_year == 2019) {
      mapped_data <- mapped_data2019
    }

    mapCountryData(
      mapped_data,
      mapTitle = paste("Happiness Scores in", input$map_year),
      nameColumnToPlot = "score",
      addLegend = T,
      colourPalette = brewer.pal(7, "BuPu")
    )
  })

  output$map_text <- renderText({
    message <- paste(
      "The world map is currently displaying the happiness metrics from the", input$map_year,
      "World Happiness Report. The table below is displaying the top 6 happiest countries
                     in", input$map_year
    )

    message
  })

  output$top_table <- renderTable(align = "c", {
    if (input$map_year == 2015) {
      happiest <- world_happiness_2015_df %>%
        select(
          "Country" = country,
          "Rank" = rank,
          "Score" = score,
          "GDP Per Capita" = gdp_per_cap,
          "Life Expectancy" = life_expectancy,
          "Choice Freedom" = choice_freedom,
          "Generosity" = generosity,
          "Corruption" = corruption
        )
    }

    if (input$map_year == 2016) {
      happiest <- world_happiness_2016_df %>%
        select(
          "Country" = country,
          "Rank" = rank,
          "Score" = score,
          "GDP Per Capita" = gdp_per_cap,
          "Life Expectancy" = life_expectancy,
          "Choice Freedom" = choice_freedom,
          "Generosity" = generosity,
          "Corruption" = corruption
        )
    }

    if (input$map_year == 2017) {
      happiest <- world_happiness_2017_df %>%
        select(
          "Country" = country,
          "Rank" = rank,
          "Score" = score,
          "GDP Per Capita" = gdp_per_cap,
          "Life Expectancy" = life_expectancy,
          "Choice Freedom" = choice_freedom,
          "Generosity" = generosity,
          "Corruption" = corruption
        )
    }

    if (input$map_year == 2018) {
      happiest <- world_happiness_2018_df %>%
        select(
          "Country" = country,
          "Rank" = rank,
          "Score" = score,
          "GDP Per Capita" = gdp_per_cap,
          "Social Support" = social_support,
          "Life Expectancy" = life_expectancy,
          "Choice Freedom" = choice_freedom,
          "Generosity" = generosity,
          "Corruption" = corruption
        )
    }

    if (input$map_year == 2019) {
      happiest <- world_happiness_2019_df %>%
        select(
          "Country" = country,
          "Rank" = rank,
          "Score" = score,
          "GDP Per Capita" = gdp_per_cap,
          "Social Support" = social_support,
          "Life Expectancy" = life_expectancy,
          "Choice Freedom" = choice_freedom,
          "Generosity" = generosity,
          "Corruption" = corruption
        )
    }

    head(happiest)
  })
}
