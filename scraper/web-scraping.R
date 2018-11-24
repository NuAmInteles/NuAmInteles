install.packages('rvest')
install.packages('stringi')


library(rvest)
library(stringi)

#Specifying the url for desired website to be scrapped
url <- 'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'


url <- paste("http://proverbe.citatepedia.ro/din.php?p=",2,"&d=proverbe+rom%E2ne%BAti", sep="",collapse = "")

#Reading the HTML code from the website
webpage <- read_html(url)

proverbe_html <- html_nodes(webpage,'.pq')

#Converting the ranking data to text
proverbe <- html_text(proverbe_html)

proverbe_vec <- vector()
for(i in 1:400){
  url <- paste("http://proverbe.citatepedia.ro/din.php?p=",i,"&d=proverbe+rom%E2ne%BAti", sep="",collapse = "")
  # read_html(iconv(page_source[[1]], to="UTF-8"), encoding = "utf8")
  webpage <- read_html(url,encoding = "windows-1250")
  proverbe_html <- html_nodes(webpage,'.pq')
  proverbe <- html_text(proverbe_html)
  proverbe_vec <- c(proverbe_vec,proverbe)
}

saveRDS(proverbe_vec, file = "proverbe_vec.Rds")
write.csv(proverbe_vec, file = "proverbe_vec.csv")

# write(enc2utf8(proverbe_vec), file = "proverbe.txt")
# 
# stri_enc_toutf8(proverbe_vec)
# 
# string <- "<U+0102><U+0103><U+00C2><U+00E2><U+00CE><U+00EE><U+0218><U+0219><U+021A><U+021b>"
# 
# stri_unescape_unicode(gsub("<U\\+(....)>", "\\\\u\\1", proverbe_vec[3]))
# 
# 
