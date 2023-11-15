library(tidyr)
library(dplyr)
library(stringr)
library(ggplot2)
library(rworldmap)
library(rworldxtra)
library(knitr)
library(RColorBrewer)
library(scales)

##### Set Working Directory to source file location #####

### Data frames from the World Happiness Reports

# 2015 World Happiness Report

world_happiness_2015_df <- read.csv("data/WHR2015.csv", stringsAsFactors = FALSE)

# 2016 World Happiness Report
world_happiness_2016_df <- read.csv("data/WHR2016.csv", stringsAsFactors = FALSE)

# 2017 World Happiness Report
world_happiness_2017_df <- read.csv("data/WHR2017.csv", stringsAsFactors = FALSE)

# 2018 World Happiness Report
world_happiness_2018_df <- read.csv("data/WHR2018.csv", stringsAsFactors = FALSE)

# 2019 World Happiness Report
world_happiness_2019_df <- read.csv("data/WHR2019.csv", stringsAsFactors = FALSE)


### Data frames from the Countries Info (Early 2020)

# The Quality of Life data set summarizes a lot of the key data that is present in the Countries dataset,
# so we can use that one to compare with the World Happiness report

life_quality_df <- read.csv("data/QOL2020.csv", stringsAsFactors = FALSE)

### Merge Quality of Life 2020 and World Happiness 2019 data sets for joint analysis

# The WHR is from early 2020 and the QOL df is from 2019, so we should acknowledge the slightly shifted time lines

# Rename columns for joining and simplicity
whr_df <- world_happiness_2019_df %>%
  rename(
    rank = Overall.rank,
    score = Score,
    country = Country.or.region,
    gdp_per_cap = GDP.per.capita,
    social_support = Social.support,
    life_expectancy = Healthy.life.expectancy,
    choice_freedom = Freedom.to.make.life.choices,
    generosity = Generosity,
    corruption = Perceptions.of.corruption
  )

qol_df <- life_quality_df %>%
  rename(
    country =  Country,
    life_quality = Quality.of.Life.Index,
    purchase_power = Purchasing.Power.Index,
    safety = Safety.Index,
    health_care = Health.Care.Index,
    living_cost = Cost.of.Living.Index,
    property_price_to_income_ratio = Property.Price.to.Income.Ratio,
    commute_time = Traffic.Commute.Time.Index,
    pollution = Pollution.Index,
    climate = Climate.Index
  )

# Join World Happiness Report 2019 (WHR) and Quality of Life 2020 (QOL) data sets
whr_qol_df <- whr_df %>%
  left_join(qol_df, by = "country")

### Wrangle the World Happiness Reports into one data frame so that we can do analysis over time

# Select/rename columns that are relevant and exist in the WHR 2019_df
world_happiness_2015_df <- world_happiness_2015_df %>%
  select(
    country = Country,
    rank = Happiness.Rank,
    score = Happiness.Score,
    gdp_per_cap = Economy..GDP.per.Capita.,
    life_expectancy = Health..Life.Expectancy.,
    choice_freedom = Freedom,
    generosity = Generosity,
    corruption = Trust..Government.Corruption.,
  )

world_happiness_2016_df <- world_happiness_2016_df %>%
  select(
    country = Country,
    rank = Happiness.Rank,
    score = Happiness.Score,
    gdp_per_cap = Economy..GDP.per.Capita.,
    life_expectancy = Health..Life.Expectancy.,
    choice_freedom = Freedom,
    generosity = Generosity,
    corruption = Trust..Government.Corruption.,
  )

world_happiness_2017_df <- world_happiness_2017_df %>%
  select(
    country = Country,
    rank = Happiness.Rank,
    score = Happiness.Score,
    gdp_per_cap = Economy..GDP.per.Capita.,
    life_expectancy = Health..Life.Expectancy.,
    choice_freedom = Freedom,
    generosity = Generosity,
    corruption = Trust..Government.Corruption.,
  )

world_happiness_2018_df <- world_happiness_2018_df %>%
  select(
    country = Country.or.region,
    rank = Overall.rank,
    score = Score,
    gdp_per_cap = GDP.per.capita,
    social_support = Social.support,
    life_expectancy = Healthy.life.expectancy,
    choice_freedom = Freedom.to.make.life.choices,
    generosity = Generosity,
    corruption = Perceptions.of.corruption
  )

# Handle the one N/A string in 2018
world_happiness_2018_df[world_happiness_2018_df == "N/A"] <- NA

world_happiness_2019_df <- world_happiness_2019_df %>%
  select(
    country = Country.or.region,
    rank = Overall.rank,
    score = Score,
    gdp_per_cap = GDP.per.capita,
    social_support = Social.support,
    life_expectancy = Healthy.life.expectancy,
    choice_freedom = Freedom.to.make.life.choices,
    generosity = Generosity,
    corruption = Perceptions.of.corruption
  )

# Pivot before joining
pivoted_whr_2015_df <- world_happiness_2015_df %>%
  pivot_longer(rank:corruption, names_to = "category", values_to = "x2015")

pivoted_whr_2016_df <- world_happiness_2016_df %>%
  pivot_longer(rank:corruption, names_to = "category", values_to = "x2016")

pivoted_whr_2017_df <- world_happiness_2017_df %>%
  pivot_longer(rank:corruption, names_to = "category", values_to = "x2017")

pivoted_whr_2018_df <- world_happiness_2018_df %>%
  mutate(corruption = as.double(corruption)) %>% # Handles combine error
  pivot_longer(rank:corruption, names_to = "category", values_to = "x2018")

pivoted_whr_2019_df <- world_happiness_2019_df %>%
  pivot_longer(rank:corruption, names_to = "category", values_to = "x2019")

# Join WHR df's to create time series df
whr_time_series_df <- pivoted_whr_2015_df %>%
  left_join(pivoted_whr_2016_df, by = c("country", "category")) %>%
  left_join(pivoted_whr_2017_df, by = c("country", "category")) %>%
  left_join(pivoted_whr_2018_df, by = c("country", "category")) %>%
  left_join(pivoted_whr_2019_df, by = c("country", "category"))


##### Section 2.2

# World Happiness Report Time Series descriptive stats

whr_num_rows <- nrow(world_happiness_2019_df)

happiness_scores_df <- whr_time_series_df %>%
  filter(category == "score")

avg_2015_happiness <- signif(mean(happiness_scores_df$"x2015", na.rm = TRUE), 4)
avg_2016_happiness <- signif(mean(happiness_scores_df$"x2016", na.rm = TRUE), 4)
avg_2017_happiness <- signif(mean(happiness_scores_df$"x2017", na.rm = TRUE), 4)
avg_2018_happiness <- signif(mean(happiness_scores_df$"x2018", na.rm = TRUE), 4)
avg_2019_happiness <- signif(mean(happiness_scores_df$"x2019", na.rm = TRUE), 4)
Mean <- c(avg_2015_happiness, avg_2016_happiness, avg_2017_happiness, avg_2018_happiness, avg_2019_happiness)

median_2015_happiness <- signif(median(happiness_scores_df$"x2015", na.rm = TRUE), 4)
median_2016_happiness <- signif(median(happiness_scores_df$"x2016", na.rm = TRUE), 4)
median_2017_happiness <- signif(median(happiness_scores_df$"x2017", na.rm = TRUE), 4)
median_2018_happiness <- signif(median(happiness_scores_df$"x2018", na.rm = TRUE), 4)
median_2019_happiness <- signif(median(happiness_scores_df$"x2019", na.rm = TRUE), 4)
Median <- c(median_2015_happiness, median_2016_happiness, median_2017_happiness, median_2018_happiness, median_2019_happiness)

min_happiness_2015 <- min(happiness_scores_df$"x2015", na.rm = TRUE)
min_happiness_2016 <- min(happiness_scores_df$"x2016", na.rm = TRUE)
min_happiness_2017 <- signif(min(happiness_scores_df$"x2017", na.rm = TRUE), 4)
min_happiness_2018 <- min(happiness_scores_df$"x2018", na.rm = TRUE)
min_happiness_2019 <- min(happiness_scores_df$"x2019", na.rm = TRUE)
Minimum <- c(min_happiness_2015, min_happiness_2016, min_happiness_2017, min_happiness_2018, min_happiness_2019)

max_happiness_2015 <- max(happiness_scores_df$"x2015", na.rm = TRUE)
max_happiness_2016 <- max(happiness_scores_df$"x2016", na.rm = TRUE)
max_happiness_2017 <- signif(max(happiness_scores_df$"x2017", na.rm = TRUE), 4)
max_happiness_2018 <- max(happiness_scores_df$"x2018", na.rm = TRUE)
max_happiness_2019 <- max(happiness_scores_df$"x2019", na.rm = TRUE)
Maximum <- c(max_happiness_2015, max_happiness_2016, max_happiness_2017, max_happiness_2018, max_happiness_2019)

Year <- c(2015, 2016, 2017, 2018, 2019)

whr_descriptive_df <- data.frame(Year, Minimum, Maximum, Median, Mean)

whr_descriptive_plot_df <- whr_descriptive_df %>% 
  pivot_longer(Minimum:Mean, names_to = 'Statistic', values_to = 'Value')

happiness_stats_plot <- ggplot(whr_descriptive_plot_df) +
  geom_point(mapping = aes(x = Year, y = Value, color = Statistic)) +
  geom_line(mapping = aes(x = Year, y = Value, color = Statistic)) +
  scale_color_brewer(palette = "Set2") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(
    title = 'Happiness Statistics 2015-2019',
    x = 'Year',
    y = 'Happiness Score',
    color = 'Statistic'
  )

# Quality of Life descriptive stats

qol_columns <- colnames(qol_df)

qol_num_rows <- nrow(qol_df)

qol_no_countries_df <- qol_df %>% 
  select(life_quality:climate)

qol_cols_no_countries <- colnames(qol_no_countries_df)

qol_mins <- apply(qol_no_countries_df, 2, min)
qol_maxs <- apply(qol_no_countries_df, 2, max)
qol_means <- apply(qol_no_countries_df, 2, mean)
qol_medians <- apply(qol_no_countries_df, 2, median)

qol_description_df <- data.frame(qol_cols_no_countries, qol_mins, qol_maxs, qol_medians, qol_means) %>% 
  select(
    Indexes = qol_cols_no_countries,
    Minimum = qol_mins,
    Maximum = qol_maxs,
    Median = qol_medians,
    Means = qol_means
  )

rownames(qol_description_df) <- c()

qol_hist_df <- qol_df %>% 
  select(
    'Life Quality' = life_quality,
    'Purchase Power' = purchase_power,
    'Safety' = safety,
    'Health Care' = health_care,
    'Living Cost' = living_cost,
    'Property:Income Ratio' = property_price_to_income_ratio,
    'Commute Time' = commute_time,
    'Pollution' = pollution,
    'Climate' = climate
    ) %>% 
  pivot_longer('Life Quality':'Climate', names_to = 'indexes')

qol_hists <- ggplot(qol_hist_df, aes(value)) +
  geom_histogram(binwidth = 10, fill = "#b3cde3") +
  facet_wrap(~indexes) +
  theme_minimal() +
  labs(
    title = 'Distribution of Index Scores (Histograms)',
    x = 'Index Scores',
    y = 'Number of Observations'
  ) +
  theme(plot.title = element_text(hjust = 0.5))

qol_density_curves <- ggplot(qol_hist_df) +
  geom_density(aes(value), color = "#88419d") +
  facet_wrap(~indexes) +
  theme_minimal() +
  labs(
    title = 'Distribution of Index Scores (Density Curves)',
    x = 'Index Scores',
    y = 'Density of Observations'
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    axis.text.y = element_blank())

# Where is the happiness in each year?
mapped_data2019 <- joinCountryData2Map(
  world_happiness_2019_df,
  joinCode = "NAME",
  nameJoinColumn = "country",
  mapResolution = "high"
)

mapped_data2018 <- joinCountryData2Map(
  world_happiness_2018_df,
  joinCode = "NAME",
  nameJoinColumn = "country",
  mapResolution = "high"
)

mapped_data2017 <- joinCountryData2Map(
  world_happiness_2017_df,
  joinCode = "NAME",
  nameJoinColumn = "country",
  mapResolution = "high"
)

mapped_data2016 <- joinCountryData2Map(
  world_happiness_2016_df,
  joinCode = "NAME",
  nameJoinColumn = "country",
  mapResolution = "high"
)

mapped_data2015 <- joinCountryData2Map(
  world_happiness_2015_df,
  joinCode = "NAME",
  nameJoinColumn = "country",
  mapResolution = "high"
)

# Where has happiness changed the most from 2015-2019?
# whr_trends_df
happy_shift_df <- whr_time_series_df %>%
  filter(category == "score") %>%
  mutate(happy_shift = x2019 - x2015) %>%
  select(country, happy_shift) %>%
  drop_na()

mapped_data_trend <- joinCountryData2Map(
  happy_shift_df,
  joinCode = "NAME",
  nameJoinColumn = "country",
  mapResolution = "high"
)

top_10_happiest_2019 <- world_happiness_2019_df %>%
  filter(rank <= 10) %>%
  select(country) %>%
  pull(country)

top_10_happy_shift <- happy_shift_df %>%
  arrange(desc(happy_shift)) %>%
  slice_max(happy_shift, n = 10) %>%
  pull(country)

bottom_10_happy_shift <- happy_shift_df %>%
  arrange(desc(happy_shift)) %>%
  slice_min(happy_shift, n = 10) %>%
  pull(country)

# Descriptive list for rmd

description_list <- list(
  happiest_2019 = top_10_happiest_2019,
  biggest_shifts = top_10_happy_shift,
  worst_shifts = bottom_10_happy_shift,
  mean_health_care = mean_health_care,
  max_health_care = max_health_care,
  mean_qol = mean_qol,
  max_qol = max_qol,
  finland_qol = finland_qol,
  finland_hc = finland_hc,
  r_value_commute_time = r_value_commute_time,
  r_value_health_care = r_value_health_care,
  r_value_life_quality = r_value_life_quality,
  r_value_living_cost = r_value_living_cost,
  r_value_pollution = r_value_pollution,
  r_value_purchase_power = r_value_purchase_power,
  r_value_safety = r_value_safety,
  whr_num_countries = whr_num_rows,
  qol_columns = qol_columns,
  qol_num_countries = qol_num_rows
)
