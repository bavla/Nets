# The 8th European Conference on Social Networks (EUSN 2026) 
# Norrköping, Sweden, 11–15 August 2026
# Workshop WS-16
# Vladimir Batagelj: Analysis of Two-Mode Networks Using R
# Saturday 15 August 2026, TP-41
# 8:30-10:00 break 10:30-12 lunch 14:00-15:30 break 16:00-17:30


> setwd("C:/Users/vlado/docs/papers/2026/eusn/ws/R")
> library(igraph); library(httr); library(jsonlite); library(Matrix)
> # bavla <- "https://raw.githubusercontent.com/bavla/"
> # NW <- "Nets/refs/heads/master/netsWeight/"
> pack <- "C:/Users/vlado/docs/papers/2026/eusn/ws/test/"
> # source(paste0(bavla,NW,"netsWeight.R"))
> # source(paste0(bavla,"Rnet/master/R/Pajek.R"))
> source(paste0(pack,"netsWeight.R"))
> source(paste0(pack,"/Pajek.R"))
> # source(source(paste0(bavla,"OpenAlex/main/code/OpenAlex2Pajek.R"))

> T <- read_graph(paste0(bavla,NW,"/data/GraphSet.net"),format="pajek")
> T
# not OK; igraph doesn't support mixed graphs

> (V <- read.csv(paste0(nWdir,"data/nodes.csv"),sep=""))
> (L <- read.csv(paste0(nWdir,"data/links.csv"),sep=""))
> (N <- graph_from_data_frame(L,directed=TRUE,vertices=V))
> V(N)$name <- V(N)$label
> N <- delete_vertex_attr(N,"label")
> E(N)$weight <- sample(1:7,ecount(N),replace=TRUE)
> N
> plot(N,edge.width=E(N)$weight)
> N$name <- "Network from data frame example"
> N$by <- "Vladimir Batagelj"
> N$cdate <- date()
> N
> saveRDS(N,file="igraphDF.rds")

> graph_attr(N)
> (nodes <- as_data_frame(N,what="vertices"))
> (links <- as_data_frame(N,what="edges"))

# netsJSON

> saveRDS(AW,file="AW.rds")
> AW1 <- readRDS(file="AW.rds")
> AW1
> write_graph_netsJSON(AW,file="AW.json")
> AW2 <- netsJSON_to_graph(fromJSON("AW.json"),directed=TRUE)
> AW2
> AW3 <- netsJSON_to_graph(fromJSON("AW.json"),directed=FALSE)
> AW3
> V(AW3)[[]]
> E(AW3)[[]]
> graph_attr(AW3)

# combine individual networks into a collection

> Bib <- list(netsJSON="Collection",
+ info=list(date=date(),by="VB"),nets=list(AW=AW,WK=WK))
> str(Bib)
> saveRDS(Bib,file="BibNets.rds")

# Friends

> F <- readRDS(file=url(paste0(nWdir,"/data/friends.rds")))
> F
> V(F)[[]]
> E(F)[[]]
> w <- E(F)$weight; lab <- as.character(w)
> cur <- rep(0,ecount(F)); cur[c(2,4)] <- 0.5
> colsex <- c("lightblue","pink")
> plot(F,vertex.size=20,vertex.color=colsex[V(F)$sex+1],edge.width=w,edge.curved=cur,edge.label=lab,edge.label.cex=2)

# manually changing node positions

> Rnet <- "https://raw.githubusercontent.com/bavla/Rnet/"
> source(paste0(Rnet,"master/R/igraph+.R"))
> Pt <- tkplot(N,800,800,edge.curved=0,edge.width=E(N)$weight/5)
# tkplot window is still active
> coor <- tk_coords(Pt,norm=F) # save new coordinates
> tk_close(Pt)
> V(N)$x <- coor[,1]; V(N)$y <- coor[,2]

> # write_graph_paj(N,file="test1.paj")
> # write_graph_paj(N,file="test1.paj",coor=cbind(V(N)$x,V(N)$y),va=c("age","deg","sex"))


# Two-mode networks


> AW <- read_graph(paste0(bavla,NW,"data/AW.net"),format="pajek")
> AW
> plot(AW)
> saveRDS(AW,file="AW.rds")
> AW1 <- readRDS(file="AW.rds")
> AW1
> write_graph_netsJSON(AW,file="AW.json")
> AW2 <- netsJSON_to_graph(fromJSON("AW.json"),directed=TRUE)
> AW2
> AW3 <- netsJSON_to_graph(fromJSON("AW.json"),directed=FALSE)
> AW3
> V(AW3)[[]]
> E(AW3)[[]]
> graph_attr(AW3)


# normalizations

> library(Matrix)
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
> normalize_matrix_Markov(as_sparse_matrix(WA))

# Info

> object.size(SnWA)
173075160 bytes
> gc()
           used  (Mb) gc trigger  (Mb) max used  (Mb)
Ncells  2866272 153.1    6542529 349.5  6443234 344.2
Vcells 13231092 101.0   46987514 358.5 58444046 445.9

# Additional functions

> matrix_D0 <- function(M){diag(M) <- 0; drop0(M)}
> matrix2graph_S0 <- function(M){
+   graph_from_adjacency_matrix(M,mode="plus",diag=FALSE,weighted=TRUE) }



# Collaborativenness

> WAfile <- "C:/Users/vlado/docs/papers/2026/eusn/ws/test/SN/SNWAnC.net"
> SnWA <- read_graph(WAfile,format="pajek")
> SnWA
> is_bipartite(SnWA)
> table(V(SnWA)$type)
 FALSE   TRUE 
956445 159302 
> (nW <- sum(!V(SnWA)$type))
[1] 956445
> (nA <- sum(V(SnWA)$type))
[1] 159302
> WAn <- normalize_matrix_Markov(as_sparse_matrix(SnWA))
> nAut <- colSums(as_sparse_matrix(SnWA))  # indeg
> cAut <- colSums(WAn)                     # windeg
> p <- rev(order(nAut))
> s <- p[1:50]
> DF <- data.frame(nAut=nAut[s],cAut=cAut[s],coll=1-cAut[s]/nAut[s])
> DF

# Strict co-authorship

> WAs <- normalize_matrix_Newman(as_sparse_matrix(SnWA))
> MCs <- crossprod(WAs,WAn)
> GCs <- graph_from_adjacency_matrix(MCs,mode="plus",diag=FALSE,weighted=TRUE)
> GCs

# Ps cores

> wdeg <- strength(GCs)
> V(GCs)$wdeg <- as.vector(wdeg)
> NC <- node_cut(GCs,"wdeg",5)
> NC
IGRAPH c9bcfbb UNW- 2196 4348 -- 
+ attr: name (v/c), wdeg (v/n), weight (e/n)
+ edges from c9bcfbb (vertex names):
 [1] Elianore Quinlan      --Astrid Rykhard          Shlomo Berkovsky      --Jill Freyne            
> date()
[1] "Fri Aug 14 20:51:43 2026"
> hc <- cores(NC,p=p_wdeg)
> date()
[1] "Fri Aug 14 20:52:00 2026"
> V(NC)$hc <- hc
> Core <- node_cut(NC,"hc",5)
> Core
IGRAPH 91643c9 UNW- 477 733 -- 
+ attr: name (v/c), wdeg (v/n), hc (v/n), weight (e/n)
+ edges from 91643c9 (vertex names):
 [1] Elianore Quinlan       --Astrid Rykhard           Timon Elmer            --Christoph Stadtfeld     
+ ... omitted several edges
> Cc <- components(Core)
> str(Cc)
List of 3
 $ membership: Named num [1:477] 1 1 2 3 2 4 2 2 2 2 ...
  ..- attr(*, "names")= chr [1:477] "Elianore Quinlan" "Astrid Rykhard" "Wouter de Nooy" "Sho Tsugawa" ...
 $ csize     : num [1:108] 2 224 2 2 3 2 2 6 3 2 ...
 $ no        : num 108
> V(Core)$core <- as.vector(Cc$membership)
> Mcore <- extract_clusters(Core,"core",2)
> w <- E(Mcore)$weight
> plot(Mcore,vertex.size=10,vertex.label.cex=0.6,edge.width=w)
> Pt <- tkplot(Mcore,1200,800,vertex.size=10,vertex.label.cex=0.6,edge.curved=0,edge.width=w)

# Citations between authors

> Cifile <- "C:/Users/vlado/docs/papers/2026/eusn/ws/test/SN/SNCi.net"
> SnCi <- read_graph(Cifile,format="pajek")
> E(SnCi)$weight <- rep(1,ecount(SnCi))
> Cin <- normalize_matrix_Markov(as_sparse_matrix(SnCi))
> MACiAn <- crossprod(WAn,Cin) %*% WAn
> GACiAn <- graph_from_adjacency_matrix(MACiAn,mode="directed",weighted=TRUE)
> GACiAn
IGRAPH 1b7e4cf DNW- 159302 5086042 -- 
+ attr: name (v/c), weight (e/n)
+ edges from 1b7e4cf (vertex names):
 [1] Rui Jin                          ->Rui Jin      Hongli Zhang                     ->Rui Jin  
> LC <- link_cut(simplify(GACiAn),atn="weight",0.4)
> V(LC)$wc <- unname(components(LC,mode="weak")$membership)
> table(V(LC)$wc)
> Mcite <- extract_clusters(LC,"wc",1)
> Mcite
> Mcite$project <- "Social network analysis on OpenAlex"
> Mcite$name <- "main component in citation network between authors, cut at 0.4"
> Mcite$date <- date()
> Mcite$by <- "Vladimir Batagelj"
> saveRDS(Mcite,file="SnACiAn_C1.rds")


> w <- E(Mcite)$weight
> Pic <- tkplot(Mcite,1400,800,edge.width=w,vertex.size=10,vertex.label.cex=0.7)
> # tkplot window is still active
> coor <- tk_coords(Pic,norm=FALSE)
> tk_close(Pic)
> V(Mcite)$x <- coor[,1]; V(Mcite)$y <- coor[,2]
> plot(Mcite,edge.width=w,vertex.size=10,vertex.label.cex=0.7)



# 4-cycles
# 2-mode cores
# ----------------------------------------------------------------------
> library(datawizard)
v <- categorize(E(GACiAn)$weight,split=c(0.1, 1, 10, 100))

V(LC)$wc <- unname(components(LC,mode="weak")$membership)

