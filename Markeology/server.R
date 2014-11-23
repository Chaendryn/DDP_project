require(shiny)
require(RCurl)
require(tm)
require(XML)
require(wordcloud)
require(RColorBrewer)

     






shinyServer(function(input, output) {
      output$dirname <- renderText({
            inName <- input$dirname
            
      })
      output$contents <- renderTable({
            
            # input$file1 will be NULL initially. After the user selects
            # and uploads a file, it will be a data frame with 'name',
            # 'size', 'type', and 'datapath' columns. The 'datapath'
            # column will contain the local filenames where the data can
            # be found.
            
            inFile <- input$file1
            
            if (is.null(inFile))
                  return(NULL)
            
            test <- data.frame("NA")
            
            ## reading in the file
            test <- as.data.frame(getHTMLLinks(inFile$datapath, externalOnly = TRUE, xpQuery = "//a/@href", 
                                               baseURL = docName(inFile$datapath), relative = FALSE), stringsAsFactors = FALSE)
            
            
            ## Cleaning up the bookmarks file
            lv <- grepl("http", test[,1], fixed = TRUE)
            test <- as.data.frame(test[lv,], stringsAsFactors = FALSE)
            lv <- grepl("https", test[,1], fixed = TRUE)
            test <- as.data.frame(test[lv == FALSE,], stringsAsFactors = FALSE)
            lv <- grepl(".pdf", test[,1], fixed = TRUE)
            test <<- as.data.frame(test[lv == FALSE,], stringsAsFactors = FALSE)
            
            ## Getting page data
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
            
            
            ## get file list
            htmlFiles <- list.files(pattern="\\.(htm|html)$")
            
            
            ## testing for empty list elements
            hl <- length(html.list)
            for (i in 1:hl) {
                  test <- html.list[i] == ""
                  if (test == TRUE) {
                        html.list[i] <- NULL
                  }
                  hl <- length(html.list)
                  i <- i + 1
                  
            }
            
            
            ## create HTML text vector list
            
            ## Evaluating the file and creating character vectors from them
            evaluate_input <- function(htmlFiles) {    
                  # if input is a .html file
                  if(file.exists(htmlFiles)) {
                        char.vec <- readLines(htmlFiles, warn = FALSE)
                        return(paste(char.vec, collapse = ""))
                  }
            } 
            
            
            html.list <- lapply(htmlFiles, evaluate_input)
            
            ## Convert HTML to plain text
            
            ## Stripping out HTML code
            convert_html_to_text <- function(html) {
                  doc <- htmlParse(html, asText = TRUE)
                  text <- xpathSApply(doc, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
                  return(text)
            }      
            
            
            collapse_text <- function(txt) {
                  return(paste(txt, collapse = " "))
            }
            
            text.list <- lapply(html.list, convert_html_to_text)
            
            
            
            ## return a text vector of all file content in the list
            html2txt <- sapply(text.list, collapse_text)
            
            ## removing non-ASCII characters
            html2txtclean <- sapply(html2txt, function(x) iconv(x, "latin1", "ASCII", sub=""))
            
            ## creating a corpus for text mining
            testCorpus <- VCorpus(VectorSource(html2txtclean))
            
            skipWords <- function(x) removeWords(x, stopwords("english")) 
            
            ## cleaning up the corpus
            testCorpus <- tm_map(testCorpus, content_transformer(tolower))
            testCorpus <- tm_map(testCorpus, content_transformer(removePunctuation))
            testCorpus <- tm_map(testCorpus, content_transformer(skipWords))
            testCorpus <- tm_map(testCorpus, content_transformer(removeNumbers))
            testCorpus <- tm_map(testCorpus, stripWhitespace)
            
            ## creating a TermDocumentMatrix for further manipulation
            t.dtm <- TermDocumentMatrix(testCorpus, control = list(wordLengths = c(4,15)))
            topFreqWords <- findFreqTerms(t.dtm, lowfreq=15)
            t.dtm2 <<- t.dtm[(t.dtm$dimnames$Terms) %in% topFreqWords,]
            
            names(test) <- "links" 
            head(test, 15)
            head(topFreqWords, 15)
            
            
      })
      
      output$plot1 <- renderPlot({
            
            library(wordcloud)
            library(RColorBrewer)
            wMatrix <- as.matrix(t(t.dtm2))
            word_freqs <- sort(colSums(wMatrix), decreasing=TRUE)
            dm <- data.frame(word=names(word_freqs), freq=word_freqs)
            plot1 <- wordcloud(dm$word[1:200], dm$freq, random.order=FALSE, colors=brewer.pal(12, "Paired"))
            
            
      })
})


## Helper functions



## Getting page data




     



