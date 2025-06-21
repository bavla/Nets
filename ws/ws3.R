# Sunbelt 2025 Workshop 
# Analysis of weighted networks
# part 3
# by Vladimir Batagelj
# Paris, June 24, 2025
# https://github.com/bavla/Nets/tree/master/ws
# https://r.igraph.org/reference/index.html

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


# Ars Mathematica Contemporanea

http://localhost:8800/doku.php?id=work:bib:alex:amcs

> # WAfile <- "https://raw.githubusercontent.com/bavla/OpenAlex/refs/heads/main/data/AMC/WA.net"
> # WJfile <- "https://raw.githubusercontent.com/bavla/OpenAlex/refs/heads/main/data/AMC/WJ.net"
> # Cifile <- "https://raw.githubusercontent.com/bavla/OpenAlex/refs/heads/main/data/AMC/Ci.net"

> library(httr); library(jsonlite); library(pryr)
> OAdir <- "https://raw.githubusercontent.com/bavla/OpenAlex/"
> OAdata <- paste0(OAdir,"refs/heads/main/data/")
> OAcode <- paste0(OAdir,"main/code/")
> source(paste0(OAcode,"OpenAlex2Pajek.R"))

> WA <- read_graph(paste0(OAdata,"AMC/WA.net"),format="pajek")
> (nW <- sum(!V(WA)$type))
> (nA <- sum(V(WA)$type))

> (x <- exp(1))
> bytes(x)
[1] "40 05 BF 0A 8B 14 57 69"
> as.integer(object.size(WA))/nW/nA/8
[1] 0.001895938

> WJ <- read_graph(paste0(OAdata,"AMC/WJ.net"),format="pajek")
> (nJ <- sum(V(WJ)$type))
> Ci <- read_graph(paste0(OAdata,"AMC/Ci.net"),format="pajek")

> source <- "S61442588"  # OA id of ACM
> (is <- which(V(WJ)$name==source))
[1] 137766
> s <- rep(0,nJ); s[is-nW] <- 1
> MWJ <- as_sparse_matrix(WJ)
> Wj <- MWJ %*% s
> sum(Wj)
[1] 865

> MCi <- as_sparse_matrix(Ci); namCi <- rownames(MCi)

> dI <- MCi %*% Wj
> p <- order(dI,decreasing=TRUE)
> selI <- p[1:20]
> (topI <- cbind(selI,namCi[selI],dI[selI]))

> selW <- paste0("id,language,countries_distinct_count,cited_by_count,",
+   "relevance_score,publication_year,title,authorships")
> IWi <- unitsInfo(IDs=namCi[selI],units="works",select=selW,order="input")
> rep <- data.frame(id=IWi$id,cdc=IWi$countries_distinct_count,
+   cby=IWi$cited_by_count,dI=dI[selI],year=IWi$publication_year,
+   authors=substr(authors(IWi),1,35),title=substr(IWi$title,1,45))
> rep

> dO <- crossprod(MCi,Wj) 
> q <- order(dO,decreasing=TRUE)
> selO <- q[1:20]
> (topO <- cbind(selO,namCi[selO],dO[selO]))

> IWo <- unitsInfo(IDs=namCi[selO],units="works",select=selW,order="input")
> rep <- data.frame(id=IWo$id,cdc=IWo$countries_distinct_count,
+   cby=IWo$cited_by_count,dO=dO[selO],year=IWo$publication_year,
+   authors=substr(authors(IWo),1,35),title=substr(IWo$title,1,45))
> rep

# citations between journals

> MJJ <- crossprod(MWJ,MCi) %*% MWJ
> nJJ <- nrow(MJJ); mJJ <- sum(MJJ>0); kJJ <- sum(diag(MJJ)>0)
> JJ <- graph_from_adjacency_matrix(MJJ,mode="directed",weighted=TRUE)
> JJ$project <- "Ars Mathematica Contemporanea"
> JJ$name <- "journal citation network"
> JJ$date <- date()
> JJ$by <- "Vladimir Batagelj"
> saveRDS(JJ,file="AMC_JJ.rds")

> w <- E(simplify(JJ))$weight
> r <- order(w,decreasing=TRUE)
> w[r[1:100]]
> LC <- edge_cut(simplify(JJ),atn="weight",100)
> (S <- V(LC)$name)
> un <- 3  # unknown
> selS <- "id,issn_l,country_code,type,is_oa,cited_by_count,works_count,display_name"
> IS <- unitsInfo(IDs=S,units="sources",select=selS,order="input")
> IS$display_name[un] <- IS$id[un] <- "Sunknown"; IS$issn_l[un] <- NA
> rep <- data.frame(id=IS$id,issn_l=IS$issn_l,journal=IS$display_name)
> rep
> V(LC)$source <- IS$display_name; w <- E(LC)$weight
> lo <- layout_with_dh(LC)
> plot(LC,layout=lo,edge.width=log(w),vertex.color="pink",
+    vertex.size=12,vertex.label=V(LC)$source,vertex.label.cex=0.7)


# citations between authors

> MWA <- as_sparse_matrix(WA)
> MACiA <- crossprod(MWA,MCi) %*% MWA
> nACiA <- nrow(MACiA); mACiA <- sum(MACiA>0); kACiA <- sum(diag(MACiA)>0)
> ACiA <- graph_from_adjacency_matrix(MACiA,mode="directed",weighted=TRUE)
> ACiA$project <- "Ars Mathematica Contemporanea"
> ACiA$name <- "author citation network"
> ACiA$date <- date()
> ACiA$by <- "Vladimir Batagelj"
> saveRDS(ACiA,file="AMC_ACiA.rds")

> w <- E(simplify(ACiA))$weight
> r <- order(w,decreasing=TRUE)
> w[r[1:100]]
> LC <- edge_cut(simplify(ACiA),atn="weight",100)
> (A <- V(LC)$name)
> selA <- "id,orcid,works_count,cited_by_count,relevance_score,display_name"
> IA <- unitsInfo(IDs=A,units="authors",select=selA,order="input")
> rep <- data.frame(id=IA$id,orcid=substring(IA$orcid,19),wc=IA$works_count,
+   cbc=IA$cited_by_count,name=IA$display_name)
> rep
> V(LC)$author <- IA$display_name; w <- E(LC)$weight
> lo <- layout_with_dh(LC)
> plot(LC,layout=lo,edge.width=log(w),vertex.color="pink",
+    vertex.size=12,vertex.label=V(LC)$author,vertex.label.cex=0.7)

> Pic <- tkplot(LC,800,800,layout=lo,edge.width=log(w),
+    vertex.label=V(LC)$author,vertex.size=10,vertex.label.cex=0.7)
> # tkplot window is still active
> coor <- tk_coords(Pic,norm=FALSE)
> tk_close(Pic)
> V(LC)$x <- coor[,1]; V(LC)$y <- coor[,2]
> V(LC)$wc <- unname(components(LC,mode="weak")$membership)
> col <- c("red","lightblue","magenta","green","yellow","orange","brown","lightgreen")
> plot(LC,edge.width=log(w),vertex.color=col[V(LC)$wc],
+    vertex.size=12,vertex.label=V(LC)$author,vertex.label.cex=0.7)
> LC$project <- "Ars Mathematica Contemporanea"
> LC$name <- "author citation network - link cut t=100"
> LC$date <- date()
> LC$by <- "Vladimir Batagelj"
> saveRDS(LC,file="AMC_authors_LC.rds")








