
install.packages("statnet", dependencies = TRUE) 
install.packages('igraph')
install.packages('visNetwork')
library(igraph)
library(statnet)

library('visNetwork') 
visNetwork(nodes, links, width="100%", height="400px", main="Network!")

setwd("D:/Aktual/TDK/results/last")


input_file <- "ip-graph-edges.csv"

links <- read.csv(file=input_file,head=TRUE,sep=",")
nodes_raw <- read.csv(file="ip-graph-nodes.csv",head=TRUE,sep=",")




# Convert to numeric
from_list = as.numeric(unlist(links["from"]))
to_list = as.numeric(unlist(links["to"]))
nodes <- read.csv(file="nodes.csv",head=TRUE,sep=",")

nodes = unique(c(to_list, from_list))
for(i in nodes){
  print(i)
}

net <- graph_from_data_frame(d=links, vertices = nodes_raw, directed=F) 

plot(net,vertex.label=NA, layout=my_layout(net))


E(net)$color<-ifelse(E(net)$grade==9, "red", "grey")

deg = degree(net, V(net), mode="all")

radius

vert = V(net)

net = simplify(net, remove.multiple = TRUE)

net <- as.undirected(net, mode= "collapse")

as_numbers = unique(nodes_raw$asn)
as_numbers = sort(as_numbers)

get_index <-function(as, as_numbers){
  for(i in 1:length(as_numbers)){
    if(as_numbers[i]==as){
      return(i)
    }
  }
}

# x[x[(0:length(x))] %% 2==0]
rainbowcols <- rainbow(length(as_numbers))
length(V(net))
length(nodes_raw$asn)
colors = rep(0, length(V(net)))
for(i in 1:length(colors)){
  if(is.na(nodes_raw$asn[i])){
    # Ismeretlen AS számú IP csomópontok színezése
    colors[i] <- rainbowcols[1]
  }else{
    colors[i] <- rainbowcols[get_index(nodes_raw$asn[i], as_numbers)]
  }
}
nodes_raw$ip$color <- rainbowcols[nodes_raw$asn]

plot(net,vertex.label="",  layout=my_layout(net))
l = my_layout(net)
install.packages('poweRlaw')
library(poweRlaw)

x = degree(net)

split.screen(c(1,2))
screen(1)
plot (tabulate(x), log = "xy", ylab = "Frequency (log scale)", xlab = "Degree (log scale)", main = "Log-log plot of degree distribution")
screen(2)
y <- (length(x) - rank(x, ties.method = "first"))/length(x)
plot(x, y, log = "xy", ylab = "Fraction with min. degree k (log scale)", xlab = "Degree (k) (log scale)", main = "Cumulative log-log plot of degree distribution")
close.screen(all = TRUE)
power.law.fit(x, xmin = 50)

occur = as.vector(table(x))
occur = occur/sum(occur)
p = occur/sum(occur)
y = rev(cumsum(rev(p)))
x = as.numeric(names(table(x)))
plot(x, y, log="xy", type="l")

lines(m, col=2)
my_layout <- function(net){
  
  # Alap informaciok kinyerese a halozatbol
  nodes = V(net)
  deg = degree(net)
  max_deg = max(deg)
  clust = cluster_louvain(net)
  memb = membership(clust)
  
  # klaszterek szogtartomanyokra osztasa
  group_start = get_group_start_indexes(memb)
  
  for(n in nodes){
    group = memb[n]
    # origotol valo tavolsag szamitasa
    radius = (max_deg - deg[n] + 1)/(max_deg + 1)
    # klaszterek alapjan valo csoportositas
    angle = step * ( group_start[group] + group_index[group] )
    group_index[group]  = group_index[group] + 1
    
    coord[n, 1] = radius * cos(angle)
    coord[n, 2] = radius * sin(angle)
  }
  
  return(coord)
}

get_group_start_indexes <- function(memb, nodes){
  group_number = max(memb)
  group_count = rep(0, group_number)
  group_start = rep(1, group_number)
  group_index = rep(0, group_number)
  step = 2*pi/length(nodes)
  coord = matrix(0,length(nodes), 2)
  for( i in 1:group_number){
    group_count[i] = sum(memb == i)
  }
  group = 1
  count = 1
  for(i in 1:length(nodes)){
    if(group_count[group] == count){
      group_start[group] = i
      group = group + 1
      count = 0
    }
    count = count + 1
  }
}

edges = E(net)

l = layout_with_fr(net)
l = layout_with_lgl(net)
plot(net,
     vertex.size=3,
     edge.width=1.4,
     vertex.label=NA,
     edge.curved=curve_multiple(net, start = 0.5),
     layout=l)

V(net)$size <- 8
V(net)$frame.color <- colors
V(net)$color <- colors
E(net)$color <- rgb(.3, .3, .3, alpha=.6)
#V(net)$label <- ""
E(net)$arrow.mode <- 0










l <- layout_in_circle(net)
plot(net, layout=l)

l <- layout_with_fr(net)
plot(net, layout=l, vertex.label.cex=0.5)

distances = distances(net,
          v = V(net),
          to = V(net),
          mode = "all",
          weights = NULL,
          algorithm = "dijkstra"
          )

hist(deg, freq=FALSE,
     breaks=20,
     xlab=paste("AS degree"),
     ylim=c(0, max(density(deg)$y)),
     main=paste("Histogram of AS degree"),
     probability = TRUE)

lines(density(deg), col="chartreuse3", lwd=2)


deg_dist <- degree_distribution(net, cumulative=T, mode="all")
plot( x=0:max(deg), y=deg_dist, pch=19, cex=1.2, col="orange", 
      xlab="Degree", ylab="Cumulative Frequency")


plot(net,
     vertex.shape="none",
     vertex.label=nodes,
     vertex.label.font=2, 
     vertex.label.cex=.6,
     edge.color="gray70", 
     edge.width=2)

#---------------------------------------------------
netw_matrix <- matrix(0, length(nodes), length(nodes))
netw_matrix[1][1] = 0
for (i in c(1, length(from_list))) {
  from = from_list[i]
  to = until_list[i]
  netw_matrix[from][to] = 1
}
#----------------------------------------



# plot a random graph, different color for each component
g <- sample_gnp(100, 1/100)
comps <- components(g)$membership
colbar <- rainbow(max(comps)+1)
V(g)$color <- colbar[comps+1]
plot(g, layout=layout_with_fr, vertex.size=5, vertex.label=NA)

# plot communities in a graph
g <- make_full_graph(5) %du% make_full_graph(5) %du% make_full_graph(5)
g <- add_edges(g, c(1,6, 1,11, 6,11))
com <- cluster_spinglass(g, spins=5)
V(g)$color <- com$membership+1
g <- set_graph_attr(g, "layout", layout_with_kk(g))
plot(g, vertex.label.dist=1.5)

# draw a bunch of trees, fix layout
igraph_options(plot.layout=layout_as_tree)
plot(make_tree(20, 2))
plot(make_tree(50, 3), vertex.size=3, vertex.label=NA)
tkplot(make_tree(50, 2, mode="undirected"), vertex.size=10,
       vertex.color="green")
