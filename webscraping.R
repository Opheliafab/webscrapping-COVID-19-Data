#webscrapping a covid-19 page for data analysis

#install.packages("httr")
#install.packages("rvest")
library(httr)
library(rvest)

get_wiki_covid19_page <- function() {
  
  # target COVID-19 wiki page URL is: https://en.wikipedia.org/w/index.php?title=Template:COVID-19_testing_by_country  
  # Which has two parts: 
  # 1) base URL `https://en.wikipedia.org/w/index.php  
  # 2) URL parameter: `title=Template:COVID-19_testing_by_country`, seperated by question mark ?
  
  # Wiki page base
  wiki_base_url <- "https://en.wikipedia.org/w/index.php"
  # create a List which has an element called `title` to specify which page you want to get from Wiki
  # in this case, it will be `Template:COVID-19_testing_by_country`
  
  html_list <- list(title = 'Template:COVID-19_testing_by_country')
  
  # - Use the `GET` function in httr library with a `url` argument and a `query` arugment to get a HTTP response
  http_response <- GET(wiki_base_url, query=html_list)
  # Use the `return` function to return the response
  return(http_response)
}

#calling the function
get_wiki_covid19_page()

# Get the root html node from the http response
root_html_node <- read_html("https://en.wikipedia.org/w/index.php?title=Template%3ACOVID-19_testing_by_country")
root_html_node

# Get the table node from the root html node
table_node <- html_nodes(root_html_node, "table")
table_node

# Read the table node and convert it into a data frame, and print the data frame for review
data_frame <- html_table(table_node[2])
data_frame <- as.data.frame(data_frame)
head(data_frame)

#get the summary of the exported dataframe to view the details
summary(data_frame)

#function to preprocess datafram by removing irrelevant columns, rename columns 
#and converting columns to appropriate data type

preprocess_covid_data_frame <- function(data_frame) {
  
  shape <- dim(data_frame)
  
  # Remove the World row
  data_frame<-data_frame[!(data_frame$`Country.or.region`=="World"),]
  # Remove the last row
  data_frame <- data_frame[1:172, ]
  
  # We dont need the Units and Ref columns, so can be removed
  data_frame["Ref."] <- NULL
  data_frame["Units.b."] <- NULL
  
  # Renaming the columns
  names(data_frame) <- c("country", "date", "tested", "confirmed", "confirmed.tested.ratio", "tested.population.ratio", "confirmed.population.ratio")
  
  # Convert column data types
  data_frame$country <- as.factor(data_frame$country)
  data_frame$date <- as.factor(data_frame$date)
  data_frame$tested <- as.numeric(gsub(",","",data_frame$tested))
  data_frame$confirmed <- as.numeric(gsub(",","",data_frame$confirmed))
  data_frame$'confirmed.tested.ratio' <- as.numeric(gsub(",","",data_frame$`confirmed.tested.ratio`))
  data_frame$'tested.population.ratio' <- as.numeric(gsub(",","",data_frame$`tested.population.ratio`))
  data_frame$'confirmed.population.ratio' <- as.numeric(gsub(",","",data_frame$`confirmed.population.ratio`))
  
  return(data_frame)
}

# call `preprocess_covid_data_frame` function and assign it to a new data frame
new_data_frame <- preprocess_covid_data_frame(data_frame)

# Print the summary of the processed data frame again
summary(new_data_frame)

# Export the data frame to a csv file
write.csv(new_data_frame, file="covid.csv", row.names=FALSE)

# Read covid_data_frame_csv from the csv file
my_data <- read.csv("covid.csv")
# Get the 5th to 10th rows, with two "country" "confirmed" columns
new_data <- my_data[5:10, c("country", "confirmed")]
new_data

# Get the total confirmed cases worldwide
total_confirmed_cases <- sum(my_data$confirmed)
total_confirmed_cases
# Get the total tested cases worldwide
total_tested_cases <- sum(my_data$tested)
total_tested_cases
# Get the positive ratio (confirmed / tested)
positive_ratio <- total_confirmed_cases/total_tested_cases
positive_ratio

#regular expression matches
#identify country names that start with 'United'

reg_exp_ex <- regexpr("United.+", my_data[,'country'])
x <- regmatches(my_data[,'country'], reg_exp_ex)
# Print the matched country names
x

first_country <- my_data[my_data[, 'country'] == "United States", 
                         c("country","confirmed","confirmed.population.ratio")]
first_country
# Select a subset (should be only one row) of data frame based on a selected country name and columns
second_country <- my_data[my_data[, 'country'] == "United Kingdom", 
                          c("country", "confirmed", "confirmed.population.ratio")]
second_country

# Use if-else statement to determine if the US or the UK has a greater ratio of confirmed cases to population
uk <- second_country$confirmed.population.ratio
us <- first_country$confirmed.population.ratio

if (us > uk) {
  print("United States is greater")
} else {
  print("United Kingdom is greater")
}

#finding out which country has a confirmed to population ratio less than 1% as it may 
#indicate that the risk of those countries is comparatively low

population = 0.99

if (population < 1) {
    subset(my_data, confirmed.population.ratio < 1, 
           select=c(country, confirmed.population.ratio))
}else{
    subset(my_data, confirmed.population.ratio > 1, 
           select=c(country, confirmed.population.ratio))
  }







