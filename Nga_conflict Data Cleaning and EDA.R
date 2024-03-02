nga_conflict <- read_excel("~/Self help Material & Datasets/conflict_data_nga.xlsx")


str(nga_conflict)

### Data Cleaning 

# Convert 'year' to numeric
nga_conflict$year <- as.numeric(nga_conflict$year)

# Convert 'code_status' to factor (assuming it's categorical)
nga_conflict$code_status <- as.factor(nga_conflict$code_status)


# Converting 'latitude' and 'longitude' to numeric
nga_conflict$latitude <- as.numeric(nga_conflict$latitude)
nga_conflict$longitude <- as.numeric(nga_conflict$longitude)


# Convert columns to factors
nga_conflict$number_of_sources <- as.factor(nga_conflict$number_of_sources)
nga_conflict$where_prec <- as.factor(nga_conflict$where_prec)
nga_conflict$event_clarity <- as.factor(nga_conflict$event_clarity)
nga_conflict$date_prec <- as.factor(nga_conflict$date_prec)


# Checking the data types after conversion
str(nga_conflict)

# Checking for missing values in each column
missing_values <- colSums(is.na(nga_conflict))

# Printing the number of missing values for each column
print(missing_values)


# Defining the columns with missing values you want to consider
columns_with_missing <- c("where_coordinates", "where_description", "adm_1", "latitude", "longitude", 
                          "event_clarity", "date_prec", "date_start", "date_end", "deaths_a", 
                          "deaths_b", "deaths_civilians", "best", "deaths_unknown")

# Subsetting the dataframe to keep only rows with complete data in the specified columns
nga_conflict <- nga_conflict[complete.cases(nga_conflict[, columns_with_missing]), ]

# Checking the dimensions of the dataframe after removing rows with missing values
dim(nga_conflict)


# Define the columns to drop
columns_to_drop <- c("source_office", "source_date", "source_headline", "adm_2", "relid", "code_status", 
                     "conflict_dset_id", "conflict_new_id", "dyad_dset_id", "dyad_new_id", "side_a_dset_id", 
                     "side_b_dset_id", "side_a_new_id", "side_b_new_id", "country", "iso3", "country_id", 
                     "region", "gwnoa", "gwnob", "low", "high")

# Drop the specified columns
nga_conflict <- nga_conflict[, !(names(nga_conflict) %in% columns_to_drop)]

# Check the structure of the dataframe after dropping columns
str(nga_conflict)

# Exclude columns starting with "..."
nga_conflict <- nga_conflict[, !grepl("^\\.\\.\\d+$", names(nga_conflict))]

# Check the structure of the dataframe after dropping columns
str(nga_conflict)


# renaming some column names
nga_conflict <- nga_conflict %>%
  rename(state = adm_1,
         place_coordinates = where_coordinates,
         place_description = where_description,
         place_precision = where_prec,
         total_deaths = best,
         conflict_sides = dyad_name)

# Check the structure of the dataframe after renaming columns
str(nga_conflict)


### Exploratory Data Analysis
 summary(nga_conflict)

#Distribution of Categorical Variables 
 table(nga_conflict$conflict_name)
 table(nga_conflict$state)
 table(nga_conflict$place_precision)
 table(nga_conflict$event_clarity)
 table(nga_conflict$date_prec)
 
 ggplot(nga_conflict, aes(x=date_start)) +
   geom_histogram(binwidth=50, fill="blue") +
   labs(title="Distribution of Conflict Events Over Time", x="Date", y="Frequency")
 
#Correlation Analysis 
 cor(nga_conflict[, c("year", "active_year", "type_of_violence", "latitude", "longitude", "deaths_a", "deaths_b", "deaths_civilians", "deaths_unknown", "total_deaths")])
 
 #Scatter plot for numerical variables 
 plot(nga_conflict$latitude, nga_conflict$longitude, xlab="Latitude", ylab="Longitude", main="Geographical Distribution")
 
 # Bar plots for categorical variables 
 barplot(table(nga_conflict$conflict_name), main="Conflict Name")
 barplot(table(nga_conflict$state), main="State")
 barplot(table(nga_conflict$place_precision), main="Place Precision")
 barplot(table(nga_conflict$event_clarity), main="Event Clarity")
 barplot(table(nga_conflict$date_prec), main="Date Precision")
 



