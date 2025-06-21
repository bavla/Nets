# Sunbelt 2025 Workshop 
# Analysis of weighted networks
# part 2
# by Vladimir Batagelj
# Paris, June 24, 2025
# https://github.com/bavla/Nets/tree/master/ws



https://erasmus-plus.ec.europa.eu/resources-and-tools/factsheets-statistics-evaluations/statistics/data/learning-mobility-projects

> library(igraph)
> setwd("C:/Users/public/Sunbelt25")
> nWdir <- paste0("https://raw.githubusercontent.com/",
+  "bavla/Nets/refs/heads/master/netsWeight/")


https://raw.githubusercontent.com/bavla/Nets/refs/heads/master/netsWeight
/data/Learning-mobility-flows-since-2014.csv

> # setwd("C:/Users/vlado/DL/data/erasmus/flows")
> # F <- read.csv("Learning-mobility-flows-since-2014.csv")
> F <- read.csv(file=paste0(nWdir,"/data/Learning-mobility-flows-since-2014.csv"))
> str(F)
'data.frame':   1223 obs. of  4 variables:
 $ Category  : chr  "highcharts-hv9y537-3" "highcharts-hv9y537-4" "highcharts-hv9y537-5" "highcharts-hv9y537-6" ...
 $ X..from.  : chr  "Austria" "Austria" "Austria" "Austria" ...
 $ X..to.    : chr  "Austria" "Belgium" "Bulgaria" "Croatia" ...
 $ X..weight.: int  8394 6825 603 2389 780 3808 3962 1104 7014 15250 ...
> L <- data.frame(from=F$X..from.,to=F$X..to.,weight=F$X..weight.)
> str(L)
'data.frame':   1223 obs. of  3 variables:
 $ from  : chr  "Austria" "Austria" "Austria" "Austria" ...
 $ to    : chr  "Austria" "Belgium" "Bulgaria" "Croatia" ...
 $ weight: int  8394 6825 603 2389 780 3808 3962 1104 7014 15250 ...
> names <- union(L$from,L$to)
> names
 [1] "Austria"        "Belgium"        "Bulgaria"       "Croatia"          
 [5] "Cyprus"         "Czechia"        "Denmark"        "Estonia"  
...
> C <- read.csv("ISO2.csv",strip.white=TRUE)
> str(C)
'data.frame':   35 obs. of  2 variables:
 $ country: chr  "Austria" "Belgium" "Bulgaria" "Croatia" ...
 $ ISO2   : chr  "AT" "BE" "BG" "HR" ...

> Pop <- read.csv("pop.csv",strip.white=TRUE)
> str(Pop)
'data.frame':   35 obs. of  3 variables:
 $ n      : int  1 2 3 4 5 6 7 8 9 10 ...
 $ country: chr  "Austria" "Belgium" "Bulgaria" "Croatia" ...
 $ pop    : num  9000000 11500000 6800000 4000000 1200000 10700000 5900000 1300000 5500000 68000000 ...
> V <- data.frame(name=C$country,ISO2=C$ISO2,pop=Pop$pop)
> N <- graph_from_data_frame(L,directed=TRUE,vertices=V)
> N$name <- "Erasmus learning mobility flows between countries 2014-2024"
> N$url <- "https://erasmus-plus.ec.europa.eu/resources-and-tools/factsheets-statistics-evaluations/statistics/data/learning-mobility-projects"
> N$by <- "Vladimir Batagelj"
> N$cdate <- date()
> N
IGRAPH 51f535d DNW- 35 1223 -- Erasmus learning mobility flows between countries 2014-20
+ attr: name (g/c), url (g/c), by (g/c), cdate (g/c), name (v/c), ISO2 (v/c),
| pop (v/n), weight (e/n)
+ edges from 51f535d (vertex names):
 [1] Austria->Austria       Austria->Belgium       Austria->Bulgaria       
+ ... omitted several edges
> saveRDS(N,file="ErasmusFlows.rds")




> wdir <- "C:/data/erasmus/flows"; setwd(wdir)
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> # N <- readRDS("ErasmusFlows.rds")
> N <- readRDS(file=url(paste0(nWdir,"/data/ErasmusFlows.rds")))
> Z <- P <- as_adjacency_matrix(N,attr="weight",type="both") 
> n <- nrow(P); w <- sort(P[P>0])
> hist(w,col="green",border="black",breaks=50,
+    xlab="value",main="Erasmus Flow Value Distribution")
> hist(w**0.1,col="green",border="black",breaks=20,prob=TRUE,
+    xlab="value^0.1",main="Erasmus Flow Value^0.1 Distribution")
> lines(density(w**0.1,n=64),lwd=2,col="blue")
> m <- mean(w**0.1); s <- sd(w**0.1)
> m
[1] 2.183272
> s
[1] 0.3881439
> curve(dnorm(x,m,s),from=1,to=3.5,lwd=2,col="red",xaxt="n",yaxt="n",
+    add=TRUE)
> b <- rep(0,11); b[11] <- max(w); Co <- P
> for(i in 1:10) b[i] <- w[round((-1+2*i)*length(w)/20)]
> for(i in 1:n) for(j in 1:n)
+  {k <- 1; while(P[i,j]>b[k]) k <- k+1; Co[i,j] <- k}
> b
 [1]  53  350  786  1327  2112  3178  4621  7323  13074  30142  217003
> hist(as.vector(Co),col="green",breaks=0:11)




> One <- kNeighbors(N,1)
> V(One)$ISO2 <- V(N)$ISO2; w <- 1+log(E(CoreG)$weight)
> lo <- layout_with_dh(One)
> plot(One,layout=lo,edge.width=w,vertex.color="pink",
+    vertex.size=10,vertex.label=V(One)$ISO2,vertex.label.cex=0.7)
> V(One)$x <- lo[,1]; V(One)$y <- lo[,2];
> saveRDS(One,file="EFone.rds")

> Two <- kNeighbors(N,2)
> V(Two)$ISO2 <- V(N)$ISO2
> lo <- layout_with_dh(Two)
> plot(Two,layout=lo,edge.width=w,vertex.color="pink",
+    vertex.size=10,vertex.label=V(Two)$ISO2,vertex.label.cex=0.7) 
> Pic <- tkplot(Two,800,800,layout=lo,edge.width=w,
+    vertex.label=V(Two)$ISO2,vertex.size=10,vertex.label.cex=0.7)
> # tkplot window is still active
> coor <- tk_coords(Pic,norm=FALSE)
> tk_close(Pic)
> V(Two)$x <- coor[,1]; V(Two)$y <- coor[,2]
> saveRDS(Two,file="EFtwo.rds")


> PF2 <- PathFinderSim(P,r=Inf,q=Inf,s=2)
> PF2net <- graph_from_adjacency_matrix(PF2,mode="directed",
+   weighted=TRUE)
> V(PF2net)$ISO2 <- V(N)$ISO2; w <- (1+log(E(PF2net)$weight))/3
> lo <- layout_with_dh(PF2net)
> plot(PF2net,layout=lo,edge.width=w,vertex.color="pink",
+    vertex.size=12,vertex.label=V(PF2net)$ISO2,vertex.label.cex=0.7)
> Pic <- tkplot(PF2net,800,800,layout=lo,edge.width=w,
+    vertex.label=V(PF2net)$ISO2,vertex.size=12,vertex.label.cex=0.7)
> # tkplot window is still active
> coor <- tk_coords(Pic,norm=FALSE)
> tk_close(Pic)
> V(PF2net)$x <- coor[,1]; V(PF2net)$y <- coor[,2]
> saveRDS(PF2net,file="EFpf2.rds")
> PF2net$name <- "Erasmus learning mobility flows between countries 2014-2024"
> PF2net$url <- "https://erasmus-plus.ec.europa.eu/resources-and-tools/factsheets-statistics-evaluations/statistics/data/learning-mobility-projects"
> PF2net$subnet <- "Pathfinder skeleton r=2"
> PF2net$by <- "Vladimir Batagelj"
> PF2net$cdate <- date()
> saveRDS(PF2net,file="EFpf2.rds")




> # setwd("C:/Users/vlado/DL/data/erasmus/flows")
> # EF <- readRDS("ErasmusFlows.rds")
> EF <- readRDS(file=url(paste0(nWdir,"/data/ErasmusFlows.rds")))
> wid <- strength(EF,mode="in",weights=E(EF)$weight,loops=TRUE)
> wod <- strength(EF,mode="out",weights=E(EF)$weight,loops=TRUE)
> EFcoresA <- cores(EF,p=p_wdeg,mode="all",loops=TRUE)
> EFcoresI <- cores(EF,p=p_wdeg,mode="in",loops=TRUE)
> EFcoresO <- cores(EF,p=p_wdeg,mode="out",loops=TRUE)
> rep <- data.frame(ISO2=V(EF)$ISO2,wid=wid,wod=wod,
+   Acores=EFcoresA,Icores=EFcoresI,Ocores=EFcoresO)
> names(EFcoresA) <- V(EF)$ISO2
> top(EFcoresA,vcount(EF))

> Rnet <- "https://raw.githubusercontent.com/bavla/Rnet/master/R/"
> source(paste0(Rnet,"ClusNet.R"))
> oa <- order(EFcoresA,decreasing=TRUE)
> ca <- coreDendro(V(EF)$ISO2[oa],EFcoresA[oa])
> ha <- ca$height; ca$height <- max(unname(EFcoresA))-ca$value
> plot(ca,main="Erasmus mobility Ps cores / All",cex=0.8)
> rep
> top(EFcoresA,vcount(EF))
   name  value
1    ES 652287
2    IT 652287




> library(gplots); source("ClusNet.R"); library(Matrix)
> N <- readRDS("ErasmusFlows.rds")
> P <- as.matrix(as_adjacency_matrix(N,attr="weight",type="both")) 


> library(gplots); source("ClusNet.R"); library(Matrix)
> N <- readRDS("ErasmusFlows.rds")
> P <- as.matrix(as_adjacency_matrix(N,attr="weight",type="both")) 
> Co <- P; Co[P == 0] <- NA
> par(cex.main=1.2)
> heatmap.2(Co,Rowv=FALSE,Colv="Rowv",
+    dendrogram="none",scale="none",revC=TRUE,
+    margins=c(8,8),cexRow=0.8,cexCol=0.8,
+    col=colorpanel(30,low="grey95",high="black"),na.color="yellow",      
+    trace="none", density.info="none", keysize=0.8, symkey=FALSE,
+    main="Erasmus flows")



> P <- as.matrix(as_adjacency_matrix(N,attr="weight",type="both")) 
> n <- nrow(P); Z <- Co <- P; w <- sort(P[P>0])
> for(u in 1:n) for(v in 1:n) Z[u,v] <- P[u,v]**0.1
> t <- hclust(1-as.dist((CorSalton(Z)+CorSalton(t(Z)))/2),method="ward.D") 
> t$merge <- flip(18,flip(7,flip(20,flip(30,flip(33,t$merge)))))
> t$merge <- flip(24,flip(28,flip(19,flip(4,t$merge))))
> b <- rep(0,11); b[11] <- max(w)
> for(i in 1:10) b[i] <- w[round((-1+2*i)*length(w)/20)]
> for(i in 1:n) for(j in 1:n)
+  {k <- 1; while(P[i,j]>b[k]) k <- k+1; Co[i,j] <- k}
> hist(as.vector(Co),col="green",breaks=0:11)
> Co[P==0] <- NA; par(cex.main=0.9)
> heatmap.2(Co,Rowv=as.dendrogram(t),Colv="Rowv",
+    dendrogram="column",scale="none",revC=TRUE,
+    margins=c(8,8),cexRow=0.8,cexCol=0.8,
+    col=colorpanel(30,low="grey95",high="black"),na.color="yellow",      
+    trace="none", density.info="none", keysize=0.8, symkey=FALSE,
+    main="Erasmus flows V^0.1 2014-2024 / Salton / Ward")
> Z <- Balassa(as.matrix(P))
> t <- hclust(as.dist((CorEu(Z)+CorEu(t(Z)))/2),method="ward.D")
> # pdf(file="EF14bala.pdf",width=30,height=30); par(cex.main=3)
> Z[P == 0] <- NA; par(cex.main=0.9)  
> heatmap.2(Z,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+    scale="none",revC=TRUE,col=bluered(100),na.color="yellow",
+    trace="none", density.info="none", keysize=0.8, symkey=FALSE,
+    # margins=c(15,15),cexRow=2,cexCol=2,
+    margins=c(8,8),cexRow=0.8,cexCol=0.8,
+    main="Erasmus flows 2014-2024 / Balassa / Ward")
> # dev.off()


> hm <- function(){par(cex.main=0.9)
+  heatmap.2(Z,Rowv=as.dendrogram(t),Colv="Rowv",
+   dendrogram="column",scale="none",revC=TRUE,
+   margins=c(8,8),cexRow=0.8,cexCol=0.8,
+   col=colorpanel(30,low="grey95",high="black"),na.color="yellow",      
+   trace="none", density.info="none", keysize=0.8, symkey=FALSE,
+   main="Erasmus flows V^0.1 2014-2024 / Salton / Ward")
+ }
> for(u in 1:n) for(v in 1:n) Z[u,v] <- P[u,v]**0.1
> t <- hclust(1-as.dist((CorSalton(Z)+CorSalton(t(Z)))/2),method="ward.D")
> Z[P == 0] <- NA
> s <- t; hm()
> F <- toFather(t$merge); N <- rownames(Z); n <- length(N)
> minCl(which(N=="Italy"),which(N=="Liechtenstein"),F) - n
[1] 33
> t$merge <- flip(33,t$merge); hm()
> minCl(which(N=="Italy"),which(N=="Luxembourg"),F) - n
[1] 30
> t$merge <- flip(30,t$merge); hm()
> minCl(which(N=="Iceland"),which(N=="Sweden"),F) - n
[1] 20
> t$merge <- flip(20,t$merge); hm()
  . . . . .
> t <- s
> t$merge <- flip(18,flip(7,flip(20,flip(30,flip(33,t$merge)))))
> t$merge <- flip(24,flip(28,flip(19,flip(4,t$merge)))); hm()


> BlockModel <- function(P,q,p,lab){
+   m <- length(table(p))
+   B <- matrix(0,nrow=m,ncol=m); rownames(B) <- colnames(B) <- lab
+   for(i in 1:m){I <- q[p==i]
+     for(j in 1:m){J <- q[p==j]; B[i,j] <- sum(P[I,J])} } 
+   return(B)
+ }
> q <- clOrder(t$merge,34)
> p <- c(rep(1,11),rep(2,8),rep(3,2),rep(4,7),rep(5,7))
> lab <- c("Less","Balkan","LieLux","High","Center")
> B <- BlockModel(P,q,p,lab)
> BB <- Balassa(B)
> BC <- apply(BB,1:2,function(x) min(2.5,max(-2.5,x)))
> heatmap.2(BC,Rowv=FALSE,Colv="Rowv",
+    dendrogram="none",scale="none",revC=FALSE,
+    margins=c(8,8),cexRow=1.5,cexCol=1.5,
+    col=bluered(100),na.color="yellow",      
+    trace="none", density.info="none", keysize=0.8, symkey=FALSE,
+    main=paste("Erasmus flows blockmodel",sep=""))
> t$labels[q[p==1]]
[1] "Greece"         "Portugal"          "Poland"         "Slovakia"         
[5] "Czechia"        "Hungary"           "Latvia"         "Lithuania"        
[9] "Estonia"        "Rest of the world" "Malta"            
> t$labels[q[p==2]]
[1] "Slovenia"        "Croatia"         "North Macedonia" "Serbia"          "Bulgaria"       
[6] "Romania"         "Cyprus"          "Türkiye"        
> t$labels[q[p==3]]
[1] "Liechtenstein" "Luxembourg"   
> t$labels[q[p==4]]
[1] "Iceland"        "Denmark"        "Norway"         "Sweden"         "Finland"       
[6] "Netherlands"    "United Kingdom"
> t$labels[q[p==5]]
[1] "Ireland" "Belgium" "France"  "Austria" "Germany" "Italy"   "Spain"  




