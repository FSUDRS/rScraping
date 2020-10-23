# set to whatever file path you intend to use for your project!
setwd("~/Documents/presentations/Workshops/discoverdh/F2020/rScraping/")

# call in the httr and rvest packages (you need to install them first!)
library(httr)
library(rvest)

# read the html file at the following url and store it in a variable called "poemcollection"
poemcollection <- read_html("https://fsudrs.github.io/soseki/collections")

# find all of the table data with the class "wtitle" and store it in a variable called "poemtitles"
poemtitles <- poemcollection%>%html_nodes("td.wtitle")%>%html_text()

# find all the table data with the class "wdate" and store it in a variable called "poemdates"
poemdates <- poemcollection%>%html_nodes("td.wdate")%>%html_text()

# find all of the attribute values for @href on a and store them in "poemlinks"
poemurls <- poemcollection%>%html_nodes("td.wtitle")%>%html_node("a")%>%html_attr("href")

# write all of these urls to a file called poemurls.txt
write(poemurls, file="poemurls.txt", sep="\n", append = TRUE)

# store the baseurl for the site in a variable called baseurl
baseurl <- "https://fsudrs.github.io"

# create a "for" loop to iterate across each of the urls in poemlinks
fullurls <- list()
for(i in 1:length(poemurls)) {
  fullurls[i] <- paste(baseurl, poemurls[i], sep = "")
}
fullurls <- unlist(fullurls)

indivPoem <- read_html(fullurls[1])
# get the script that contains the link to the poem
ceteijs <- indivPoem%>%html_nodes("div#content")%>%html_node("script:nth-child(3)")%>%html_text
