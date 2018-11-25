# install.packages('rvest')
# install.packages('stringi')

library(rvest)
library(stringi)

setwd("/Users/florinalexandrescu/Desktop/nu-am-inteles-repo/nuaminteles/scraper")


#Specifying the url for desired website to be scrapped
url <- 'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'


url <- paste("http://proverbe.citatepedia.ro/din.php?p=",2,"&d=proverbe+rom%E2ne%BAti", sep="",collapse = "")

#Reading the HTML code from the website
webpage <- read_html(url)

proverbe_html <- html_nodes(webpage,'.pq')

#Converting the ranking data to text
proverbe <- html_text(proverbe_html)






proverbe_vec <- vector()
for(i in 1:500){
  url <- paste("http://proverbe.citatepedia.ro/din.php?p=",i,"&d=proverbe+rom%E2ne%BAti", sep="",collapse = "")
  # read_html(iconv(page_source[[1]], to="UTF-8"), encoding = "utf8")
  webpage <- read_html(url,encoding = "windows-1250")
  proverbe_html <- html_nodes(webpage,'.pq')
  proverbe <- html_text(proverbe_html)
  proverbe_vec <- c(proverbe_vec,proverbe)
  if (i%%10==0 ){
    print(paste(i,"/",500))
  }
}



url <- paste("https://ro.wikiquote.org/wiki/Proverbe_rom%C3%A2ne%C8%99ti", sep="",collapse = "")
# read_html(iconv(page_source[[1]], to="UTF-8"), encoding = "utf8")
webpage <- read_html(url)#,encoding = "windows-1250")
proverbe_html <- html_nodes(webpage,'li')
proverbe_1 <- html_text(proverbe_html)

proverbe_vec <- c(proverbe_vec,proverbe_1)


#writing to files 
saveRDS(proverbe_vec, file = "proverbe_vec.Rds")
write.csv(proverbe_vec, file = "proverbe_vec.csv")


