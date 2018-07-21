##Sys.setenv(JAVA_HOME='C:\\Program Files (x86)\\Java\\jre1.8.0_171')
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_171')
##install.packages('rJava')

library(NLP)
library(tm)
library(RColorBrewer)
library(wordcloud)
library(ggplot2)
#library(dplyr)
library(data.table)
library(rJava)
library(RWeka)
library(SnowballC)


setwd('E:/RProjects')

promoters <- Corpus(DirSource("E://Rprojects//Promoters"))

promoters <- tm_map(promoters, stripWhitespace)
promoters <- tm_map(promoters, tolower)
promoters <- tm_map(promoters, removeWords,stopwords("english"))
promoters <- tm_map(promoters, removeWords, c("was"))
promoters <- tm_map(promoters, removePunctuation)
promoters <- tm_map(promoters, PlainTextDocument)

tokPromote <- function(x) NGramTokenizer(x, Weka_control(min=2, max=3))
tdmPromote <- TermDocumentMatrix(promoters,control = list(tokenize = tokPromote))
termFreqPromote <- rowSums(as.matrix(tdmPromote))
termFreqVectorPromote <- as.list(termFreqPromote)

promoters2 <- data.frame(unlist(termFreqVectorPromote), stringsAsFactors = FALSE)
setDT(promoters2, keep.rowname =TRUE)
setnames(promoters2, 1, "term")
setnames(promoters2, 2, "freq")
promoters3 <- head(arrange(promoters2,desc(freq)), n =30 )
promoters3$npstype <- "Promoters"

##Detractors script
Detractors <- Corpus(DirSource("E://Rprojects//Detractors"))

Detractors <- tm_map(Detractors, stripWhitespace)
Detractors <- tm_map(Detractors, tolower)
Detractors <- tm_map(Detractors, removeWords,stopwords("english"))
Detractors <- tm_map(Detractors, removeWords, c("was"))
Detractors <- tm_map(Detractors, removePunctuation)
Detractors <- tm_map(Detractors, PlainTextDocument)

tokPromote <- function(x) NGramTokenizer(x, Weka_control(min=2, max=3))
tdmPromote <- TermDocumentMatrix(Detractors,control = list(tokenize = tokPromote))
termFreqPromote <- rowSums(as.matrix(tdmPromote))
termFreqVectorPromote <- as.list(termFreqPromote)

Detractors2 <- data.frame(unlist(termFreqVectorPromote), stringsAsFactors = FALSE)
setDT(Detractors2, keep.rowname =TRUE)
setnames(Detractors2, 1, "term")
setnames(Detractors2, 2, "freq")
Detractors3 <- head(arrange(Detractors2,desc(freq)), n =30 )
Detractors3$npstype <- "Detractors"

#Merge datasets into one
NPSdata <- rbind(Detractors3,promoters3)

##Output
ggplot(data=promoters3, aes(x=reorder(term,freq), y=freq)) +
  geom_bar(stat="identity",fill="#00FF00", colour="black") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + coord_flip() + ggtitle("Promoter NPS")

ggplot(data=Detractors3, aes(x=reorder(term,freq), y=freq)) +
  geom_bar(stat="identity",fill="#FF9999", colour="black") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + coord_flip() + ggtitle("Detractor NPS")

set.seed(1234)
wordcloud(words = NPSdata$term, freq = NPSdata$freq, min.freq = 1,
          max.words=250, random.order=FALSE, rot.per=0.35,
          ordered.colors=TRUE,
          colors=brewer.pal(3, "Set1")[factor(NPSdata$npstype)])
          #display.brewer.pal(3, "Set1")
          