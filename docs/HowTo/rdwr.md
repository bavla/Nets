# Read / Write

```
> library(igraph)
> setwd("C:/Users/public/Sunbelt25")
> nWdir <- paste0("https://raw.githubusercontent.com/",
+  "bavla/Nets/refs/heads/master/netsWeight/")

> # source("netsWeight.R")
> source(paste0(nWdir,"netsWeight.R"))


https://github.com/bavla/Nets/blob/master/netsWeight/data/GraphSet.net

> Test <- read_graph(paste0(nWdir,"/data/GraphSet.net"),format="pajek")
> Test
> plot(Test)

# Not OK !!!

> V <- read.csv(paste0(nWdir,"/data/nodes.csv"),sep="")
> L <- read.csv(paste0(nWdir,"/data/links.csv"),sep="")
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

# Not in slides

> T <- readRDS(file=url(paste0(nWdir,"/data/test1.rds")))
> T
> V(T)[[]]
> E(T)[[]]
> w <- E(T)$weight; lab <- as.character(w)
> cur <- rep(0,ecount(T)); cur[c(2,4)] <- 0.5
> colsex <- c("lightblue","pink")
> plot(T,vertex.size=20,vertex.color=colsex[V(N)$sex+1],edge.width=w,edge.curved=cur,edge.label=lab,edge.label.cex=2)

```

```

```


```

```

<hr />

[How to](./README.md)
