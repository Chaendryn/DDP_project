## Cleaning data and preparing a corpus for text mining
library(tm)
library(RCurl)
library(XML)

## Checking validity of URLS

robustURL <- function(fURL) {
      con.url <- try(url(fURL, open="r"))
      try.error <- inherits(con.url, "try-error")
      closeAllConnections()
      if (try.error == TRUE) {
            err <<- 1 
            print(paste("Unable to download data", fURL))
      } else {err <<- 0}
}

## Getting page data

getPageData2 <- function() {
      library(RCurl)
      library(XML)
      
      ##creating seperate directories for different users
      dirPath <- paste("./", inName, "_data", sep="", collapse = NULL)
      
      if(!file.exists(dirPath)) {
            dir.create(dirPath)
      }
      
      ## Creating a download log file.
      downloadLog <- write(c("Download Log"), file = paste(dirPath, "/", "downloadLog.txt", sep="", collapse = NULL))
      
      i <- 0
      
      for (i in 1:nrow(test)) {
            date <- Sys.Date()
            err <- 0
            fURL <- test[i,1]
            
            robustURL(fURL)
            
            if (err != 1) {
                  destName <- paste(dirPath, "/", inName, "_", "file", "_", i, "_", date, ".html", sep="", collapse = NULL)
                  download.file(fURL, destfile = destName)
                  logName <- paste("done_", fURL, "_", date, sep="", collapse = NULL)
                  downloadLog <- rbind(downloadLog, c(paste("Done - ", fURL, "destFile - ", destName)))
                  write(downloadLog, file = paste(dirPath, "/", "downloadLog.txt", sep="", collapse = NULL), sep="\n", append = TRUE)
                  i <- i + 1                   
            } else {
                  i <- i + 1
            }
            
            
      }
}


## Evaluating the file and creating character vectors from them
evaluate_input <- function(htmlFiles) {    
      # if input is a .html file
      if(file.exists(htmlFiles)) {
            char.vec <- readLines(htmlFiles, warn = FALSE)
            return(paste(char.vec, collapse = ""))
      }
}      

## Stripping out HTML code
convert_html_to_text <- function(html) {
      doc <- htmlParse(html, asText = TRUE)
      text <- xpathSApply(doc, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
      return(text)
}      
      

collapse_text <- function(txt) {
      return(paste(txt, collapse = " "))
}
      
skipWords <- function(x) removeWords(x, stopwords("english"))      
      




