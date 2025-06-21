


> library(igraph)
> setwd("C:/Users/vlado/docs/papers/2025/Sunbelt/ws/R")
> nWdir <- paste0("https://raw.githubusercontent.com/",
+  "bavla/Nets/refs/heads/master/netsWeight/")
> V <- read.csv(paste0(nWdir,"nodes.csv"),sep="")
> L <- read.csv(paste0(nWdir,"links.csv"),sep="")
> V
> L
> N <- graph_from_data_frame(L,directed=TRUE,vertices=V)
> N
> V(N)$name <- V(N)$label
> N <- delete_vertex_attr(N,"label")
> E(N)$weight <- sample(1:7,ecount(N),replace=TRUE)
> N
> plot(N,edge.width=E(N)$weight)
> N$name <- "Network from data frame example"
> N$by <- "Vladimir Batagelj"
> N$cdate <- date()
> saveRDS(N,file="igraphDF.rds")

> nodes <- as_data_frame(N,what="vertices")
> links <- as_data_frame(N,what="edges")


> N <- readRDS(file="test1.rds")
> N
> V(N)[[]]
> E(N)[[]]
> w <- E(N)$weight; lab <- as.character(w)
> cur <- rep(0,ecount(N)); cur[c(2,4)] <- 0.5
> colsex <- c("lightblue","pink")
> plot(N,vertex.size=20,vertex.color=colsex[V(N)$sex+1],edge.width=w,edge.curved=cur,edge.label=lab,edge.label.cex=2)

> library(jsonlite)
> write_graph_netsJSON(T,file="test1.json")
> TT <- netsJSON_to_graph(fromJSON("test1.json"),directed=TRUE)
> TT
IGRAPH 0e9ae04 DNW- 9 13 -- 
+ attr: by (g/c), cdate (g/c), title (g/c), network (g/c), org (g/n), nNodes (g/n),
| nArcs (g/n), nEdges (g/n), meta (g/x), name (v/c), age (v/n), sex (v/l), x (v/n), y
| (v/n), fact (v/n), deg (v/n), type (e/c), weight (e/n)
+ edges from 0e9ae04 (vertex names):
 [1] Ana  ->Bor   Ana  ->Cene  Eva  ->Bor   Cene ->Ana   Jan  ->Gaj   Gaj  ->Dana  Iva  ->Franc
 [8] Cene ->Gaj   Gaj  ->Ana   Bor  ->Franc Franc->Dana  Gaj  ->Bor   Iva  ->Jan  
> V(TT)[[]]
+ 9/9 vertices, named, from 0e9ae04:
   name age   sex      x      y   fact deg
1   Ana  20  TRUE 0.1429 0.4882 0.2500   4
...
9   Jan  19 FALSE 0.7615 0.7889 0.5000   2
> E(TT)[[]]
+ 13/13 edges from 0e9ae04 (vertex names):
    tail  head tid hid type weight
1    Ana   Bor   1   2  arc      3
...
13   Iva   Jan   8   9  arc      5
>


> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/igraph+.R")
> Pt <- tkplot(CoreG,800,800,edge.curved=0,edge.width=E(CoreG)$weight/5)
# tkplot window is still active
> coor <- tk_coords(Pt,norm=F)


> write_graph_paj(T,file="test1.paj")
> write_graph_paj(T,file="test1.paj",coor=cbind(V(T)$x,V(T)$y),va=c("age","deg","sex"))





# 

# https://github.com/bavla/Nets/blob/master/data/Pajek/dic/EAT/eat.md
# C:\Users\vlado\docs\papers\2025\Sunbelt\ws\R

> setwd("C:/Users/vlado/docs/papers/2025/Sunbelt/ws/R")
> EAT <- read_graph("EATnew.net",format="pajek")
> EAT
> ad <- degree(EAT,mode="all",loops=TRUE)
> id <- degree(EAT,mode="in",loops=TRUE)
> od <- degree(EAT,mode="out",loops=TRUE)
> top(ad,10)
      name value
1       ME  1108
2      MAN  1074
> wad <- strength(EAT,mode="all",weights=E(EAT)$weight,loops=TRUE)
> wid <- strength(EAT,mode="in",weights=E(EAT)$weight,loops=TRUE)
> wod <- strength(EAT,mode="out",weights=E(EAT)$weight,loops=TRUE)
> top(wad,10)
    name value
1  MONEY  4484
2  WATER  3396
...
> top(wid,10)
> top(wod,10)
> w <- E(EAT)$weight
> E(EAT)[1:20]
> names(w) <- attr(E(EAT),"vnames")
> top(w,30)
                 name value
1            LOBE|EAR    91
2      CHEDDAR|CHEESE    90
3           HONG|KONG    89
...

> EAT$name <- "The Edinburgh Associative Thesaurus"
> EAT$url <- "https://github.com/bavla/Nets/blob/master/data/Pajek/dic/EAT/eat.md"
> EAT$by <- "Vladimir Batagelj"
> EAT$cdate <- "July 31, 2003"
> saveRDS(EAT,file="EATnew.rds")


> Ta <- table(ad); Ti <- table(id); To <- table(od)
> d <- as.integer(names(Ta)); f <- unname(Ta)
> di <- as.integer(names(Ti[Ti>0])); fi <- unname(Ti[Ti>0])
> do <- as.integer(names(To[To>0])); fo <- unname(To[To>0])
> plot(d,f,log="xy",axes=FALSE,pch=16,cex=0.8)
> axis(1); axis(2)
> points(di,fi,pch=16,cex=0.8,col="red")
> points(do,fo,pch=16,cex=0.8,col="blue")
> 
