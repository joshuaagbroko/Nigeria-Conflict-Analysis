Conflict Data Analysis Project
Overview
This repository contains code and data for analyzing conflict data, particularly focusing on incidents in Nigeria. The project aims to gain insights into the patterns, trends, and dynamics of conflicts in the region.

Table of Contents
Introduction
Contents
Installation
Usage
Data
Analysis
Contributing
License

Introduction
This project explores conflict data from Nigeria, covering various aspects such as types of violence, involved parties, geographical locations, and temporal dynamics. By analyzing this data, we aim to understand the nature of conflicts in the region and identify potential patterns and trends.

## Contents

- `Data/`: Contains the raw and cleaned datasets used in the analysis.
- `Scripts/`: Includes SQL scripts used for data exploration and preprocessing.
- `Tableau/`: Contains the Tableau workbook and visualizations for the conflict analysis dashboard.

Installation
To run the code in this repository, you'll need to have R installed on your system. Additionally, ensure you have the required R packages installed by running:

R

install.packages(c("tidyverse", "ggplot2", "leaflet"))
Usage
The code in this repository can be used to perform various analyses on the conflict data. Here's a brief overview of the main files:

analyze_conflict_data.R: This script contains functions to clean, process, and analyze the conflict data.
visualize_conflict_data.R: This script generates visualizations to explore different aspects of the conflict data.
To get started, simply clone this repository to your local machine and run the R scripts using an IDE or the R console.

Data Exploration with SQL
In the initial phase of the project, SQL queries were used to explore and preprocess the dataset. Some of the SQL operations performed include:

Filtering and subsetting the dataset based on specific criteria.
Calculating aggregate statistics such as counts, sums, and averages.
Subsetting for Visualization in Tableau
After data exploration with SQL, the dataset was prepared for visualization in Tableau. This involved:

Selecting relevant columns for visualization.
Filtering and aggregating data to create meaningful insights.
Exporting the subsetted data for use in Tableau.

Tableau Dashboard
Using Tableau, a dynamic dashboard was created to visualize various aspects of conflict incidents in Nigeria. The dashboard includes:

Interactive visualizations such as maps, charts, and graphs.
Filters and parameters for users to explore the data.
Annotations and tooltips to provide additional context.
Trends and patterns over time and across different regions.

Data
The data used in this project is sourced from UCDP Georeferenced Event Dataset. This dataset is UCDP's most disaggregated dataset, covering individual events of organized violence (phenomena of lethal violence occurring at a given time and place). These events are sufficiently fine-grained to be geo-coded down to the level of individual villages, with temporal durations disaggregated to single, individual days.

Analysis
The analysis includes various exploratory data analysis (EDA) techniques to uncover insights from the conflict data. This includes:

Temporal analysis of conflict incidents over time
Geospatial analysis to visualize the distribution of conflicts across Nigeria
Analysis of casualty statistics and trends
Identification of major conflict parties and their involvement

Contributing
Contributions to this project are welcome! If you have ideas for improvements, new features, or bug fixes, feel free to open an issue or submit a pull request. For major changes, please open an issue first to discuss the proposed changes.

License
This project is licensed under the MIT License.