library(igraph)

find_numbers <- function (dfA, dfB) {
  a <- unlist(strsplit(as.character(dfA), ';'))
  b <- unlist(strsplit(as.character(dfB), ';'))
  return(length(intersect(a, b)))
}

find_relations <- function(fA) {
  relations = data.frame(from=character(), to=character(), weight=numeric(), stringsAsFactors = FALSE)
  for (i in (1:length(dat$Ids))) {
    for (j in (1:length(dat$Ids))) {
      if (j > i) {
        rels = find_numbers(dat$Ids[i], dat$Ids[j])
        if (rels > 0) {
          newVertex <- data.frame(from=dat$Titles[i],to=dat$Titles[j],weight=rels)
          relations <- rbind(relations, newVertex)
        }
      }
    }
  }
  return(relations)
}

plot_diagram <- function (df_relations , fname) {
  png(fname, width=1080, height = 1080, units = 'px')
  
  # Load (DIRECTED) graph from data frame 
  g <- graph.data.frame(df_relations, directed = FALSE)
  
  # Plot graph
  plot(g, edge.width=E(g)$weight)
  dev.off()
}

h<-read.csv('/Users/iain/Desktop/quanthum/characters.csv', header = FALSE, fill = TRUE,stringsAsFactors = FALSE)

dat <- data.frame(Titles=h$V1, Ids=h$V2)

rel <- find_relations(dat)

plot_diagram(rel, '/Users/iain/Desktop/quanthum/standardnames.png')

dat <- data.frame(Titles=h$V1, Ids=h$V3)

rel <- find_relations(dat)

plot_diagram(rel, '/Users/iain/Desktop/quanthum/variancesnames.png')

dat <- data.frame(Titles=h$V1, Ids=h$V4)

rel <- find_relations(dat)

plot_diagram(rel, '/Users/iain/Desktop/quanthum/actorids.png')