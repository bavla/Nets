# Sunbelt 2025 Workshop 
# Analysis of weighted networks
# part 3
# by Vladimir Batagelj
# Paris, June 24, 2025
# https://github.com/bavla/Nets/tree/master/ws


> library(igraph)
> setwd("C:/Users/public/Sunbelt25")
> nWdir <- paste0("https://raw.githubusercontent.com/",
+  "bavla/Nets/refs/heads/master/netsWeight/")

> # source("netsWeight.R")
> source(paste0(nWdir,"netsWeight.R"))


> V <- read.csv(paste0(nWdir,"/data/nodes.csv"),sep="")

> library(jsonlite); library(httr)
> # AW <- read_graph("AW.net",format="pajek")
> AW <- read_graph(paste0(nWdir,"/data/AW.net"),format="pajek")
> AW
> V(AW)[[]]
> E(AW)[[]]
> is_bipartite(AW)
> AW <- delete_vertex_attr(AW,"type")
> AW
> is_bipartite(AW)
> V(AW)$type <- bipartite_mapping(AW)$type
> is_bipartite(AW)
> AW$name <- "Authors-Works"
> AW$date <- date()
> AW$twomode <- TRUE
> AW
> plot(AW,main=AW$name)

> WK <- read_graph(WKfile,format="pajek")
> WK <- read_graph(paste0(nWdir,"/data/WK.net"),format="pajek")
> WK

> davis <- read.csv(file.choose(), header=FALSE)
> D <- graph_from_data_frame(davis, directed=FALSE)
> V(D)$type <- bipartite_mapping(D)$type
> V(D)$name[19:32] <- paste("event-",1:14,sep="")
> is_bipartite(D)
> D$name <- "Davis"; D$twomode <- TRUE

# normalizations

> X <- matrix(c(7,0,6,2, 3,1,4,0, 0,3,0,2, 4,0,5,1, 0,2,0,2),ncol=4,byrow=TRUE)
> rownames(X) <- rownames(M); colnames(X) <- colnames(M)
> Y <- as(X,"sparseMatrix")
> Y
> normalize_matrix_Markov(Y)
> normalize_matrix_Balassa(Y)
> normalize_matrix_activity(Y)
> normalize_matrix_RSI(Y)
> (MWA <- as_sparse_matrix((WA <- network_reverse(AW))))
> normalize_matrix_Newman(as_sparse_matrix(WA))



# AMC
> library(httr); library(jsonlite)
> WAfile <- "https://raw.githubusercontent.com/bavla/OpenAlex/refs/heads/main/data/AMC/WA.net"
> WA <- read_graph(WAfile,format="pajek")
> (nW <- sum(!V(WA)$type))
> (nA <- sum(V(WA)$type))

> library(pryr)
> (x <- exp(1))
> bytes(x)
[1] "40 05 BF 0A 8B 14 57 69"
> as.integer(object.size(WA))/nW/nA/8
[1] 0.001895938

> WJfile <- "https://raw.githubusercontent.com/bavla/OpenAlex/refs/heads/main/data/AMC/WJ.net"
> WJ <- read_graph(WJfile,format="pajek")
> (nJ <- sum(V(WJ)$type))

> Cifile <- "https://raw.githubusercontent.com/bavla/OpenAlex/refs/heads/main/data/AMC/Ci.net"
> Ci <- read_graph(Cifile,format="pajek")

> source <- "S61442588"
> (is <- which(V(WJ)$name==source))
[1] 137766
> s <- rep(0,nJ); s[is-nW] <- 1
> MWJ <- as_sparse_matrix(WJ)
> Ws <- MWJ %*% s
> sum(Ws)
[1] 865

> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2Pajek.R")
> MCi <- as_sparse_matrix(Ci); namCi <- rownames(MCi)

> dI <- MCi %*% Ws
> p <- order(dI,decreasing=TRUE)
> selI <- p[1:20]
> (topI <- cbind(selI,namCi[selI],dI[selI]))

> selW <- paste0("id,language,countries_distinct_count,cited_by_count,",
+    "relevance_score,publication_year,title,authorships")
> RW <- unitsInfo(IDs=namCi[selI],units="works",select=selW,order="input")
> rep <- data.frame(id=RW$id,cdc=RW$countries_distinct_count,cby=RW$cited_by_count,dI=dI[selI],
+ year=RW$publication_year,authors=substr(authors(RW),1,35),title=substr(RW$title,1,45))

> dO <- crossprod(MCi,Ws) 
> q <- order(dO,decreasing=TRUE)
> selO <- q[1:20]
> (topO <- cbind(selO,namCi[selO],dO[selO]))

> library(Matrix)
> t(MCi)
