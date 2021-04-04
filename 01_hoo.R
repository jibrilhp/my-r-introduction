# install.packages("dplyr")
# install.packages(c("httr", "jsonlite"))
# install.packages("DBI")
# install.packages("odbc")
# install.packages("RPostgreSQL")
library(dplyr)
library(httr)
library(DBI)
library(odbc)
library(RPostgreSQL)

# r <- POST("https://jibs.my.id/api/jibs-iot/dashboard/update", body = list(title = "count_table_weather", result = 500))
odbc::odbcListDrivers()
# pgdrv <- dbDriver(drvName = "PostgreSQL Unicode")
con <- DBI::dbConnect(odbc::odbc(),
Driver = "PostgreSQL Unicode",
  database = "",
  UserName    = "postgres",
  Password    = "",
  host = "localhost",
  port = 5432)

weather_table <- dbGetQuery(con, "select * from weather.cilandak_weather")
count_table_weather <- nrow(weather_table)
body <- list(title = "count_table_weather", result = count_table_weather)
req <- POST("https://jibs.my.id/api/jibs-iot/dashboard/update", body =body)
