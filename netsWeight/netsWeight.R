# netsWeight
# by Vladimir Batagelj
# May 29, 2025 -
# ---------------------------------------------------------------
# implementing some Pajek's procedures in iGraph
#   additional functions used in igraph examples for the Network analysis
#   course at HSE Moscow in November 2017 and December 2018 by Vladimir Batagelj
# ---------------------------------------------------------------
# source("https://raw.githubusercontent.com/bavla/Nets/refs/heads/master/netsWeight/netsWeight.R")



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
    Nv <- incident(Net,v,mode=mode); Nw <- get.edge.attribute(Net,weight,Nv)
    p <- order(Nw,decreasing=TRUE)
    Na <- if(strict) Nv[p[1:k]] else Nv[Nw >= Nw[p[k]]]
    # Nnet <- add_edges(Nnet,Na)
    CC <- data.table(tail=tail_of(Net,Na),head=head_of(Net,Na))
    CC[[weight]] <- get.edge.attribute(Net,weight,Na)
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


