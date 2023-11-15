library(shinythemes)
source("analysis.R")

my_ui <- navbarPage(
  # includeCSS("style.css"), throwing weird tag$ error that I cant figure out yet
  theme = shinytheme("sandstone"),
  "World Happiness",

  tabPanel(
    "Introduction",
    h2("Where is the Happiness?", align = "center"),
    br(),
    p(
      "Happiness is something that all of us pursue throughout our lives, yet measuring happiness is somewhat tricky. We all have our likes,
    dislikes, passions, and pet-peeves, but on a much higher level is it possible to gauge the happiness of humanity as a whole? The United
    Nations set out to do this beginning in 2012 with the first ",
      a("World Happiness Report",
        href = "https://worldhappiness.report/"
      ),
      "which serves as the inspiration for this study."
    ),
    br(),
    img(src = "https://miro.medium.com/max/600/1*RWR4s5t5h_ve0D4fy5-Z9w.jpeg", width = "400", height = "300", 
        style="display: block; margin-left: auto; margin-right: auto;"),
    br(),
    p("The problem",
      em("domain "),
      "for this study will be the happiness of the countries around the world. Using data about a countries demographics, health statistics, 
    and happiness rating, we would like to evaluate what qualities and characteristics of a country indicate that it is a happy and healthy 
    one, or an unhappy and unhealthy one. There is an abundance of data being collected about the countries of the world that many people 
    are attempting to use to quantify the success and health of a country, and we are hoping to merge some of that data together to get some 
    insight on how that data relates to each other. To better compare countries, data is calculated into indexes (climate index, crime index, 
    etc.) so that there is a quantifiable way to evaluate countries against one another. Obviously this method is just a rough estimation, and 
    the domain we are working with will be a rough estimation itself as the issue of happiness and health is a very vague and nuanced one, but 
    we still hope to use these data sets to gain some valuable insight into the well-being of the world."),
    br(),
    p("This analysis will make use of several data sets that were found on",
      a("Kaggle",href = "https://www.kaggle.com/"),
      "and then merged together in order to do some cross analysis. The following sections will go into detail about the data sets that were the
    source of our study."),
    hr(),
    h3("World Happiness Reports", align = "center"),
    br(),
    tableOutput(outputId = "whr_table"),
    br(),
    p("As seen in the table above, the ",
    a("World Happiness Report", href= 'https://www.kaggle.com/unsdsn/world-happiness'),
    "gives us the country name, overall rank, happiness score, and then six more columns 
    that attempt to quantify the influence that those factors have on the overall score. The columns following the happiness score estimate the 
    extent to which each of six factors – economic production, social support, life expectancy, freedom, absence of corruption, and generosity – 
    contribute to making life evaluations higher in each country than they are in Dystopia, a hypothetical country that has values equal to the 
    world’s lowest national averages for each of the six factors. They have no impact on the total score reported for each country, but they do 
    explain why some countries rank higher than others."),
    em("(Note: these factors were formatted and included differently from 2015-2019, so we 
    converted all of them to match the format of 2019 seen above)"),
    hr(),
    h3("Quality of Life", align = "center"),
    br(),
    p("The ",
    a("Quality of Life", href= "https://www.kaggle.com/dumbgeek/countries-dataset-2020?select=Quality+of+life+index+by+countries+2020.csv"),
    "data set was originally generated for the ",
    a("Countries Data Set", href= "https://www.kaggle.com/dumbgeek/countries-dataset-2020"),
    "in order to provide demographic information about countries so that some correlations might be found with the spread of coronavirus in 
    early 2020. This data was scraped from ",
    a("Numbeo", href= "https://www.numbeo.com/quality-of-life/"), 
    "which is a crowd-sourced global database of quality of life statistics. The scores are in the form of indexes which is a technique that 
    is widely used when attempting to rate and compare countries across different criteria."),
    br(),
    tableOutput(outputId = "qol_table"),
    br(),
    p("As seen in the table above, the Quality of Life data set provides us with a country name, and then many columns representing demographic 
      characteristics (overall life quality, safety, health care, etc.) that have been generalized into index scores so that they can be rated 
      against one another. This is not an exact process as many of these aspects of life are very nuanced and subjective, but it is one of the 
      best techniques that can be used to attempt to quantify the different traits of a country."),
    hr(),
    p("For a more extensive look into the analysis done for the report, you can find the data report ",
      a("here", href="https://info201b-wi21.github.io/project-ryanpark01/"))
  ),

  tabPanel(
    "Quality of Life Distribution",
    h2("Exploring the Quality of Life Data", align = 'center'),
    p("The Quality of Life data set includes observations from ~150 countries and the index scores have been collected from a website called ",
      a("Numbeo", href = "https://www.numbeo.com/quality-of-life/"),
      "which is a crowd-sourced global database of quality of life statistics. These index scores are put to use later in this report
      by cross-referencing with the World Happiness Report to gauge which of these index scores have a correlation with overall happiness."
    ),
    br(),
    textOutput(outputId = "dist_message"),
    hr(),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "index",
          "Index:",
          c(unique(as.character(qol_hist_df$indexes)))
        )
      ),
      mainPanel(
        plotOutput(outputId = "hists")
      )
    ),
    hr(),
    p("All of the index distribtions appear to be fairly normal without any eggregious outliers.
      This is definitely something to keep in mind as we move forward to evaluate which of these
      index scores most directly relates to the happiness scores.")
  ),
  
  tabPanel(
    "Mapping Happiness", ##### Drakes analysis question page
    h2("Happiness Across the Globe", align = "center"),
    hr(),
    p("Two of the key questions that we wanted to explore were:",
      HTML("<ul>
             <li>How has the overall happiness of the globe shifted in the five years of data that we're provided?</li>
             <li>Where are the happiest areas of the world?</li>
             </ul>"),
      "Both of these questions could be
      evaluated through a heatmap visualization of the world displaying all of the
      countries happiness metrics on a continuous scale, and thats what you see below.
      Another way of evaluating the way that happiness has changed over this five year
      time span is shown in the our",
      a("Data Report", href="https://info201b-wi21.github.io/project-ryanpark01/"),
      "in which we map the five year happiness shift."),
    hr(),
    sidebarLayout(
      sidebarPanel(
        sliderInput("map_year",
          "Year:",
          sep = "",
          min = 2015,
          max = 2019,
          step = 1,
          value = 2019,
          animate = animationOptions(interval = 2500, loop = F)
        ),
        textOutput(outputId = 'map_text'),
      ),
      mainPanel(
        plotOutput(outputId = "map"),
      )
    ),
    hr(),
    tableOutput(outputId = "top_table"),
    hr(),
    p("After evaluating these visualiations, we noticed a few trends and peculiarities. Western Europe and the Australian
      region seem to be particularly happy areas in the world, with North America also seeing some happiness stability over
      this time frame. Also, the African continent has easily been the most volatile over this five year time span as it has
      seen some of the sharpest increases and decreases in the world."),
    hr()
  )
)
