# netsWeight
# by Vladimir Batagelj
# May 29, 2025 -
# ---------------------------------------------------------------
# implementing some Pajek's procedures in iGraph
#   additional functions used in igraph examples for the Network analysis
#   course at HSE Moscow in November 2017 and December 2018 by Vladimir Batagelj
# ---------------------------------------------------------------
# source("https://raw.githubusercontent.com/bavla/Nets/refs/heads/master/netsWeight/netsWeight.R")

library(igraph); library(data.table); library(seqinr)

top <- function(v,k){
  ord <- rev(order(v)); sel <- ord[1:k]
  S <- data.frame(name=names(v[sel]),value=as.vector(v[sel]))
  return(S)
}

read_Pajek_clu <- function(f,skip=1){
  read.table(f,skip=skip,colClasses=c("integer"),header=FALSE)$V1
}

read_Pajek_vec <- function(f,skip=1){
  read.table(f,skip=skip,colClasses=c("numeric"),header=FALSE)$V1
}

extract_clusters <- function(N,atn,clus){
  C <- vertex_attr(N,atn); S <- V(N)[C %in% clus]
  return(induced_subgraph(N,S))
}

interlinks <- function(N,atn,c1,c2,col1="red",col2="blue"){
  S <- extract_clusters(N,atn,c(c1,c2))
  C <- vertex_attr(S,atn)
  C1 <- V(S)[C==c1]; C2 <- V(S)[C==c2]
  V(S)$color <- ifelse(C==c1,col1,col2)
  P <- E(S)[(C1 %--% C1)|(C2 %--% C2)]
  return(delete_edges(S,P))
}
  
vertex_cut <- function(N,atn,t){
  v <- vertex_attr(N,atn); vCut <- V(N)[v>=t] 
  return(induced_subgraph(N,vCut))
}

edge_cut <- function(N,atn,t){
  w <- edge_attr(N,atn); eCut <- E(N)[w>=t] 
  return(subgraph.edges(N,eCut))
}

kNeighbors <- function(Net,k,weight="weight",mode="out",strict=TRUE,loops=FALSE){ 
  if(!loops) Net <- simplify(Net,remove.multiple=FALSE)
  C <- data.table()
  for(v in V(Net)){
    Nv <- incident(Net,v,mode=mode); Nw <- edge_attr(Net,weight,Nv)
    p <- order(Nw,decreasing=TRUE)
    Na <- if(strict) Nv[p[1:k]] else Nv[Nw >= Nw[p[k]]]
    # Nnet <- add_edges(Nnet,Na)
    CC <- data.table(tail=tail_of(Net,Na),head=head_of(Net,Na))
    CC[[weight]] <- edge_attr(Net,weight,Na)
    C <- rbind(C,CC)
  }
  Nnet <- graph_from_data_frame(as.data.frame(C),directed=TRUE,vertices=V(Net))
  V(Nnet)$name <- V(Net)$name #; V(Nnet)$id <- V(Net)$id
  Nnet$date <- date(); Nnet$by <- "k-neigbors"
  return(Nnet)
}

network_reverse <- function(N){
  V(N)$type <- !V(N)$type
  return(N)
}

as_sparse_matrix <- function(N,weight="weight"){
  if(is_bipartite(N)) return(as_biadjacency_matrix(N,attr=weight,sparse=TRUE))
  return(as_adjacency_matrix(N,attr=weight,sparse=TRUE))
}

mult_network_vector <- function(N,v,mode="row",weight="weight"){
  D <- as(diag(v),"sparseMatrix"); n <- length(v)
  if(is_bipartite(N)) {
    nr <- sum(!V(N)$type); nc <- sum(V(N)$type)
    if(mode=="row"){
      if(n!=nr) stop("row 2-mode")
      R <- graph_from_biadjacency_matrix(
        D %*% as_biadjacency_matrix(N,attr=weight,sparse=TRUE),
        directed=TRUE,mode="out",weighted=weight)
    } else {
      if(n!=nc) stop("col 2-mode")
      R <- graph_from_biadjacency_matrix(
        as_biadjacency_matrix(N,attr=weight,sparse=TRUE) %*% D,   
        directed=TRUE,mode="out",weighted=weight)
    }
  } else {
    nr <- vcount(N)
    if(mode=="row"){
      if(n!=nr) stop("row 1-mode")
      R <- graph_from_adjacency_matrix(
        D %*% as_adjacency_matrix(N,attr=weight,sparse=TRUE),
        mode="directed",weighted=weight)
    } else {
      if(n!=nr) stop("col 1-mode")
      R <- graph_from_adjacency_matrix(
        as_adjacency_matrix(N,attr=weight,sparse=TRUE) %*% D,   
        mode="directed",weighted=weight)
    }
  }
  if("name" %in% vertex_attr_names(N)) V(R)$name <- V(N)$name
  return(R)
}


cross_networks <- function(N1,N2,side="left",weight="weight",twomode=TRUE){
  if(side=="left") { 
    M <- crossprod(as_sparse_matrix(N1,weight="weight"),
      as_sparse_matrix(N2,weight="weight"))
  } else {
    M <- tcrossprod(as_sparse_matrix(N1,weight="weight"),
      as_sparse_matrix(N2,weight="weight")) }
  if(nrow(M)!=ncol(M)) twomode <- TRUE
  if (twomode) return(graph_from_biadjacency_matrix(M,   
    directed=TRUE,mode="out",weighted=weight))
  return(graph_from_adjacency_matrix(M,mode="directed",weighted=weight)) 
}

mult_networks <- function(N1,N2,weight="weight",twomode=TRUE){
  names <- ("name" %in% vertex_attr_names(N1)) & ("name" %in% vertex_attr_names(N2))
  if(is_bipartite(N1)){
    if(names) {A <- V(N1)[V(N1)$type==FALSE]$name; B <- V(N1)[V(N1)$type==TRUE]$name}
    M1 <- as_biadjacency_matrix(N1,attr=weight,sparse=TRUE)
  } else { if(names) {A <- B <- V(N1)$name} 
    M1 <- as_adjacency_matrix(N1,attr=weight,sparse=TRUE) } 
  if(is_bipartite(N2)){
    if(names) {D <- V(N2)[V(N2)$type==FALSE]$name; C <- V(N2)[V(N2)$type==TRUE]$name}
    M2 <- as_biadjacency_matrix(N2,attr=weight,sparse=TRUE)
  } else { if(names) {D <- C <- V(N2)$name}
    M2 <- as_adjacency_matrix(N2,attr=weight,sparse=TRUE) } 
  nA <- length(A); nB <- length(B); nD <- length(D); nC <- length(C)
  if(nB != nD) stop("networks are not compatible")
  if(nA != nC) twomode <- TRUE
  n <- ifelse(twomode,nA+nC,nA)
  if (twomode) { N <- graph_from_biadjacency_matrix(M1 %*% M2,   
    directed=TRUE,mode="out",weighted=weight)
  } else { N <- graph_from_adjacency_matrix(M1 %*% M2,   
    mode="directed",weighted=weight) }
  if(names) V(N)$name <- c(A,C)
  if(twomode) V(N)$type <- c(rep(FALSE,nA),rep(TRUE,nC))
  return(N)
}

normalize_matrix_Markov <- function(M){
  R <- rowSums(M)
  r <- sparseVector(R,i=which(R!=0),length=length(R))
  T <- as(diag(1/r),"sparseMatrix") %*% M
  rownames(T) <- rownames(M)
  return(T)
}

normalize_matrix_Newman <- function(M){
  R <- rowSums(M)-1; R[R==0] <- 1; i <- which(R>0)
  r <- sparseVector(R[i],i=i,length=length(R))
  T <- as(diag(1/r),"sparseMatrix") %*% M
  rownames(T) <- rownames(M)
  return(T)
}

normalize_matrix_Balassa <- function(M){
  R <- rowSums(M); C <- colSums(M); S <- sum(M)
  r <- sparseVector(R,i=which(R!=0),length=length(R))
  c <- sparseVector(C,i=which(C!=0),length=length(C))
  T <- S*(as(diag(1/r),"sparseMatrix") %*% M %*% as(diag(1/c),"sparseMatrix"))
  rownames(T) <- rownames(M); colnames(T) <- colnames(M)
  return(T)
}

normalize_matrix_activity <- function(M){
  B <- normalize_matrix_Balassa(M)
  B@x <- log2(B@x)
  return(B)
}

rsi <- function(x) (x-1)/(x+1)

normalize_matrix_RSI <- function(M){
  B <- normalize_matrix_Balassa(M)
  B@x <- rsi(B@x)
  return(B)
}

CorSalton <- function(W){
   S <- W; diag(S) <- 1; n = nrow(S)
   for(u in 1:(n-1)) for(v in (u+1):n) S[v,u] <- S[u,v] <- 
      (as.vector(W[u,]%*%W[v,])+(W[u,u]-W[v,u])*(W[v,v]-W[u,v]))/
      sqrt(as.vector(W[u,]%*%W[u,])*as.vector(W[v,]%*%W[v,])) 
   return(S)
}

CorEuclid <- function(W){
   D <- W; diag(D) <- 0; n = nrow(D)
   for(u in 1:(n-1)) for(v in (u+1):n) D[v,u] <- D[u,v] <- 
      sqrt(sum((W[u,]-W[v,])**2) + 2*(W[u,u]-W[u,v])*(W[v,u]-W[v,v])) 
   return(D)
}

Salton <- function(W){
   S <- W; diag(S) <- 1; n = nrow(S)
   for(u in 1:(n-1)) for(v in (u+1):n) S[v,u] <- S[u,v] <- 
      (as.vector(W[u,]%*%W[v,]))/
      sqrt(as.vector(W[u,]%*%W[u,])*as.vector(W[v,]%*%W[v,])) 
   return(S)
}

Euclid <- function(W){
   D <- W; diag(D) <- 0; n = nrow(D)
   for(u in 1:(n-1)) for(v in (u+1):n) D[v,u] <- D[u,v] <- 
      sqrt(sum((W[u,]-W[v,])**2)) 
   return(D)
}

authors <- function(L) {A <- L$authorships; k <- length(A); N <- rep("",k)
  for (i in 1:k) N[i] <- paste(A[i][[1]]$author$display_name,collapse=", ")
  return(N)
}

# export igraph network in netsSON basic format
# by Vladimir Batagelj, December 2018
# based on transforming CSV files to JSON file, by Vladimir Batagelj, June 2016 
# updated by Vladimir Batagelj, December 11/12, 2024

write_graph_netsJSON <- function(N,file="test.json",vname="name",leg=list() ){
  n <- gorder(N); m <- gsize(N); dir <- is_directed(N)
  lType <- ifelse(dir,"arc","edge")
  va <- vertex_attr_names(N); ea <- edge_attr_names(N)
  vlab <- if(vname %in% va) vertex_attr(N,vname) else paste("v",1:n,sep="")
  va <- setdiff(va,vname)  
  nods <- vector('list',n); lnks <- vector('list',m)
  today <- format(Sys.time(), "%a %b %d %X %Y")
  for(i in 1:n) { L <- list(id=i,name=vlab[i]) 
    for(a in va) L[[a]] <- vertex_attr(N,a)[i]
    nods[[i]] <- L }
  for(i in 1:m) {uv <- ends(N,i,names=FALSE); u <- uv[1]; v <- uv[2]
    L <- list(id=i,type=lType,n1=u,n2=v)
    for(a in ea) L[[a]] <- edge_attr(N,a)[i]
    lnks[[i]] <- L }
  meta <- list(date=today,title="saved from igraph")
  # leg <- list(mode="mod",sex="sx",rel="rel")
  inf <- graph_attr(N)
  if("name" %in% names(inf)) {inf["title"] <- inf$name; inf[["name"]] <- NULL}
  inf["network"] <- "bib"; inf["org"] <- 1
  inf["nNodes"] <- n; 
  if(dir) {inf["nArcs"] <- m; inf["nEdges"] <- 0} else {inf["nArcs"] <- 0; inf["nEdges"] <- m}
  if(length(leg)>0) {inf[["legend"]] <- leg
    # razdelaj izpis vrednosti
  } 
  if("meta" %in% names(inf)) { k <- length(inf[["meta"]]); inf[["meta"]][[k+1]] <- meta
  } else inf[["meta"]] <- meta
  data <- list(netsJSON="basic",info=inf,nodes=nods,links=lnks)
  json <- file(file,"w") 
  cat(toJSON(data,na="string",auto_unbox=TRUE),file=json) 
  close(json)
}

# December 9/10, 2024 by Vladimir Batagelj
netsJSON_to_graph <- function(BB,directed=FALSE){
  L <- BB$links; N <- names(L); LN <- names(BB$info$legend)
  t <- (L$type=="edge") & (L$n1!=L$n2)
  if(!("weight" %in% N)) {L$weight <- 1; N <- c(N,"weight")}
  N <- N[! N %in% c("n1","n2","id")]
  U <- BB$nodes; U$id <- 1:nrow(U)
  if(length(LN)> 0) {
    for(a in N) if(a %in% LN) { L[,a] <- BB$info$legend[[a]][L[,a]] }
    for(a in K) if(a %in% LN) { U[,a] <- BB$info$legend[[a]][U[,a]] }
  }
  L <- data.frame(from=L$n1,to=L$n2,L[,N])
  if(directed){E <- L[t,]
     L <- rbind(L,data.frame(from=E$to,to=E$from,E[,N]))
     L$type <- "arc"
     G <- graph_from_data_frame(d=L,vertices=U,directed=TRUE)
  } else G <- graph_from_data_frame(d=L,vertices=U,directed=FALSE)
  I <- names(BB$info); I <- I[! I=="legend"]
  for(a in I) graph_attr(G)[a] <- BB$info[a]
  return(G)
}

# June 12/14, 2025 by Vladimir Batagelj
# generalized cores

H <- new.env()

p_deg <- function(v,C,mode="all",loops=FALSE,weights=NULL){ 
  degree(C,v,mode=mode,loops=loops) }

p_wdeg <- function(v,C,mode="all",loops=FALSE,weights=NULL){
  strength(C,v,mode=mode,loops=loops,weights=weights) }

min_heapify <- function(i){
  l <- 2*i; r <- l+1
  if((l<=H$size)&&(H$p[l]<H$p[i])) mi <- l else mi <- i
  if((r<=H$size)&&(H$p[r]<H$p[mi])) mi <- r
  if(mi!=i){vi <- H$v[i]; vm <- H$v[mi]; H$idx[vi] <- mi; H$idx[vm] <- i
    swap(H$p[i],H$p[mi]); swap(H$v[i],H$v[mi]); min_heapify(mi)}
}

build_min_heap <- function(){
  for(i in trunc(H$size/2):1) min_heapify(i)
}

promote <- function(i){
  s <- i
  repeat{ f <- s %/% 2
    if((f<=0)||(H$p[f]<=H$p[s])) break
    vf <- H$v[f]; vs <- H$v[s]; H$idx[vf] <- s; H$idx[vs] <- f
    swap(H$p[f],H$p[s]); swap(H$v[f],H$v[s]); s <- f
  }
}

cores <- function(N,p=p_deg,mode="all",loops=FALSE,weights=NULL){
  n <- vcount(N); C <- N; H$size <- n  
  H$p <- rep(NA,n); H$v=1:n; H$idx <- 1:n; H$core <- rep(NA,n)
  for(v in V(N)) H$p[v] <- p(v,N,mode=mode,loops=loops,weights=weights)
  build_min_heap()
  while(H$size > 0){
    top <- H$v[1]; H$core[top] <- value <- H$p[1]
    St <- incident(C,top,mode="all") 
    Nt <- difference(union(tail_of(C,St),head_of(C,St)),top) 
    C <- delete_edges(C,St)
    H$v[1] <- H$v[H$size]; H$p[1] <- H$p[H$size];
    H$size <- H$size - 1; min_heapify(1)
    for(v in Nt){vi <- as.integer(v); j <- H$idx[vi]
      H$p[j] <- max(value,p(vi,C,mode=mode,loops=loops,weights=weights))
      promote(j)
    }
  }
  return(H$core)
}

