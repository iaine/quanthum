# Script to run PCA 
library(ggplot2)

find_numbers <- function (dfA, dfB) {
  a <- unlist(strsplit(as.character(dfA), ';'))
  b <- unlist(strsplit(as.character(dfB), ';'))
  return(length(intersect(a, b)))
}

h<-read.csv('/Users/iain/Desktop/quanthum/characters.csv', header = F)

dat <- data.frame(Titles=h$V1, Ids=h$V3)

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

PCa<-prcomp(rela[1:3])
PCia<-data.frame(PCa$x, Titles=rela$play)

ggplot(PCia,aes(x=PC2,y=PC3, col=Titles))+
  geom_point(size=1,alpha=0.5) +
  facet_wrap(~ Titles)
