# netsWeight
# by Vladimir Batagelj
# May 29, 2025 -


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


