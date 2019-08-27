library(igraph)

#todo: colors for type of relations. (Parent as red & child as blue?)
#edge.col <- V(net)$color[edge.start]
#plot(net, edge.color=edge.col, edge.curved=.1)
status_levels <- c("ancestor", "same", "descendent")
status_colors <- c("#00B050", "#FFC000", "#C00000")

find_numbers <- function (dfA, dfB) {
  a <- unlist(strsplit(as.character(dfA), ';'))
  b <- unlist(strsplit(as.character(dfB), ';'))
  return(length(intersect(a, b)))
}

#todo: break this up into smaller functions
find_relations <- function(fA) {
  generation <- 30
  relations = data.frame(from=character(), to=character(), weight=numeric(), linktype=character(), alpha = numeric(), stringsAsFactors = FALSE)
  for (i in (1:length(dat$Ids))) {
    for (j in (1:length(dat$Ids))) {
      # remove self referential links
      # j > i to not count links that already counted
      if (j > i  && dat$Ids[i] != dat$Ids[j]) {
        #contentious. Henry4 and Richard2 born in same year but H4 dies after R2. 
        # How to handle?
        # Death constraint:  && dat$end[i] == dat$end[j]
        datediff <- (dat$start[i] - dat$start[j])
        if (datediff < 0) {
          rels = find_numbers(dat$Ids[i], dat$Ids[j])
          if (rels > 0) {
            newVertex <- data.frame(from=dat$Titles[i],to=dat$Titles[j],weight=rels, linktype="#00B050", alpha=1 / datediff %% generation )
            relations <- rbind(relations, newVertex)
          }
        }
        else if (datediff < generation ) {
        rels = find_numbers(dat$Ids[i], dat$Ids[j])
        if (rels > 0) {
          newVertex <- data.frame(from=dat$Titles[i],to=dat$Titles[j],weight=rels, linktype="#FFC000", alpha=1)
          relations <- rbind(relations, newVertex)
        }
        }
        else if (datediff >= generation && datediff < 500) {
          # Cap of 150 years to limit 
          rels = find_numbers(dat$Ids[i], dat$Ids[j])
          if (rels > 0) {
            newVertex <- data.frame(from=dat$Titles[i],to=dat$Titles[j],weight=rels, linktype="#C00000", alpha= 1 / datediff %% generation)
            relations <- rbind(relations, newVertex)
          }
        }
      }
    }
  }
  return(relations)
}

plot_diagram <- function (df_relations , fname) {
  png(fname, width=1080, height = 1080, units = 'px')
  
  g <- graph.data.frame(df_relations, directed = TRUE)
  
  # Plot graph
  plot(g, edge.width=E(g)$weight, edge.color=E(g)$linktype, edge.alpha=E(g)$alpha)
  legend("topleft",
         status_levels,
         fill=status_colors
  )
   dev.off()
}

h<-read.csv('/Users/iain/git/quanthum/characters.csv', header = FALSE, fill = TRUE,stringsAsFactors = FALSE)

#filter by the history plays.
h1 <- h[which (h$V1 %in% c('F-r2', 'F-1h4', 'F-2h4', 'F-h5', 'F-1h6', 'F-2h6', 'F-3h6', 'F-r3', 'F-h8', 'F-jc')),]

dat <- data.frame(Titles=h1$V1, Ids=h1$V2, start=h1$V5, end=h1$V6)

rel <- find_relations(dat)

plot_diagram(rel, '/Users/iain/git/quanthum/standardnames.png')
#plot_diagram(rel, '/Users/iain/git/quanthum/variancesnames.png')
#plot_diagram(rel, '/Users/iain/git/quanthum/actorids.png')