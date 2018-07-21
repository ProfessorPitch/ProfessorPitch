#install.packages("ggplot2")
#install.packages("splitstackshape")
#install.packages("tidytext")

library(RODBC)
#--Create a data connection locally to a SQL Server

odbcChannel <- odbcConnect("SQLServer")

#Option 2  - Pull Query
res <- sqlQuery(odbcChannel, "select top 100 * from prod.dbo.customersurveys")
res
#Start Split of text
#Make sure your columns are explicit because it is case sensitive
library(splitstackshape)
CareData <- cSplit(res,"Notes", sep =" ", direction = "long")
#this is where you can create more special character separators
CareData <- cSplit(CareData,"Notes",sep="/",direction = "long")
CareData

names(CareData) <- c("surveyDate","customerID","reasonCode","word")

#-Cleaning special characters
#DF$[Name] adds column
CareData$word <- gsub(",$", "",CareData$word)
CareData$word <- gsub(":", "",CareData$word, fixed=TRUE)

library(dplyr)
library(tidytext)

#data(stop_words)
#show most common words
tail(names(sort(table(CareData$word))),10)

#Test Sentiments lists
  #sentiments
  #get_sentiments("bing") #"nrc" & "afinn"

#Convert to tibble
CareTibble <- as_data_frame(CareData)
class(CareTibble)
CareTibble

#Join DF to Bing sentiment
CareTibbleBing <- CareTibble %>%
  inner_join(get_sentiments("bing"))

#?dplyr:count browseVignettes(package = "dplyr")
#Count by word sentiment
CareTibCount <- CareTibbleBing %>% count(reasonCode,word,sentiment,sort = TRUE)

#bar chart
library(ggplot2)
  #group by crmreasonone
CareTibCount %>%
  group_by(sentiment) %>%
  top_n(25) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(reasonCode, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(y = "Contribution to sentiment",
       x = NULL) +
  coord_flip()

#Word Cloud
library(wordcloud)
library(reshape2)

CareTibbleBing <-CareTibbleBing %>%
  with(CareTibbleBing, !(word =="issue"))

#Basic Wordcloud
CareTibbleBing %>%
  with(CareTibbleBing, !(word =="issue"))%>%
  anti_join (stop_words) %>%
  count(word) %>%
  with (wordcloud(word, n, max.words = 100))


#Wordcloud group +-
CareTibbleBing %>%
  count(word, sentiment, sort=TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("#F8766D","#00BFC4"),
                   max.words = 100)


#aggregate(CareTibCount$n, by=list(Category=CareTibCount$crmReasonOne,Sentiment=CareTibCount$sentiment), FUN=sum,
 #         negative.rm=TRUE)







