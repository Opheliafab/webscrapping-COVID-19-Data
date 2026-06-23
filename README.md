PROJECT NAME:

WEBSCRAPPING OF A COVID-19 WEBPAGE FOR DATA ANALYSIS

ABOUT THE PROJECT:

In this project, I extracted data from this webpage 'https://en.wikipedia.org/w/index.php?title=Template:COVID-19_testing_by_country', and performed several data analytic processes on it to gain insights about the data.
The webpage I analysed holds COVID-19 Statistics recorded by country for 172 countries with data for each column showing the country, date, total number of tested persons, confirmed cases, confirmed tested ratio, tested population ratio and confirmed population ratio. 

TASKS PERFORMED:

1) Webscrapped a COVID-19 pandemic Wiki page using HTTP request
   
2) Extracted COVID-19 testing data table from the wiki HTML page
 
3) Pre-processed and exported the extracted data frame:
   
   During the pre-process phase, I wrote a function to perform the following analytical exercises:

   i) Removed the "world" row
   
   ii) Removed the last row
   
   iii) Removed "Units" and "Ref" columns
   
   iv) Renamed the columns
   
   v) Converted the following columns to factor data type: "country", "date"
   
   vi) Converted the followind columns to numeric data type: "tested", "confirmed", "confirmed.tested.ratio", "tested.population.ratio", "confirmed.population.ratio".
  
4) Retrieved a subset of the extracted data frame
   
5) Calculated worldwide COVID testing positive ratio
   
6) Identified country names with a specific pattern using regular expression
   
7) Reviewed the testing data of the United States and the United Kingdom 
 
8) Compare which one of the selected countries has a larger ratio of confirmed cases to population which would indicate that the country has a higher COVID-19 infection risk
   
9) Find countries with confirmed cases to population ratio rate less than 1%

PACKAGES USED:

1)RVEST

2)HTTR

KEY INSIGHTS:

1) The WorldWide ratio of confirmed cases to tested cases is 0.0799414520197323 which indicates that not a lot of persons tested positive to COVID-19 compared to the number of tested persons
   
2) The United States had a lower ratio of confirmed cases to population at 27.4 than the United Kingdom which had 32.9 meaning that the United Kingdom was at a higher risk than the United States.
 
3) With the exception of China, Japan and South Korea, majority of the other countries with less than 15 of confirmed cases to population ratio are third world countries like Afghanistan, Nigeria, Tanzania, etc. Of course this may also be due to other factors such as limited testing or under-reporting of figures in these countries.  
