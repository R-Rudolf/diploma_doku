# Clear environment variables
rm(list=ls())
install.packages("pastecs")

require(pastecs)
library(plyr)
require(calibrate)

# CHeck for installed package:
# any(grepl("<name of your package>",
# installed.packages()))
to_asn_number = 96
from_asn:number = 64

no_jitter_count = 4181
no_delay_count = 12
no_rtt_count = 0
route_measure_count = 30792

# Handle working directory
getwd()
setwd("C:/cygwin64/home/rudolf/Diploma/results")

# Import data
input_file <- "link_ends.csv"

links <- read.csv(file=input_file,head=TRUE,sep=",")
last_links  <- read.csv(file=input_file,head=TRUE,sep=",")

name = "rtt"

# Convert to numeric
rtt_orig = as.numeric(unlist(links[name]))
rtt_orig = sort(rtt_orig)

quantile(rtt_orig)

part = 0.9
from = floor(length(rtt_orig)*(1-part)/2)
until = floor(length(rtt_orig)*(1-(1-part)/2))
rtt = rtt_orig[from:until]

rtt = Filter(function(x) x>0 && x<400, rtt_orig)
rtt = rtt_orig

mean(rtt)

outliers = length(rtt_orig) - length(rtt)

100 * (outliers / length(rtt_orig))

rtt_density = density(rtt)
rtt_y_lim = max(rtt_density$y)
hist(rtt, freq=FALSE,
     breaks=20,
     #ylim=c(0, rtt_y_lim),
     xlab=paste(name, " (ms)"),
     main=paste("Histogram of link ", name),
     probability = TRUE)
lines(rtt_density, col="darkgrey", lwd=2)
plot(rtt_density, col="darkgrey", lwd=2,
     xlab=paste(name, " (ms)"),
     main=paste("Histogram of link ", name))

maximas = get_turnpoints(rtt_density, 3)
points(maximas$x,maximas$y,col="black", pch=16)
text(maximas$x, maximas$y, labels=maximas$name, cex= 1.0, pos=4)


plot(rtt_density, col="chartreuse3", lwd=2)


curve(dnorm(x, mean=mean(rtt), sd=sd(rtt)), add=T, col="chartreuse", lwd=2)


get_turnpoints <- function(data, num_of_max){
  tp<-turnpoints(data$y)
  all_maxima = {}
  all_maxima$x = data$x[tp$tppos]
  all_maxima$y = data$y[tp$tppos]
  all_maxima$name = sprintf("%.3f", all_maxima$x)
  
  tmp = all_maxima$y
  tmp = sort(tmp, decreasing = TRUE)
  limit = tmp[num_of_max]
  
  maximas = {}
  maximas$x <- vector("list", num_of_max)
  maximas$y <- vector("list", num_of_max)
  maximas$name <- vector("list", num_of_max)
  j <- 1
  for (i in  1:length(all_maxima$y)){
    if (all_maxima$y[i] >= limit){
      maximas$x[j] = all_maxima$x[i]
      maximas$y[j] = all_maxima$y[i]
      maximas$name[j] = all_maxima$name[i]
      j <- j + 1
    }
  }
  return(maximas)
}


#x<-quantile(rtt_orig,c(0.01,0.99))
#data_clean = subset(rtt_orig >= x[1] & rtt_orig <= x[2])

#lowko["length"] <- replace(lowko["length"], TRUE, as.numeric(lowko["length"]))

curve(dnorm(x, mean=mean(rtt), sd=sd(rtt)), add=T, col="darkblue", lwd=2)
lines(density(rtt))
#max(density(vid_len))
steps = (max(rtt) - min(rtt))/80
hist(rtt, freq=FALSE, breaks=c(min(rtt), seq(steps,max(rtt)+steps, steps)), xlab="rtt (ms)")
mean(rtt)/60
sd(rtt)/60
# leghosszabb video: 2 ora 7 perc
#H legrovidebb video: fel perc
min(rtt)

# Make histogram about video length


# Make histgram about video likes

# Make correlation about likes and length

# Make bar chart about released videos per month

# Make histogram about pauses between video releases

# Make graph about likes/video as time goes

# Make graph about dislikes/video as time goes

# Make chart about most used words in titles

# Make chart about most used words in titles per playlist

# Order words used in video titles, which received the most like

# Order words used in video titles, which received the most dislike

# Make chart about playlist lifecycle as time goes.
# A playlist is active, when a new video is released in it

