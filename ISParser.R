library("XML")
library("xlsx")
library("CSS")

name_of_file <- readline("type in the name of html file without .html: ")

file_name <- paste(name_of_file, ".html", sep="")

i_doc <- htmlParse(file_name, encoding="UTF-8")

i_root <- xmlRoot(i_doc)

time <- cssApply(l_doc, ".pgmiDateHeader", cssCharacter)

url <- cssApply(l_doc, ".pgmiImageLink", cssLink)

re_url <- paste("http://www.instagram.com", url, sep="")

like_and_comment <- xpathSApply(i_root, "//div[@class='PhotoGridMediaItem']", xmlGetAttr, "aria-label")

like_and_comment_table <- read.table(textConnection(like))

likes <- like_and_comment_table[,1]

comments <- like_and_comment_table[,3]

final <- cbind(time, likes, comments, re_url)

renamed_file <- paste("done", name_of_file, sep="_")

xlsx_file <- paste(renamed_file, ".xlsx", sep="")

write.xlsx(final, xlsx_file)
