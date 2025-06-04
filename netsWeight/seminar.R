> setwd(wdir<-"C:/Users/vlado/docs/papers/2025/Sunbelt/ws/R")
> library(igraph); library(Matrix)
> source("https://raw.githubusercontent.com/bavla/Nets/refs/heads/master/netsWeight/netsWeight.R")
> source("netsWeight.R")

# Manual network construction
> setwd(wdir<-"C:/Users/vlado/docs/papers/2025/Sunbelt/ws/R")
> library(igraph)
> G <- make_graph(edges=c(1,2, 1,3, 5,2, 3,1),n=6,directed=TRUE)
> G
> plot(G)
> G <- add_vertices(G,3)
> G
> plot(G)
> G <- add_edges(G,edges=c(9,7, 7,4, 8,6))
> plot(G)
> V(G)
> E(G)
> vcount(G)
> ecount(G)
> G$name <- "Primer1"
> G$by <- "Vladimir Batagelj"
> G$cdate <- date()
> V(G)$name <- c("Ana","Bor","Cene","Dana","Eva","Franc","Gaj","Iva","Jan")
> G
> V(G)$age <- sample(19:25,vcount(G),replace=TRUE)
> E(G)$weight <- sample(1:5,ecount(G),replace=TRUE)
> G
> V(G)[[]]
> E(G)[[]]
> (outdeg <- degree(G,mode="out"))
> plot(G)
> plot(G,vertex.size=1+outdeg,edge.width=E(G)$weight)
> plot(G,vertex.size=7+5*outdeg,edge.width=E(G)$weight,vertex.color="lightblue")
> col <- sample(c("lightblue","pink","yellow"),vcount(G),replace=TRUE)
> plot(G,vertex.size=7+5*outdeg,edge.width=E(G)$weight,vertex.color=col)
 
> H <- make_graph(~ A --+ B:D:E:F, B +-- C, B --+ A, E --+ B)
> plot(H)

# Reading and saving
> library(jsonlite); library(httr)
> # AW <- read_graph("AW.net",format="pajek")
> AWfile <- "https://raw.githubusercontent.com/bavla/Nets/refs/heads/master/netsWeight/AW.net"
> AW <- read_graph(AWfile,format="pajek")
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
> plot(AW)
> plot(AW,main=AW$name)

> WKfile <- "https://raw.githubusercontent.com/bavla/Nets/refs/heads/master/netsWeight/WK.net"
> WK <- read_graph(WKfile,format="pajek")
> WK

> davis <- read.csv(file.choose(), header=FALSE)
> D <- graph_from_data_frame(davis, directed=FALSE)
> V(D)$type <- bipartite_mapping(D)$type
> V(D)$name[19:32] <- paste("event-",1:14,sep="")
> is_bipartite(D)
> D$name <- "Davis"; D$twomode <- TRUE

> saveRDS(AW,file="AW.rds")
> AW1 <- readRDS(file="AW.rds")
> AW1

> write_graph_netsJSON(AW,file="AW.json")

# Erasmus flow

## k-neighbors
> EFfile <- "https://raw.githubusercontent.com/bavla/wNets/main/Data/ErasmusFlows.net"
> EF <- read_graph(EFfile,format="pajek")
> iso2 <- read.csv2(file.choose(),header=FALSE) # iso2.csv
> head(iso2)
> V(EF)$iso2 <- trimws(iso2$V2)

> KN1 <- kNeighbors(EF,1)
> l1 <- layout_with_fr(KN1,weights=rep(1,ecount(KN1)))
> w <- (E(KN1)$weight**0.2)/2
> plot(KN1,layout=l1,edge.width=w,main="Erasmus 1-neighbors")
> plot(KN1,vertex.size=10,vertex.label=V(EF)$iso2,layout=l1,edge.width=w,vertex.label.cex=0.65,main="Erasmus 1-neighbors")

> KN2 <- kNeighbors(EF,2)
> l2 <- layout_with_fr(KN2,weights=rep(1,ecount(KN2)))
> w <- (E(KN2)$weight**0.2)/2
> plot(KN2,layout=l2,edge.width=w,main="Erasmus 2-neighbors")
> str(l2)
> V(KN2)$x <- l2[,1]; V(KN2)$y <- l2[,2] 
> plot(KN2,vertex.label=V(EF)$iso2)

## Balassa normalization
> MEF <- as_sparse_matrix(EF)
> Z <- as.matrix(normalize_matrix_activity(MEF))
> t <- hclust(as.dist((CorEuclid(Z)+CorEuclid(t(Z)))/2),method="ward.D")
> Z[Z == 0] <- NA 
> plot(t)
> library(gplots)
> pdf(file="EF14bala.pdf",width=30,height=30)
> par(cex.main=3)
> heatmap.2(Z,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+    scale="none",revC=TRUE,col=bluered(100),na.color="yellow",
+    trace="none", density.info="none", keysize=0.8, symkey=FALSE,
+    margins=c(15,15),cexRow=2,cexCol=2,
+    main=paste("Erasmus flows 2014-2024 / Balassa / Ward",sep=""))

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

