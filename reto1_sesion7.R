install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")
install.packages("ggplot2")
library(ggplot2)
library(DBI)
library(RMySQL)
library(dplyr)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)
DataDB <- dbGetQuery(MyDataBase, "Select * from CountryLanguage")
pop50.mex <- DataDB %>% filter(Language == "Spanish")
promedioEspañol <- mean(pop50.mex$Percentage)

library(ggplot2)

ggplot(pop50.mex, aes(x = CountryCode, y = Percentage)) + 
  ggtitle("Hablantes de español en el mundo") +
  xlab("Pais") +
  ylab("Porcentaje") +
  geom_col()+coord_flip()
