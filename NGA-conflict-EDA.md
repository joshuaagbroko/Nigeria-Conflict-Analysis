---
author: Agbroko Joshua
date: 2024-01-02
title: Nigeria Conflict Data EDA
---

## Introduction

This Jupyter Notebook serves as a comprehensive analysis of conflict
data in Nigeria. The dataset used in this analysis contains information
about various conflicts, including their locations, durations, types of
violence, and associated fatalities.

The purpose of this analysis is to gain insights into the patterns and
dynamics of conflicts in Nigeria. By examining the data, we aim to
understand the geographical distribution of conflicts, the temporal
trends in violence, the major actors involved, and the impact of
conflicts on civilian populations.

    #Importing necessary libraries

    library(openxlsx) # For writing excel files 
    library(readxl)  # For reading Excel files
    library(tidyverse)    # For data manipulation
    library(ggplot2)  # For data visualization

## Data wrangling

### Handling data Types

    # Displaying the structure of the dataframe
    str(nga_conflict)
    ## tibble [5,748 × 57] (S3: tbl_df/tbl/data.frame)
    ##  $ id               : num [1:5748] 15960 15970 15720 15733 17161 ...
    ##  $ relid            : chr [1:5748] "NIG-2009-1-793-1" "NIG-2009-1-793-4" "NIG-2009-1-793-5.2" "NIG-2009-1-793-2" ...
    ##  $ year             : num [1:5748] 2009 2009 2009 2009 2009 ...
    ##  $ active_year      : num [1:5748] 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ code_status      : chr [1:5748] "Clear" "Clear" "Clear" "Clear" ...
    ##  $ type_of_violence : num [1:5748] 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ conflict_dset_id : num [1:5748] 297 297 297 297 297 297 297 297 297 297 ...
    ##  $ conflict_new_id  : num [1:5748] 297 297 297 297 297 297 297 297 297 297 ...
    ##  $ conflict_name    : chr [1:5748] "Nigeria: Government" "Nigeria: Government" "Nigeria: Government" "Nigeria: Government" ...
    ##  $ dyad_dset_id     : num [1:5748] 640 640 640 640 640 640 640 640 640 640 ...
    ##  $ dyad_new_id      : num [1:5748] 640 640 640 640 640 640 640 640 640 640 ...
    ##  $ dyad_name        : chr [1:5748] "Government of Nigeria - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Government of Nigeria - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Government of Nigeria - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Government of Nigeria - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" ...
    ##  $ side_a_dset_id   : num [1:5748] 84 84 84 84 84 84 84 84 84 84 ...
    ##  $ side_a_new_id    : num [1:5748] 84 84 84 84 84 84 84 84 84 84 ...
    ##  $ side_a           : chr [1:5748] "Government of Nigeria" "Government of Nigeria" "Government of Nigeria" "Government of Nigeria" ...
    ##  $ side_b_dset_id   : num [1:5748] 1051 1051 1051 1051 1051 ...
    ##  $ side_b_new_id    : num [1:5748] 1051 1051 1051 1051 1051 ...
    ##  $ side_b           : chr [1:5748] "Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" ...
    ##  $ number_of_sources: num [1:5748] 1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...
    ##  $ source_article   : chr [1:5748] "\"All Africa,2009-06-16,Police Deny Shooting Islamic Sect Members\"" "Reuters 2009-07-27 \"UPDATE 4-Muslim rebels expand attacks, at least 80 dead\"; AP 2009-07-27 \"Nigeria police:"| __truncated__ "AFP 2009-07-27 \"65 dead in religious attacks in northern Nigeria: police\"; \"Nigerian Islamist militants attack another town" "AFP 2009-07-26 \"Forty-two dead as 'Taliban' sect, police clash in Nigeria\"; Reuters 2009-07-26 \"UPDATE 1-Nig"| __truncated__ ...
    ##  $ source_office    : chr [1:5748] "All Africa" NA NA NA ...
    ##  $ source_date      : chr [1:5748] "39980" NA NA NA ...
    ##  $ source_headline  : chr [1:5748] "Police Deny Shooting Islamic Sect Members" NA NA NA ...
    ##  $ source_original  : chr [1:5748] "analyst with the International Crisis Group" "Reuters reporter; police" "security sources and residents" "hospital source, police" ...
    ##  $ where_prec       : chr [1:5748] "1" "1" "4" "1" ...
    ##  $ where_coordinates: chr [1:5748] "Maiduguri town" "Maiduguri town" "Bauchi state" "Bauchi town" ...
    ##  $ where_description: chr [1:5748] "Maiduguri town" "Maiduguri town" "Bauchi state" "Bauchi town" ...
    ##  $ adm_1            : chr [1:5748] "Borno state" "Borno state" "Bauchi state" "Bauchi state" ...
    ##  $ adm_2            : chr [1:5748] "Maiduguri lga" "Maiduguri lga" NA "Bauchi lga" ...
    ##  $ latitude         : num [1:5748] 11.8 11.8 10.5 10.3 12 ...
    ##  $ longitude        : chr [1:5748] "13.160274" "13.160274" "10" "9.843273" ...
    ##  $ geom_wkt         : chr [1:5748] "POINT (13.16027423 11.84644069)" "POINT (13.16027423 11.84644069)" "POINT (10 10.5)" "POINT (9.843273 10.313441)" ...
    ##  $ priogrid_gid     : chr [1:5748] "146547" "146547" "145101" "144380" ...
    ##  $ country          : chr [1:5748] "Nigeria" "Nigeria" "Nigeria" "Nigeria" ...
    ##  $ iso3             : chr [1:5748] "NGA" "NGA" "NGA" "NGA" ...
    ##  $ country_id       : chr [1:5748] "475" "475" "475" "475" ...
    ##  $ region           : chr [1:5748] "Africa" "Africa" "Africa" "Africa" ...
    ##  $ event_clarity    : num [1:5748] 1 2 2 1 2 1 2 1 1 2 ...
    ##  $ date_prec        : num [1:5748] 1 2 2 1 2 2 1 1 1 2 ...
    ##  $ date_start       : POSIXct[1:5748], format: "2009-06-09" "2009-07-26" ...
    ##  $ date_end         : POSIXct[1:5748], format: "2009-06-09" "2009-07-28" ...
    ##  $ deaths_a         : num [1:5748] 0 13 2 1 2 1 0 0 0 0 ...
    ##  $ deaths_b         : num [1:5748] 0 87 9 37 10 0 0 0 0 0 ...
    ##  $ deaths_civilians : num [1:5748] 0 0 0 3 0 0 0 0 0 0 ...
    ##  $ deaths_unknown   : num [1:5748] 0 103 0 1 0 0 0 0 0 0 ...
    ##  $ best             : num [1:5748] 0 203 11 42 12 1 0 0 0 0 ...
    ##  $ high             : num [1:5748] 14 206 11 51 12 1 19 20 20 215 ...
    ##  $ low              : num [1:5748] 0 203 11 39 12 1 0 0 0 0 ...
    ##  $ gwnoa            : num [1:5748] 475 475 475 475 475 475 475 475 475 475 ...
    ##  $ gwnob            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...51            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...52            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...53            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...54            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...55            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...56            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...57            : logi [1:5748] NA NA NA NA NA NA ...
    # Convert 'year' to numeric
    nga_conflict$year <- as.numeric(nga_conflict$year)

    # Convert 'code_status' to factor (assuming it's categorical)
    nga_conflict$code_status <- as.factor(nga_conflict$code_status)

    # Convert 'latitude' and 'longitude' to numeric
    nga_conflict$latitude <- as.numeric(nga_conflict$latitude)
    nga_conflict$longitude <- as.numeric(nga_conflict$longitude)
    ## Warning: NAs introduced by coercion
    # Convert columns to factors
    nga_conflict$number_of_sources <- as.factor(nga_conflict$number_of_sources)
    nga_conflict$where_prec <- as.factor(nga_conflict$where_prec)
    nga_conflict$event_clarity <- as.factor(nga_conflict$event_clarity)
    nga_conflict$date_prec <- as.factor(nga_conflict$date_prec)

    # Check the data types after conversion
    str(nga_conflict)
    ## tibble [5,748 × 57] (S3: tbl_df/tbl/data.frame)
    ##  $ id               : num [1:5748] 15960 15970 15720 15733 17161 ...
    ##  $ relid            : chr [1:5748] "NIG-2009-1-793-1" "NIG-2009-1-793-4" "NIG-2009-1-793-5.2" "NIG-2009-1-793-2" ...
    ##  $ year             : num [1:5748] 2009 2009 2009 2009 2009 ...
    ##  $ active_year      : num [1:5748] 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ code_status      : Factor w/ 1 level "Clear": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ type_of_violence : num [1:5748] 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ conflict_dset_id : num [1:5748] 297 297 297 297 297 297 297 297 297 297 ...
    ##  $ conflict_new_id  : num [1:5748] 297 297 297 297 297 297 297 297 297 297 ...
    ##  $ conflict_name    : chr [1:5748] "Nigeria: Government" "Nigeria: Government" "Nigeria: Government" "Nigeria: Government" ...
    ##  $ dyad_dset_id     : num [1:5748] 640 640 640 640 640 640 640 640 640 640 ...
    ##  $ dyad_new_id      : num [1:5748] 640 640 640 640 640 640 640 640 640 640 ...
    ##  $ dyad_name        : chr [1:5748] "Government of Nigeria - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Government of Nigeria - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Government of Nigeria - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Government of Nigeria - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" ...
    ##  $ side_a_dset_id   : num [1:5748] 84 84 84 84 84 84 84 84 84 84 ...
    ##  $ side_a_new_id    : num [1:5748] 84 84 84 84 84 84 84 84 84 84 ...
    ##  $ side_a           : chr [1:5748] "Government of Nigeria" "Government of Nigeria" "Government of Nigeria" "Government of Nigeria" ...
    ##  $ side_b_dset_id   : num [1:5748] 1051 1051 1051 1051 1051 ...
    ##  $ side_b_new_id    : num [1:5748] 1051 1051 1051 1051 1051 ...
    ##  $ side_b           : chr [1:5748] "Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" ...
    ##  $ number_of_sources: Factor w/ 18 levels "-1","1","2","3",..: 2 1 1 1 1 1 1 1 1 1 ...
    ##  $ source_article   : chr [1:5748] "\"All Africa,2009-06-16,Police Deny Shooting Islamic Sect Members\"" "Reuters 2009-07-27 \"UPDATE 4-Muslim rebels expand attacks, at least 80 dead\"; AP 2009-07-27 \"Nigeria police:"| __truncated__ "AFP 2009-07-27 \"65 dead in religious attacks in northern Nigeria: police\"; \"Nigerian Islamist militants attack another town" "AFP 2009-07-26 \"Forty-two dead as 'Taliban' sect, police clash in Nigeria\"; Reuters 2009-07-26 \"UPDATE 1-Nig"| __truncated__ ...
    ##  $ source_office    : chr [1:5748] "All Africa" NA NA NA ...
    ##  $ source_date      : chr [1:5748] "39980" NA NA NA ...
    ##  $ source_headline  : chr [1:5748] "Police Deny Shooting Islamic Sect Members" NA NA NA ...
    ##  $ source_original  : chr [1:5748] "analyst with the International Crisis Group" "Reuters reporter; police" "security sources and residents" "hospital source, police" ...
    ##  $ where_prec       : Factor w/ 29 levels "1","2","3","4",..: 1 1 4 1 4 1 4 4 4 1 ...
    ##  $ where_coordinates: chr [1:5748] "Maiduguri town" "Maiduguri town" "Bauchi state" "Bauchi town" ...
    ##  $ where_description: chr [1:5748] "Maiduguri town" "Maiduguri town" "Bauchi state" "Bauchi town" ...
    ##  $ adm_1            : chr [1:5748] "Borno state" "Borno state" "Bauchi state" "Bauchi state" ...
    ##  $ adm_2            : chr [1:5748] "Maiduguri lga" "Maiduguri lga" NA "Bauchi lga" ...
    ##  $ latitude         : num [1:5748] 11.8 11.8 10.5 10.3 12 ...
    ##  $ longitude        : num [1:5748] 13.16 13.16 10 9.84 11.5 ...
    ##  $ geom_wkt         : chr [1:5748] "POINT (13.16027423 11.84644069)" "POINT (13.16027423 11.84644069)" "POINT (10 10.5)" "POINT (9.843273 10.313441)" ...
    ##  $ priogrid_gid     : chr [1:5748] "146547" "146547" "145101" "144380" ...
    ##  $ country          : chr [1:5748] "Nigeria" "Nigeria" "Nigeria" "Nigeria" ...
    ##  $ iso3             : chr [1:5748] "NGA" "NGA" "NGA" "NGA" ...
    ##  $ country_id       : chr [1:5748] "475" "475" "475" "475" ...
    ##  $ region           : chr [1:5748] "Africa" "Africa" "Africa" "Africa" ...
    ##  $ event_clarity    : Factor w/ 9 levels "0","1","2","5.48333",..: 2 3 3 2 3 2 3 2 2 3 ...
    ##  $ date_prec        : Factor w/ 18 levels "0","1","2","3",..: 2 3 3 2 3 3 2 2 2 3 ...
    ##  $ date_start       : POSIXct[1:5748], format: "2009-06-09" "2009-07-26" ...
    ##  $ date_end         : POSIXct[1:5748], format: "2009-06-09" "2009-07-28" ...
    ##  $ deaths_a         : num [1:5748] 0 13 2 1 2 1 0 0 0 0 ...
    ##  $ deaths_b         : num [1:5748] 0 87 9 37 10 0 0 0 0 0 ...
    ##  $ deaths_civilians : num [1:5748] 0 0 0 3 0 0 0 0 0 0 ...
    ##  $ deaths_unknown   : num [1:5748] 0 103 0 1 0 0 0 0 0 0 ...
    ##  $ best             : num [1:5748] 0 203 11 42 12 1 0 0 0 0 ...
    ##  $ high             : num [1:5748] 14 206 11 51 12 1 19 20 20 215 ...
    ##  $ low              : num [1:5748] 0 203 11 39 12 1 0 0 0 0 ...
    ##  $ gwnoa            : num [1:5748] 475 475 475 475 475 475 475 475 475 475 ...
    ##  $ gwnob            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...51            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...52            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...53            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...54            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...55            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...56            : logi [1:5748] NA NA NA NA NA NA ...
    ##  $ ...57            : logi [1:5748] NA NA NA NA NA NA ...

### Handling Missing Values

    # Checking for missing values in each column
    missing_values <- colSums(is.na(nga_conflict))

    # Printing the number of missing values for each column
    print(missing_values)
    ##                id             relid              year       active_year 
    ##                 0                 0                 0                 0 
    ##       code_status  type_of_violence  conflict_dset_id   conflict_new_id 
    ##                 0                 0                 0                 0 
    ##     conflict_name      dyad_dset_id       dyad_new_id         dyad_name 
    ##                 0                 0                 0                 0 
    ##    side_a_dset_id     side_a_new_id            side_a    side_b_dset_id 
    ##                 0                 0                 0                 0 
    ##     side_b_new_id            side_b number_of_sources    source_article 
    ##                 0                 0                 0                 0 
    ##     source_office       source_date   source_headline   source_original 
    ##              1170              1170              1179              1385 
    ##        where_prec where_coordinates where_description             adm_1 
    ##                 0                 3                31                44 
    ##             adm_2          latitude         longitude          geom_wkt 
    ##               775                10                21                 0 
    ##      priogrid_gid           country              iso3        country_id 
    ##                 0                 0                 0                 0 
    ##            region     event_clarity         date_prec        date_start 
    ##                 1                 5                 4                 6 
    ##          date_end          deaths_a          deaths_b  deaths_civilians 
    ##                 2                 4                 4                 3 
    ##    deaths_unknown              best              high               low 
    ##                 3                 3                 5                16 
    ##             gwnoa             gwnob             ...51             ...52 
    ##              3062              5741              5740              5742 
    ##             ...53             ...54             ...55             ...56 
    ##              5742              5742              5745              5746 
    ##             ...57 
    ##              5746
    # Defining the columns with missing values you want to consider
    columns_with_missing <- c("where_coordinates", "where_description", "adm_1", "latitude", "longitude", 
                              "event_clarity", "date_prec", "date_start", "date_end", "deaths_a", 
                              "deaths_b", "deaths_civilians", "best", "deaths_unknown")

    # Subsetting the dataframe to keep only rows with complete data in the specified columns
    nga_conflict <- nga_conflict[complete.cases(nga_conflict[, columns_with_missing]), ]

    # Checking the dimensions of the dataframe after removing rows with missing values
    dim(nga_conflict)
    ## [1] 5660   57

### Dropping Unnecessary Columns

    # Defining columns to drop
    columns_to_drop <- c("source_office", "source_date", "source_headline", "adm_2", "relid", "code_status", 
                         "conflict_dset_id", "conflict_new_id", "dyad_dset_id", "dyad_new_id", "side_a_dset_id", 
                         "side_b_dset_id", "side_a_new_id", "side_b_new_id", "country", "iso3", "country_id", 
                         "region", "gwnoa", "gwnob", "low", "high")

    # Drop the specified columns
    nga_conflict <- nga_conflict[, !(names(nga_conflict) %in% columns_to_drop)]

    # Check the structure of the dataframe after dropping columns
    str(nga_conflict)
    ## tibble [5,660 × 35] (S3: tbl_df/tbl/data.frame)
    ##  $ id               : num [1:5660] 15960 15970 15720 15733 17161 ...
    ##  $ year             : num [1:5660] 2009 2009 2009 2009 2009 ...
    ##  $ active_year      : num [1:5660] 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ type_of_violence : num [1:5660] 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ conflict_name    : chr [1:5660] "Nigeria: Government" "Nigeria: Government" "Nigeria: Government" "Nigeria: Government" ...
    ##  $ dyad_name        : chr [1:5660] "Government of Nigeria - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Government of Nigeria - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Government of Nigeria - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Government of Nigeria - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" ...
    ##  $ side_a           : chr [1:5660] "Government of Nigeria" "Government of Nigeria" "Government of Nigeria" "Government of Nigeria" ...
    ##  $ side_b           : chr [1:5660] "Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" "Jama'atu Ahlis Sunna Lidda'awati wal-Jihad" ...
    ##  $ number_of_sources: Factor w/ 18 levels "-1","1","2","3",..: 2 1 1 1 1 1 1 1 1 1 ...
    ##  $ source_article   : chr [1:5660] "\"All Africa,2009-06-16,Police Deny Shooting Islamic Sect Members\"" "Reuters 2009-07-27 \"UPDATE 4-Muslim rebels expand attacks, at least 80 dead\"; AP 2009-07-27 \"Nigeria police:"| __truncated__ "AFP 2009-07-27 \"65 dead in religious attacks in northern Nigeria: police\"; \"Nigerian Islamist militants attack another town" "AFP 2009-07-26 \"Forty-two dead as 'Taliban' sect, police clash in Nigeria\"; Reuters 2009-07-26 \"UPDATE 1-Nig"| __truncated__ ...
    ##  $ source_original  : chr [1:5660] "analyst with the International Crisis Group" "Reuters reporter; police" "security sources and residents" "hospital source, police" ...
    ##  $ where_prec       : Factor w/ 29 levels "1","2","3","4",..: 1 1 4 1 4 1 4 4 4 1 ...
    ##  $ where_coordinates: chr [1:5660] "Maiduguri town" "Maiduguri town" "Bauchi state" "Bauchi town" ...
    ##  $ where_description: chr [1:5660] "Maiduguri town" "Maiduguri town" "Bauchi state" "Bauchi town" ...
    ##  $ adm_1            : chr [1:5660] "Borno state" "Borno state" "Bauchi state" "Bauchi state" ...
    ##  $ latitude         : num [1:5660] 11.8 11.8 10.5 10.3 12 ...
    ##  $ longitude        : num [1:5660] 13.16 13.16 10 9.84 11.5 ...
    ##  $ geom_wkt         : chr [1:5660] "POINT (13.16027423 11.84644069)" "POINT (13.16027423 11.84644069)" "POINT (10 10.5)" "POINT (9.843273 10.313441)" ...
    ##  $ priogrid_gid     : chr [1:5660] "146547" "146547" "145101" "144380" ...
    ##  $ event_clarity    : Factor w/ 9 levels "0","1","2","5.48333",..: 2 3 3 2 3 2 3 2 2 3 ...
    ##  $ date_prec        : Factor w/ 18 levels "0","1","2","3",..: 2 3 3 2 3 3 2 2 2 3 ...
    ##  $ date_start       : POSIXct[1:5660], format: "2009-06-09" "2009-07-26" ...
    ##  $ date_end         : POSIXct[1:5660], format: "2009-06-09" "2009-07-28" ...
    ##  $ deaths_a         : num [1:5660] 0 13 2 1 2 1 0 0 0 0 ...
    ##  $ deaths_b         : num [1:5660] 0 87 9 37 10 0 0 0 0 0 ...
    ##  $ deaths_civilians : num [1:5660] 0 0 0 3 0 0 0 0 0 0 ...
    ##  $ deaths_unknown   : num [1:5660] 0 103 0 1 0 0 0 0 0 0 ...
    ##  $ best             : num [1:5660] 0 203 11 42 12 1 0 0 0 0 ...
    ##  $ ...51            : logi [1:5660] NA NA NA NA NA NA ...
    ##  $ ...52            : logi [1:5660] NA NA NA NA NA NA ...
    ##  $ ...53            : logi [1:5660] NA NA NA NA NA NA ...
    ##  $ ...54            : logi [1:5660] NA NA NA NA NA NA ...
    ##  $ ...55            : logi [1:5660] NA NA NA NA NA NA ...
    ##  $ ...56            : logi [1:5660] NA NA NA NA NA NA ...
    ##  $ ...57            : logi [1:5660] NA NA NA NA NA NA ...
    # renaming some column names
    nga_conflict <- nga_conflict %>%
      rename(state = adm_1,
             place_coordinates = where_coordinates,
             place_description = where_description,
             place_precision = where_prec,
             total_deaths = best,
             conflict_sides = dyad_name)

# Exploratory Data Analysis

### Summary Statistics

    summary(nga_conflict)
    ##        id              year       active_year    type_of_violence
    ##  Min.   : 13223   Min.   :1990   Min.   :0.000   Min.   :1.000   
    ##  1st Qu.: 62420   1st Qu.:2013   1st Qu.:1.000   1st Qu.:1.000   
    ##  Median :231421   Median :2016   Median :1.000   Median :2.000   
    ##  Mean   :204531   Mean   :2015   Mean   :0.923   Mean   :1.841   
    ##  3rd Qu.:290331   3rd Qu.:2019   3rd Qu.:1.000   3rd Qu.:3.000   
    ##  Max.   :430464   Max.   :2021   Max.   :1.000   Max.   :3.000   
    ##                                                                  
    ##  conflict_name      conflict_sides        side_a             side_b         
    ##  Length:5660        Length:5660        Length:5660        Length:5660       
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##  number_of_sources source_article     source_original    place_precision
    ##  1      :2570      Length:5660        Length:5660        1      :3191   
    ##  -1     :1163      Class :character   Class :character   3      :1099   
    ##  2      :1148      Mode  :character   Mode  :character   2      : 891   
    ##  3      : 404                                            5      : 274   
    ##  4      : 173                                            4      : 205   
    ##  5      : 106                                            42864  :   0   
    ##  (Other):  96                                            (Other):   0   
    ##  place_coordinates  place_description     state              latitude     
    ##  Length:5660        Length:5660        Length:5660        Min.   : 4.286  
    ##  Class :character   Class :character   Class :character   1st Qu.: 8.617  
    ##  Mode  :character   Mode  :character   Mode  :character   Median :11.104  
    ##                                                           Mean   :10.244  
    ##                                                           3rd Qu.:11.846  
    ##                                                           Max.   :13.691  
    ##                                                                           
    ##    longitude       geom_wkt         priogrid_gid       event_clarity 
    ##  Min.   : 2.71   Length:5660        Length:5660        1      :5240  
    ##  1st Qu.: 8.70   Class :character   Class :character   2      : 420  
    ##  Median :12.57   Mode  :character   Mode  :character   0      :   0  
    ##  Mean   :11.02                                         5.48333:   0  
    ##  3rd Qu.:13.35                                         475    :   0  
    ##  Max.   :14.50                                         41690  :   0  
    ##                                                        (Other):   0  
    ##    date_prec      date_start                   
    ##  1      :4673   Min.   :1990-09-25 00:00:00.0  
    ##  2      : 741   1st Qu.:2013-06-29 18:00:00.0  
    ##  4      : 149   Median :2016-05-13 00:00:00.0  
    ##  3      :  57   Mean   :2015-07-29 03:25:03.5  
    ##  5      :  40   3rd Qu.:2019-04-22 06:00:00.0  
    ##  0      :   0   Max.   :2021-12-30 00:00:00.0  
    ##  (Other):   0                                  
    ##     date_end                         deaths_a          deaths_b      
    ##  Min.   :1990-10-10 00:00:00.00   Min.   :  0.000   Min.   :  0.000  
    ##  1st Qu.:2013-06-29 18:00:00.00   1st Qu.:  0.000   1st Qu.:  0.000  
    ##  Median :2016-05-14 12:00:00.00   Median :  0.000   Median :  0.000  
    ##  Mean   :2015-07-30 18:03:18.45   Mean   :  1.362   Mean   :  3.666  
    ##  3rd Qu.:2019-04-23 00:00:00.00   3rd Qu.:  0.000   3rd Qu.:  2.000  
    ##  Max.   :2021-12-30 00:00:00.00   Max.   :200.000   Max.   :660.000  
    ##                                                                      
    ##  deaths_civilians   deaths_unknown     total_deaths      ...51        
    ##  Min.   :   0.000   Min.   :  0.000   Min.   :   0.00   Mode:logical  
    ##  1st Qu.:   0.000   1st Qu.:  0.000   1st Qu.:   1.00   NA's:5660     
    ##  Median :   0.000   Median :  0.000   Median :   3.00                 
    ##  Mean   :   3.192   Mean   :  2.444   Mean   :  10.66                 
    ##  3rd Qu.:   1.000   3rd Qu.:  0.000   3rd Qu.:   9.00                 
    ##  Max.   :2478.000   Max.   :988.000   Max.   :2478.00                 
    ##                                                                       
    ##   ...52          ...53          ...54          ...55          ...56        
    ##  Mode:logical   Mode:logical   Mode:logical   Mode:logical   Mode:logical  
    ##  NA's:5660      NA's:5660      NA's:5660      NA's:5660      NA's:5660     
    ##                                                                            
    ##                                                                            
    ##                                                                            
    ##                                                                            
    ##                                                                            
    ##   ...57        
    ##  Mode:logical  
    ##  NA's:5660     
    ##                
    ##                
    ##                
    ##                
    ## 

# Distribution of Categorical Variables

     table(nga_conflict$conflict_name)
    ## 
    ##                      Abugbe (Agatu) - Agbaduma (Agatu) 
    ##                                                      2 
    ##                                          Adoni - Ogoni 
    ##                                                      4 
    ##                Afisare, Anaguta, Birom - Fulani, Hausa 
    ##                                                      5 
    ##                                          Afor - Fulani 
    ##                                                      2 
    ##                                         Agatu - Fulani 
    ##                                                     42 
    ##                                            Agatu - Tiv 
    ##                                                      2 
    ##                                      Aguleri - Umuleri 
    ##                                                      2 
    ##                                          Alago - Eggon 
    ##                                                      7 
    ##                       Ambazonia insurgents - Civilians 
    ##                                                      1 
    ##                                        Atakar - Fulani 
    ##                                                     19 
    ##                                         Atyap - Fulani 
    ##                                                     25 
    ##                                          Atyap - Hausa 
    ##                                                      1 
    ##                                            Azara - Tiv 
    ##                                                      1 
    ##                               Bakassi boys - Civilians 
    ##                                                      7 
    ##                             Bassa Kwomu - Egbura Mozum 
    ##                                                     18 
    ##                                          Bini - Urhobo 
    ##                                                      1 
    ##                                         Birom - Fulani 
    ##                                                    156 
    ##                                  Birom - Fulani, Hausa 
    ##                                                      7 
    ##                                       Black Axe - Eyie 
    ##                                                    181 
    ##                                    Black Axe - Maphite 
    ##                                                     13 
    ##        Black Axe, Bush Boys, Deebam, KK, NDV - Outlaws 
    ##                                                      3 
    ##                                          Boje - Nsadop 
    ##                                                      3 
    ##                                 Bonta Boys - Civilians 
    ##                                                      2 
    ##                                       Bwatiye - Fulani 
    ##                                                     46 
    ##                                    Cameroon: Ambazonia 
    ##                                                      2 
    ##                                Cameroon: Islamic State 
    ##                                                      2 
    ##                                          Chabo - Hausa 
    ##                                                      1 
    ##               Christians (Nigeria) - Muslims (Nigeria) 
    ##                                                    178 
    ##                                       Deebam - Deewell 
    ##                                                     40 
    ##                                           Deebam - NDV 
    ##                                                     33 
    ##                                          Efik - Ibibio 
    ##                                                      3 
    ##                                         Eggon - Fulani 
    ##                                                     30 
    ##                                       Eggon - Gwandere 
    ##                                                      3 
    ##                                  Eleme - Okrika (Ijaw) 
    ##                                                      2 
    ##                                           Ezilo - Ezza 
    ##                                                      9 
    ##                                           Ezza - Korri 
    ##                                                      6 
    ##                                      FNDIC - Civilians 
    ##                                                      7 
    ##                        Forces of Agala - Forces of Edu 
    ##                                                      2 
    ##                                        Fulani - Irigwe 
    ##                                                     78 
    ##                                   Fulani - Izzi (Igbo) 
    ##                                                      2 
    ##                                         Fulani - Jukun 
    ##                                                     14 
    ##                                        Fulani - Kadara 
    ##                                                     22 
    ##                                       Fulani - Karimjo 
    ##                                                      1 
    ##                                       Fulani - Mambila 
    ##                                                     10 
    ##                                         Fulani - Tarok 
    ##                                                     25 
    ##                                           Fulani - Tiv 
    ##                                                    307 
    ##                                       Fulani - Wurukum 
    ##                                                      2 
    ##                                       Fulani - Yandang 
    ##                                                     10 
    ##                                        Fulani - Yoruba 
    ##                                                     31 
    ##                                         Fulani - Yugur 
    ##                                                      2 
    ##                                            Gamai - Pan 
    ##                                                      1 
    ##                     Government of Cameroon - Civilians 
    ##                                                      2 
    ##                      Government of Nigeria - Civilians 
    ##                                                    287 
    ##                                     Greenlanders - NDV 
    ##                                                     30 
    ##                                           Hausa - Igbo 
    ##                                                      4 
    ##                                   Hausa - Igbo, Yoruba 
    ##                                                      1 
    ##                                          Hausa - Jukun 
    ##                                                      3 
    ##                                         Hausa - Kadara 
    ##                                                      2 
    ##                                         Hausa - Ninzam 
    ##                                                      1 
    ##                                         Hausa - Sayawa 
    ##                                                      7 
    ##                                          Hausa - Tarok 
    ##                                                      3 
    ##                                         Hausa - Yoruba 
    ##                                                     22 
    ##                                            Ichen - Tiv 
    ##                                                     10 
    ##                                         Ife - Modakeke 
    ##                                                     17 
    ##                                             Igbo - Tiv 
    ##                                                      1 
    ##                                           Ijaw - Ilaje 
    ##                                                      5 
    ##                                        Ijaw - Itsekiri 
    ##                                                     38 
    ##                                          Ijaw - Urhobo 
    ##                                                      3 
    ##                                Ijaw, Urhobo - Itsekiri 
    ##                                                      4 
    ##           Ikot-Offiong community - Oku Iboku community 
    ##                                                      4 
    ##                                Ikpanya (Ibibio) - Efik 
    ##                                                      1 
    ##                           Ikurav (Tiv) - Shitile (Tiv) 
    ##                                                      6 
    ##                                       IPOB - Civilians 
    ##                                                     16 
    ##                                         IS - Civilians 
    ##                                                    281 
    ##        IS - Jama'atu Ahlis Sunna Lidda'awati wal-Jihad 
    ##                                                     16 
    ##                                          IS - Yan Gora 
    ##                                                     56 
    ##                                Isenasawo - Isongo-furo 
    ##                                                      3 
    ##                                    Izzi (Igbo) - Ukele 
    ##                                                      1 
    ## Jama'atu Ahlis Sunna Lidda'awati wal-Jihad - Civilians 
    ##                                                    847 
    ##  Jama'atu Ahlis Sunna Lidda'awati wal-Jihad - Yan Gora 
    ##                                                     63 
    ##                                           Jole - Shomo 
    ##                                                      1 
    ##                                            Jukun - Tiv 
    ##                                                     53 
    ##                                            Kuteb - Tiv 
    ##                                                      4 
    ##                                            Kwala - Tiv 
    ##                                                      1 
    ##                                         Lunguda - Waja 
    ##                                                      5 
    ##                                          Ndoki - Ogoni 
    ##                                                      1 
    ##                                            NDPVF - NDV 
    ##                                                     10 
    ##                                        Nigeria: Biafra 
    ##                                                     43 
    ##                                    Nigeria: Government 
    ##                                                   1123 
    ##                                 Nigeria: Islamic State 
    ##                                                   1172 
    ##                                   Nigeria: Niger Delta 
    ##                                                      6 
    ##                              Nigeria: Northern Nigeria 
    ##                                                      8 
    ##                          NURTW-Auxiliary - NURTW-Tokyo 
    ##                                                      2 
    ##                                  Ogoni - Okrika (Ijaw) 
    ##                                                      5 
    ##                          Oleh (Isoko) - Olmoro (Isoko) 
    ##                                                      1 
    ##                  Supporters of ACN - Supporters of PDP 
    ##                                                     26 
    ##                   Supporters of AD - Supporters of PDP 
    ##                                                      5 
    ##                 Supporters of ANPP - Supporters of PDP 
    ##                                                     44 
    ##                  Supporters of APC - Supporters of PDP 
    ##                                                     35 
    ##                 Supporters of PDP - Supporters of UNPP 
    ##                                                      1 
    ##                Wanhihem community - Wanikade community 
    ##                                                      1 
    ##                                  Yan Sakai - Civilians 
    ##                                                      6
     table(nga_conflict$state)
    ## 
    ##                Abia state             Adamawa state           Akwa Ibom state 
    ##                        14                       261                        31 
    ##             Anambra state              Bauchi state             Bayelsa state 
    ##                        49                        62                        46 
    ##               Benue state               Borno state         Cross River state 
    ##                       287                      2902                        12 
    ##               Delta state              Ebonyi state                 Edo state 
    ##                        95                        31                        59 
    ##               Ekiti state               Enugu state Federal Capital territory 
    ##                         8                        16                        14 
    ##               Gombe state             Gongola state                 Imo state 
    ##                        35                         1                        37 
    ##              Jigawa state              Kaduna state                Kano state 
    ##                         6                       183                        91 
    ##             Katsina state               Kebbi state                Kogi state 
    ##                         6                         1                        28 
    ##               Kwara state               Lagos state            Nasarawa state 
    ##                        19                       128                       111 
    ##               Niger state                Ogun state                Ondo state 
    ##                        13                        44                        22 
    ##                Osun state                 Oyo state             Plateau state 
    ##                        33                        35                       364 
    ##              Rivers state              Sokoto state              Taraba state 
    ##                       158                        16                       194 
    ##                Yobe state             Zamfara state 
    ##                       241                         7
     table(nga_conflict$place_precision)
    ## 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 1 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              3191 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 2 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               891 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 3 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              1099 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 4 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               205 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             42864 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 5 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               274 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 6 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          6.961429 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          6.981596 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          Aba town 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                Army vs Boko Haram 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Birnin Gwari lga 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Damboa lga 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   Gunmen Kill 16 in Four Plateau Villages"";""World Watch Monitor 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Ikara town 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        June 1994" 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       Kachia town 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Kaduna state 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       Kaduna town 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   Nasarawa state" 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     Nigerian Forces Foil Attack On Police Command 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                Rapyem village, Barkin Ladi local government area in Plateau state 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                The community head 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ## The Maximum Leader and the Rising Wave of Banditry;Breaking: None of the abducted schoolboys is dead 鈥?Masari;Katsina abduction: 2 students killed by kidnappers 鈥?Escapee;Boko Haram on Tuesday claimed it was behind the abduction of hundreds of students in northwestern Nigeria, in what appears to be a major expansion of the jihadist group's activities into new areas.;Katsina Students Abduction - PDP Accuses Buhari, APC of Insensitivity;Katsina Abduction - Kidnappers in Talks Through Miyetti Allah - Masari;Dozens Of Secondary School Students Kidnapped In Katsina;17 Nigerian students rescued from Boko Haram, two dead: Official;Shekau And Govt鈥檚 Claims On Kankara Abduction Raise Unanswered Questions;鈥楽ome Of Us Were Killed鈥? Abducted Kankara Boys Speak In New Boko Haram Video ;Boko Haram鈥檚 Pan-Nigerian Affiliate System after the Kankara Kidnapping: A Microcosm of Islamic State鈥檚 鈥楨xternal Provinces鈥?Nigerian schoolboys meet president after kidnap ordeal 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            villages in DANGULBI District, MARU LGA, ZAMFARA State 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Zango-Kataf town 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Zaria lga 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Zaria town 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  鈥榊ansakai group killed 21 Fulani in Zamfara鈥? 
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0
     table(nga_conflict$event_clarity)
    ## 
    ##       0       1       2 5.48333     475   41690   43296   44310  136455 
    ##       0    5240     420       0       0       0       0       0       0
     table(nga_conflict$date_prec)
    ## 
    ##       0       1       2       3       4       5 7.03041 9.56796     475   33739 
    ##       0    4673     741      57     149      40       0       0       0       0 
    ##   36577   36584   36668   41690   42853   43296   44313  147269 
    ##       0       0       0       0       0       0       0       0

## Histogram of Conflict Events over Time

    ggplot(nga_conflict, aes(x = date_start)) +
      geom_line(stat = "count", color = "blue") +
      labs(title = "Distribution of Conflict Events Over Time", x = "Date", y = "Frequency")

![](media/rId27.png){width="5.0526312335958in"
height="4.0421052055993in"}

## Correlation Analysis between Numerical Variables

    cor(nga_conflict[, c("year", "active_year", "type_of_violence", "latitude", "longitude", "deaths_a", "deaths_b", "deaths_civilians", "deaths_unknown", "total_deaths")])
    ##                          year active_year type_of_violence     latitude
    ## year              1.000000000  0.11200621     -0.261738301  0.340602002
    ## active_year       0.112006213  1.00000000     -0.097383599  0.301238427
    ## type_of_violence -0.261738301 -0.09738360      1.000000000 -0.296341395
    ## latitude          0.340602002  0.30123843     -0.296341395  1.000000000
    ## longitude         0.344188112  0.30224083     -0.282148300  0.814606646
    ## deaths_a         -0.036701143  0.02659644     -0.066658427  0.013827650
    ## deaths_b          0.001036536  0.05306827     -0.154428471  0.070668329
    ## deaths_civilians -0.055470477  0.02285024      0.114398173  0.002014061
    ## deaths_unknown   -0.182755950  0.01007310      0.002636594 -0.079098109
    ## total_deaths     -0.138921973  0.04705184      0.020415057 -0.008601569
    ##                     longitude     deaths_a     deaths_b deaths_civilians
    ## year              0.344188112 -0.036701143  0.001036536     -0.055470477
    ## active_year       0.302240826  0.026596436  0.053068268      0.022850237
    ## type_of_violence -0.282148300 -0.066658427 -0.154428471      0.114398173
    ## latitude          0.814606646  0.013827650  0.070668329      0.002014061
    ## longitude         1.000000000 -0.005060952  0.080178784      0.013233060
    ## deaths_a         -0.005060952  1.000000000  0.080123573     -0.011008727
    ## deaths_b          0.080178784  0.080123573  1.000000000     -0.017542663
    ## deaths_civilians  0.013233060 -0.011008727 -0.017542663      1.000000000
    ## deaths_unknown   -0.076416650  0.002279979 -0.008801409     -0.008634993
    ## total_deaths      0.002026119  0.181396027  0.375170323      0.760084392
    ##                  deaths_unknown total_deaths
    ## year               -0.182755950 -0.138921973
    ## active_year         0.010073098  0.047051836
    ## type_of_violence    0.002636594  0.020415057
    ## latitude           -0.079098109 -0.008601569
    ## longitude          -0.076416650  0.002026119
    ## deaths_a            0.002279979  0.181396027
    ## deaths_b           -0.008801409  0.375170323
    ## deaths_civilians   -0.008634993  0.760084392
    ## deaths_unknown      1.000000000  0.486302354
    ## total_deaths        0.486302354  1.000000000

## Scatter Plot for Geographical Distribution

     plot(nga_conflict$latitude, nga_conflict$longitude, xlab="Latitude", ylab="Longitude", main="Geographical Distribution")

![](media/rId32.png){width="5.0526312335958in"
height="4.0421052055993in"}

## Bar plots for Categorical Variables

     barplot(table(nga_conflict$conflict_name), main="Conflict Name")

![](media/rId36.png){width="5.0526312335958in"
height="4.0421052055993in"}

     barplot(table(nga_conflict$state), main="State")

![](media/rId39.png){width="5.0526312335958in"
height="4.0421052055993in"}

     barplot(table(nga_conflict$place_precision), main="Place Precision")

![](media/rId42.png){width="5.0526312335958in"
height="4.0421052055993in"}

     barplot(table(nga_conflict$event_clarity), main="Event Clarity")

![](media/rId45.png){width="5.0526312335958in"
height="4.0421052055993in"}

     barplot(table(nga_conflict$date_prec), main="Date Precision")

![](media/rId48.png){width="5.0526312335958in"
height="4.0421052055993in"}

### Exporting the data

     excel_file <- "nga_conflict_data_clean.xlsx"
     
     # Export the dataframe to Excel
     write.xlsx(nga_conflict, excel_file, rowNames = FALSE)
     
     # Confirmation message
     cat("DataFrame has been exported to", excel_file, "\n")
    ## DataFrame has been exported to nga_conflict_data_clean.xlsx
