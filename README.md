# Drake Watson's Portfolio

---

### Examining Bias in the Narxcare Score: Unveiling Disparities in AI/ML Features for Opioid Prescribing Decisions

**Project Overview:** As a member of Dr. Sherry Wang's research team at Chapman University, we examined the NarxCare clinical decision support system that is frequently put to use in the U.S. healthcare system. NarxCare is a software that prescription drug prescribers reference to see the risk score associated with their potential patient, and we chose to investigate how the risk score may be associated with "protected characteristics" (such as age, gender, income, etc.) that ideally should not influence a person's healthcare decisions.

NarxCare's exact model for risk score is not public knowledge, but they do give some general insight into their algorithm, most notably the four main features which have the most weight in the model. Our study focused on the first of the four features: How many unique prescribers a patient has picked up prescriptions from. Our team at Chapman was granted access to the CURES-PDMP data (privacy proteced prescription records) that NarxCare bases their model off of as well, but in order to analyze the protected demographic information of the patients we needed to generalize their personal information by attaching their respective zipcode demographic information. We used official census data in order to accomplish this and from there we could analyze the generalized protected demographic traits of the individuals with high counts of unique prescribers. 

We performed the study on data from 2010-2022 which compiled into over 200 million observations. Dealing with such a large data set led to unique challenges in the data wrangling and analysis, but we settled upon performing t-tests on the means of the two subgroups (people with low unique prescribers in a certain timeframe vs people with high unique prescribers in a certain timeframe) across 4 different timeframes (2 months, 6 months, 12 months, and 24 months). Our results found that there were some significant associations with the protected characteristics and our full results can be seen in the example picture and poster below.

This study was accepted for presentation at the ISPOR 2024 in Atlanta, GA (poster seen below) as well as publication in the research journal Value in Health (link below)

<img src="assets/img/narxcare-poster.png?raw=true"/>

**Improvements:** Currently we are working on expanding the analysis to cover more of the features from the NarxCare documentation. We are hoping to pursue further publication and to bring more light to the topic of AI/ML models that may be inadvertently discriminatory in practice.

***Technical skills:*** data wrangling, statistical analysis, visualization

***Tools:*** python, R, jupyter

[![Publication Link](https://img.shields.io/badge/PDF-View_Report-red?logo=MicrosoftWord)](https://www.valueinhealthjournal.com/article/S1098-3015(24)01803-5/abstract)

---

---

### Video Game Sales Analysis & Prediction

**Project Overview:** In both my Data Visualizations and Data Programming courses at UW I chose to analyze international video game sales data from 2013-2019.

The Data Visualization project focused on analyzing sales traits through a diverse set of visualizations portraying the relationships between several different attributes in the dataset. I created a Tableau presentation board that identified sales characteristics of publishers, genres, and domestic sales success that could be used by a marketing or leadership team to inform decision making and future investments.

The Data Programming project was based around the development of a rudimentary machine learning model that could estimate where certain games would see successful sales numbers across the different international markets. The model was trained on the international sales data from the given time period and developed using decision tree classification in the scikit-learn package. The project model had a 78% accuracy score for predicting what region a game would be most successful in.

<img src="assets/img/vg-sales-tab-genre-heat.png?raw=true"/>
<img src="assets/img/vg-sales-tab-bar.png?raw=true"/>
<img src="assets/img/vg-sales-tree.png?raw=true"/>

**Improvements:** The accuracy score could be improved through further model engineering and attribute tweaking. I also made an attempt at developing a regression model that predicted the total sales numbers of games, but due to the incomplete nature of the sales data in the datasets that I merged together I was unable to create an accurate model (or test accurately). I would like to seek out datasets containing the complete scope of sales data in order to merge it with the dataset from this project in order to develop that sales prediction model.

***Technical skills:*** data visualization, SQL, regression, machine learning

***Tools:*** Tableau, python

[![Open Report](https://img.shields.io/badge/PDF-View_Report-red?logo=MicrosoftWord)](video-game-sales/vgsales-cs412/A3_Tableau_Visualizations.pdf)
[![Open Report](https://img.shields.io/badge/PDF-View_Report-red?logo=MicrosoftWord)](video-game-sales/vgsales-cs163/report.pdf)
[![Open Code](https://img.shields.io/badge/Jupyter-Open_Files-red?logo=Jupyter)](https://github.com/datadraco/datadraco.github.io/tree/main/video-game-sales)


---

### Alcohol & Life Expectancy

**Project Overview:** The final project in my Computer Science and Social Science course at UW asked each group to analyze a social issue or question with data science techniques. My partner and I chose to look at the relationship between alcohol consumption and life expectancy on an international scale.

Every few years a new headline is circulated that strongly declares a positive or negative relationship between casual alcohol usage. These reports are usually written with the sole focus of reader engagement and are based upon small scale group studies, so my group chose to look at the issue more analytically by diving into the World Bank data repository which houses decades of government supplied demographic and behavioral data from around the world.

We worked with the null hypothesis that there is no relationship between the alcohol consumption level of a given country and it's respective life expectancy, and through our statistical tests we failed to reject that hypothesis. It seemed that there was some relationship based upon the initial plots (e.g. european countries drank more and lived longer, african countries drank less and lived shorter) but through further plotting and k-means testing we could see no strong relationship. Through statistical analysis, visualizations, and regression models we clearly uncovered the GDP of a given country as a confounding variable.

<img src="assets/img/alc-continent-wrap.png?raw=true"/>
<img src="assets/img/alc-gdp.png?raw=true"/>
<img src="assets/img/alc-kmeans.png?raw=true"/>

**Improvements:** The next step that my partner and I wanted to take was to create 3D visualizations to look at the interplay between GDP, alcohol consumption, and life expectancy. We would also like to merge in new attributes (i.e. types of alcoholic drinks consumed, countries that are impacted by war, etc.) to see if there are other key variables that may uncover new correlations.

***Technical skills:*** statistical analysis, regression, R

***Tools:*** RStudio, R Markdown

[![Open Report](https://img.shields.io/badge/PDF-View_Report-red?logo=MicrosoftWord)](alcohol-life-expectancy/final_report.pdf)
[![Open Code](https://img.shields.io/badge/Jupyter-Open_Files-red?logo=Jupyter)](https://github.com/datadraco/datadraco.github.io/tree/main/alcohol-life-expectancy)


---

### World Happiness Report Web App

**Project Overview:** For the final project in one of my Informatics courses at UW, we were directed to create a multitab shinyapp web application that allowed the user to explore a dataset of our choice. I chose to use the World Happiness Report provided by the UN & Quality of Life data set provided by Numbeo.

The web application consists of multiple tabs containing interactive visualizations that allow the user to filter by different values. The front page establishes an understanding of the datasets that are being used to generate the visualizations. The following 4 tabs on the web app allow the user to analyze the distributions of the data various attributes through histograms, bar charts, scatter plots, and finally chloropleth map. Each tab has text that adjusts to the currently viewed attribute, and the final chloropleth map has a time animation visualization that slowly moves through the years of the data set and adjusts the map and table values below.

<img src="assets/img/whr-dist.png?raw=true"/>
<img src="assets/img/whr-chloropleth.png?raw=true"/>

**Improvements:** There are some improvements to the application interface that I would like to iron out such as centering the table outputs, creating more reactive text, and formating some of the graphs in a more engaging manner. I could also make some small improvements such as adding the regression line to the scatterplot page as opposed to just listing the correlation value below the graph.

***Technical skills:*** R, shinyapp, HTML

***Tools:*** RStudio, R Markdown

[![Open Report](https://img.shields.io/badge/PDF-View_Report-red?logo=MicrosoftWord)](https://drakerw.shinyapps.io/world-happiness-analysis/)
[![Open Code](https://img.shields.io/badge/Jupyter-Open_Files-red?logo=Jupyter)](https://github.com/datadraco/datadraco.github.io/tree/main/whr-shinyapp)

---

### Ukraine Crisis Evaluation

**Project Overview:** The final group project in my Data Visualization course at UW asked our group to develop informative and interactive visualizations in an Observable notebook covering an issue of our choice. My group selected the Ukrainian crisis and chose to focus on demographic and financial aspects of the ongoing war.

Our report explores the demographic aspects of the different regions in Ukraine and dives into how the oblasts are made up by religion, language, and ethnicity in order to get an idea of the identities of the regions that are being most affected by the crisis. We also explored the different kinds of humanitarian need that are needed throughout various oblasts and the characteristics of those most in need. The report also explores what regions are seeing the most intense displacement as well as what regions are taking in the most displaced people. All of the visualizations throughout the report allow for some user exploration through several types of interacting (filtering, searching, hovering, etc.)

<img src="assets/img/ukraine-aid-cost.png?raw=true"/>
<img src="assets/img/ukraine-displaced-flee.png?raw=true"/>

**Improvements:** At the time of creating the Observable notebook my group was relatively new to Julia and Javascript so there was some fine tuning to interactions and visualizations that we would've liked to complete given more time. I would also like to explore this crisis in the context of other wars by cross referencing with similar visualizations from previous conflicts in the region and from around the world to get a better idea of the severity of these figures.

***Technical skills:*** Julia, Javascript

***Tools:*** Observable

[![Open Report](https://img.shields.io/badge/PDF-View_Report-red?logo=MicrosoftWord)](https://observablehq.com/d/c6d0bc66a041bca9)
