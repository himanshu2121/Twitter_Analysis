#packages we will need to install
install.packages("twitteR")
install.packages("RCurl")
install.packages("tm")
install.packages("wordcloud")
require(twitteR)
require(RCurl)
require(tm)
require(wordcloud)
library(twitteR)
apiKey<-"zJF7aaToCJmhJ3eIzir4IqVMl"
apiSecret<-"OMPAHkgPTRpGKLZAuPky5OXBtwy8dRw2Pyb3ZONVeNqVzeUa3z"
accesstoken<-"1031392976394694656-MQv6H0OIHj1T5RekIHVwfAIWLbS50W"

accesssecret<-"yyoZG1qOUDeQ8CxleWmvfjnLwuG9Q1sXQQbxA0PpGlqIU"

setup_twitter_oauth(apiKey,apiSecret,accesstoken,accesssecret)
himearth<-searchTwitter('rahul gandhi',lang = 'en',n = 50,resultType = "recent" )
str(himearth)
himearth[1:3]
#convert list to vector
himearth_text <- sapply(himearth, function(x) x$getText())
# sapply( ) returns a vector
himearth_text


#create corpus from vector to tweets
him_corpus <- Corpus(VectorSource(himearth_text))
him_corpus
inspect(him_corpus[1:3])

# lower cases, remove numbers, cut out stopwords, remove punctuation, strip whitespace
him_clean <- tm_map(him_corpus, removePunctuation)
him_clean <- tm_map(him_clean, content_transformer(tolower))
him_clean <- tm_map(him_clean, removeWords, stopwords("english"))
him_clean <- tm_map(him_clean, removeNumbers)
him_clean <- tm_map(him_clean, stripWhitespace)

wordcloud(him_clean)
inspect(him_clean[1])

#you may want to remove search words these will obviously be very frequent 
him_clean <- tm_map(him_clean, removeWords, c("datasets"))

#wordcloud, play with parameters
wordcloud(him_clean, random.order = F, max.words = 40, scale = c(3,0.5), colors = rainbow(50))
wordcloud(him_clean,random.order = F,scale = c(6,0.5))
wordcloud(him_clean,random.order = F,col = "red")
wordcloud(him_clean,random.order = F,max.words = 50, colors = rainbow(20))
install.packages("stringr")
###################################################



library(stringr)                      
# use this library

poswords <- scan("positive_w.txt",what = "character")  
# use scan function to make poswords object as a scanner

negwords <- scan("negative_w.txt",what = "character")  
# use scan function to make poswords object as a scanner


class(him_clean) 
# check the class 

data <- unlist(him_clean)
#make it in character using unlist command 

data

class(data)
#check weather it is in character or not

textbag<- str_split(data,pattern = "\\s+")
# split the character using str_split function 

textbag

class(textbag)

text_char <- unlist(textbag) 

match(text_char,poswords)
# now match the positive words from the text_char using match command 

is.na(match(text_char,poswords))
# check with boolean value for NA

!is.na(match(text_char,poswords))
#check with boolean value for not NA

sum(!is.na(match(text_char,poswords)))
# find the total number of positive words from the text_char

score <- sum(!is.na(match(text_char,poswords))) - sum(!is.na(match(text_char,negwords))) 
# find the sentiment score
print("the overall sentiment score")
score