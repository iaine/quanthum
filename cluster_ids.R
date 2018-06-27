

find_numbers <- function (dfA, dfB) {
  a <- unlist(strsplit(as.character(dfA), ';'))
  b <- unlist(strsplit(as.character(dfB), ';'))
  return(length(intersect(a, b)))
}

h<-read.csv('/Users/iain/Desktop/quanthum/characters.csv', header = F,  fill = TRUE)

dat <- data.frame(Titles=h$V1, Ids=h$V2)

rela = data.frame(numeric(), numeric(), numeric(), play=character())
for (i in (1:length(dat$Ids))) {
  for (j in (1:length(dat$Ids))) {
    if (j > i) {
      rels = find_numbers(dat$Ids[i], dat$Ids[j])
      if (rels > 0) {
        newV <- data.frame(as.numeric(dat$Titles[i]),as.numeric(dat$Titles[j]),rels, play=dat$Titles[i])
        rela <- rbind(rela, newV)
      }
    }
  }
}

x<-hclust(dist(rela[1:3]), method = "complete", members = NULL)

png('/Users/iain/Desktop/quanthum/cluster.png', width=10800, height = 1200, units = 'px')

plot(x, labels = rela$play, hang = 0.1, check = TRUE,
     axes = TRUE, frame.plot = FALSE, ann = TRUE,
     main = "Weight Cluster Dendrogram",
     sub = NULL, xlab = 'Plays', ylab = "Number")
dev.off()
