# Clear environment variables
rm(list=ls())

# CHeck for installed package:
# any(grepl("<name of your package>",
# installed.packages()))
to_asn_number = 96
from_asn:number = 64

# Handle working directory
getwd()
setwd("D:/Aktual/TDK/results/last")

# Import data
input_file <- "link_ends.csv"
input_file <- "ttl_icmp.csv"
input_file <- "ping.csv"
input_file <- "port80.csv"
input_file <- "GeoLite2-City-Blocks-IPv4.csv"



links <- read.csv(file=input_file,head=TRUE,sep=",")
name = "accuracy_radius"

# Convert to numeric
rtt_orig = as.numeric(unlist(links[name]))
rtt_orig = sort(rtt_orig)
rtt = rtt_orig

hist(rtt, freq=FALSE,
     breaks=20,
     xlab=paste(name, " (km)"),
     #ylim=c(0, max(density(rtt)$y)),
     main=paste("Histogram of location accuracy"),
     probability = TRUE)

lines(density(rtt), col="chartreuse3", lwd=2)
rtt_dens = density(rtt)
curve(dnorm(x, mean=mean(rtt), sd=sd(rtt)), add=T, col="chartreuse", lwd=2)
max(density(rtt)$y)
#x<-quantile(rtt_orig,c(0.01,0.99))
#data_clean = subset(rtt_orig >= x[1] & rtt_orig <= x[2])

#lowko["length"] <- replace(lowko["length"], TRUE, as.numeric(lowko["length"]))

curve(dnorm(x, mean=mean(rtt), sd=sd(rtt)), add=T, col="darkblue", lwd=2)
lines(density(rtt))
#max(density(vid_len))
steps = (max(rtt) - min(rtt))/80
hist(rtt, freq=FALSE, breaks=c(min(rtt), seq(steps,max(rtt)+steps, steps)), xlab="rtt (ms)")


quantile(rtt_orig)

#print("Medián")
median(rtt_orig)
max(rtt_orig)
min(rtt_orig)

part = 1
from = floor(length(rtt_orig)*(1-part)/2)
until = floor(length(rtt_orig)*(1-(1-part)/2))
rtt = rtt_orig[from:until]

rtt = Filter(function(x) x>-50 && x<200, rtt_orig)
rtt = rtt_orig

outliers = length(rtt_orig) - length(rtt)

no_jitter_count = 4181
no_delay_count = 12
no_rtt_count = 0
last_node_measure_count = 30792

100 * (outliers / length(rtt_orig))



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

