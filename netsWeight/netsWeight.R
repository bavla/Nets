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

empty <- character(0)

normalize <- function(x,marg=0) return ((1-2*marg)*(x-min(x))/(max(x)-min(x))+marg)

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
  
node_cut <- function(N,atn,t){
  v <- vertex_attr(N,atn); vCut <- V(N)[v>=t] 
  return(induced_subgraph(N,vCut))
}

link_cut <- function(N,atn,t){
  w <- edge_attr(N,atn); eCut <- E(N)[w>=t] 
  return(subgraph_from_edges(N,eCut))
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

#
# PathFinder
# http://pajek.imfm.si/lib/exe/fetch.php?media=slides:pfxxx.pdf
# by Vladimir Batagelj, December 24-28, 2011
#
# PathFinder(D,r,q) - determines the skeleton of network represented by
# matrix D . The weights in D should be dissimilarities; the value 0
# denotes nonlinked nodes.
# r - is the parameter in Minkowski operation 
# q - is the limit on the length of considered paths; if q >= n-1
#     all paths are considered.
#
# PathFinderSim(S,r,q,s) - is a version of PathFinder for the case
# when the weights are similarities.
# s - determines how the similarity is transformed into dissimilarity
#   s = 1 -  D = 1+max S - S
#   s = 2 -  D = 1/S
# In the resulting skeleton the weights are the original similarities.

MultiplyMink <- function(A,B,r){
  n <- nrow(A); C <- matrix(Inf,nrow=n,ncol=n)
  if(is.infinite(r)){
    for(i in 1:n) for(j in 1:n) C[i,j] <- min(pmax(A[i,],B[,j]))
  } else if (r==1){
    for(i in 1:n) for(j in 1:n) C[i,j] <- min(A[i,]+B[,j])
  } else {
    for(i in 1:n) for(j in 1:n) C[i,j] <- min((A[i,]^r+B[,j]^r)^(1/r))
  }  
  C
}

PowerMink <- function(W,r,q){
  n <- nrow(W); W[W==0] <- Inf; diag(W) <- 0
  T <- matrix(Inf,nrow=n,ncol=n); diag(T) <- 0
  if (q > 0) {
    i <- q; S <- W
    repeat{
      if ((i %% 2) == 1) { T <- MultiplyMink(T,S,r) }
      i <- i %/% 2; if (i == 0)  break
      S <- MultiplyMink(S,S,r)
    }
  }
  rownames(T) <- colnames(T) <- rownames(W)
  T
}

ClosureMink <- function(W,r){
  n <- nrow(W); W[W==0] <- Inf; diag(W) <- 0
  if(is.infinite(r)){
    for(k in 1:n) for(i in 1:n) W[i,] <- pmin(W[i,],pmax(W[i,k],W[k,]))
  } else if (r==1){
    for(k in 1:n) for(i in 1:n) W[i,] <- pmin(W[i,],(W[i,k]+W[k,]))
  } else {
    for(k in 1:n) for(i in 1:n) W[i,] <- pmin(W[i,],(W[i,k]^r+W[k,]^r)^(1/r))
  }
  W
}

PathFinder <- function(D,r=Inf,q=Inf,eps=0.0000001){ 
  if(r<1) stop("Error: r < 1")
  if(q>=nrow(D)-1) {D[(D>0)&(abs(D-ClosureMink(D,r))>eps)] <- 0
  } else {D[(D>0)&(abs(D-PowerMink(D,r,q))>eps)] <- 0}
  D 
}

PathFinderSim <- function(S,r=Inf,q=Inf,s=1,eps=0.0000001){
  if(r<1) stop("Error: r < 1")
  n <- nrow(S); D <- S
  if(s==1) {D[S>0] <- 1+max(S)-S[S>0]} else {D[S>0] <- 1/S[S>0]}; 
  if(q>=n-1) {S[(S>0)&(abs(D-ClosureMink(D,r))>eps)] <- 0
  } else {S[(S>0)&(abs(D-PowerMink(D,r,q))>eps)] <- 0}
  S 
}

# setwd("C:/Users/Batagelj/work/R/pf")
# PF <- PathFinder(n1,1,Inf)
# savenetwork(PF,'PFtest.net')

# cat(date(),"\n"); PF2 <- PathFinderSim(n2,1,Inf,2); cat(date(),"\n"); 
# savenetwork(PF2,'PF2500.net'); cat(date(),"\n")

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

write_graph_paj <- function(N,file="test.paj",vname="name",coor=NULL,va=NULL,ea=NULL,
  weight="weight",ecolor="color"){
  n <- gorder(N); m <- gsize(N); ga <- graph_attr_names(N)
  if(is.null(va)) va <- vertex_attr_names(N)
  if(is.null(ea)) ea <- edge_attr_names(N)
  va <- union(va,vname); ea <- union(ea,weight)
  paj <- file(file,"w")
  cat("*network",file,"\n",file=paj)
  cat("% saved from igraph ",format(Sys.time(), "%a %b %d %X %Y"),"\n",sep="",file=paj)
  for(a in ga) cat("% ",a,": ",graph_attr(N,a),"\n",sep="",file=paj)
  cat('*vertices ',n,'\n',file=paj)
  lab <- if(vname %in% va) vertex_attr(N,vname) else paste("v",1:n,sep="") 
  if(is.null(coor)){  
    if(vname %in% va) for(v in V(N)) cat(v,' "',lab[v],'"\n',sep="",file=paj)
  } else { 
    for(v in V(N)) cat(v,' "',lab[v],'" ',paste(coor[v,],collapse=" "),'\n',sep="",file=paj) 
  }
  va <- setdiff(va,vname)
  cat(ifelse(is_directed(N),"*arcs\n","*edges\n"),file=paj)
  K <- ends(N,E(N),names=FALSE) 
  w <- if(weight %in% ea) edge_attr(N,weight) else rep(1,m)
  if(ecolor %in% ea){ C <- edge_attr(N,ecolor)
    for(e in 1:m) cat(K[e,1]," ",K[e,2]," ",w[e]," c ",as.character(C[e]),"\n",sep="",file=paj)
  } else 
    for(e in 1:m) cat(K[e,1]," ",K[e,2]," ",w[e],"\n",sep="",file=paj)
  ea <- setdiff(ea,c(weight,ecolor)); nr <- 1
  for(a in ea){nr <- nr+1; w <- edge_attr(N,a)
    cat(ifelse(is_directed(N),"*arcs","*edges"),file=paj)
    cat(" :",nr,' "',a,'"\n',sep="",file=paj)
    if(is.numeric(w)){
      for(e in 1:m) cat(K[e,1]," ",K[e,2]," ",w[e],"\n",sep="",file=paj)
    } else if(is.character(w)){ 
      W <- factor(w); lev <- levels(W)
      for(i in seq_along(lev)) cat("%",i,"-",lev[i],"\n",file=paj)
      for(e in 1:m) cat(K[e,1]," ",K[e,2]," ",W[e],' l "',w[e],'"\n',sep="",file=paj)
    } else warning(paste("unsupported type of",a),call.=FALSE)
  }
  cat("\n",file=paj)
  for(a in va){
    S <- vertex_attr(N,a); ok <- TRUE
    if(is.character(S)||is.logical(S)){
      cat("*partition ",a,"\n",sep="",file=paj)
      s <- factor(S); lev <- levels(s)
      for(i in seq_along(lev)) cat("%",i,"-",lev[i],"\n",file=paj)
    } else if(is.numeric(S)){ 
      s <- S; cat("*vector ",a,"\n",sep="",file=paj) 
    } else {warning(paste("unsupported type of",a),call.=FALSE); ok <- FALSE}
    if(ok){cat('*vertices ',n,'\n',file=paj)
      for(v in 1:n) cat(s[v],"\n",file=paj)
      cat("\n",file=paj) }
  }
  close(paj)
}

# June 12/14, 2025 by Vladimir Batagelj
# generalized cores

H <- new.env()

# degree
p_deg <- function(v,C,mode="all",loops=FALSE,weights=NULL,attr="deg"){ 
  degree(C,v,mode=mode,loops=loops) }

# weighted degree
p_wdeg <- function(v,C,mode="all",loops=FALSE,weights="weight",attr="deg"){
  strength(C,v,mode=mode,loops=loops,weights=edge_attr(C,weights)) }

# max on star links
p_wmax <- function(v,C,mode="all",loops=FALSE,weights="weight",attr="deg"){ 
  Sv <- incident(C,v,mode=mode);
  ifelse(length(Sv)>0,max(edge_attr(C,weights,Sv)),0) }

# sum on neighbors
p_nsum <- function(v,C,attr="deg",mode="all",loops=FALSE,weights="weight"){
  Sv <- incident(C,v,mode=mode)
  Nv <- union(tail_of(C,Sv),head_of(C,Sv)) 
  if(!loops) Nv <- difference(Nv,v) 
  ifelse(length(Nv)>0,sum(vertex_attr(C,attr,Nv)),0) }

# max on neighbors
p_nmax <- function(v,C,attr="deg",mode="all",loops=FALSE,weights="weight"){ 
  Sv <- incident(C,v,mode=mode)
  Nv <- union(tail_of(C,Sv),head_of(C,Sv)) 
  if(!loops) Nv <- difference(Nv,v) 
  ifelse(length(Nv)>0,max(vertex_attr(C,attr,Nv)),0) }

# neighbors diversity
p_ncard <- function(v,C,attr="deg",mode="all",loops=FALSE,weights="weight"){
  Sv <- incident(C,v,mode=mode)
  Nv <- union(tail_of(C,Sv),head_of(C,Sv)) 
  if(!loops) Nv <- difference(Nv,v) 
  ifelse(length(Nv)>0,length(union(c(),vertex_attr(C,attr,Nv))),0) }

# star links diversity
p_lcard <- function(v,C,attr="deg",mode="all",loops=FALSE,weights="weight"){
  Sv <- incident(C,v,mode=mode)
  ifelse(length(Sv)>0,length(union(c(),edge_attr(C,weights,Sv))),0) }
 

min_heapify <- function(f){
  repeat{ l <- 2*f; r <- l+1
    if((l<=H$size)&&(H$p[l]<H$p[f])) s <- l else s <- f
    if((r<=H$size)&&(H$p[r]<H$p[s])) s <- r
    if(s==f) break
    vf <- H$v[f]; vs <- H$v[s]; H$idx[vf] <- s; H$idx[vs] <- f
    swap(H$p[f],H$p[s]); swap(H$v[f],H$v[s]); f <- s
  }
}

build_min_heap <- function(){
  for(i in trunc(H$size/2):1) min_heapify(i)
}

promote <- function(s){
  repeat{ f <- s %/% 2
    if((f<=0)||(H$p[f]<=H$p[s])) break
    vf <- H$v[f]; vs <- H$v[s]; H$idx[vf] <- s; H$idx[vs] <- f
    swap(H$p[f],H$p[s]); swap(H$v[f],H$v[s]); s <- f
  }
}

cores <- function(N,p=p_deg,mode="all",loops=FALSE,weights="weight",attr="deg"){
  n <- vcount(N); C <- N; H$size <- n  
  H$p <- rep(NA,n); H$v=1:n; H$idx <- 1:n; H$core <- rep(NA,n)
  for(v in V(N)) H$p[v] <- p(v,N,mode=mode,loops=loops,weights=weights,attr=attr)
  build_min_heap()
  while(H$size > 0){
    top <- H$v[1]; H$core[top] <- value <- H$p[1]
    St <- incident(C,top,mode="all") 
    Nt <- difference(union(tail_of(C,St),head_of(C,St)),top) 
    C <- delete_edges(C,St)
    H$v[1] <- H$v[H$size]; H$p[1] <- H$p[H$size];
    H$size <- H$size - 1; min_heapify(1)
    for(v in Nt){vi <- as.integer(v); j <- H$idx[vi]
      H$p[j] <- max(value,p(vi,C,mode=mode,loops=loops,weights=weights,attr=attr))
      promote(j)
    }
  }
  return(H$core)
}

# SPC weights

add_init_term <- function(C){
# adding common intial node _I_ and terminal node _T_
  Init <- which(degree(C,mode="in")==0); Term <- which(degree(C,mode="out")==0) 
  C <- add_vertices(C,2,id=c("_I_","_T_"),name=c("_I_","_T_"))
  vt <- vcount(C); vi <- vt-1
  ea <- as.vector(rbind(c(rep(vi,length(Init)),Term),c(Init,rep(vt,length(Term)))))
  return(add_edges(C,ea))
}

# LJ / Limassol, July 4-5, 2025
SPC_weights <- function(C){
  if(!is_acyclic(C)) stop("network is not acyclic")
  n <- vcount(C); m <- ecount(C)
  C <- add_init_term(C) # standardized network
  Ni <- No <- rep(0,vcount(C))
  s <- topo_sort(C,mode="out")
  for(v in s) { S <- incident(C,v,mode="in")
    if(length(S)==0) Ni[v] <- 1 else{ cnt <- 0
      for(a in S) cnt <- cnt + Ni[tail_of(C,a)]
      Ni[v] <- cnt }
  }
  s <- topo_sort(C,mode="in")
  for(v in s) { S <- incident(C,v,mode="out")
    if(length(S)==0) No[v] <- 1 else{ cnt <- 0
      for(a in S) cnt <- cnt + No[head_of(C,a)]
      No[v] <- cnt }
  }
  w <- rep(0,ecount(C))
  for(a in E(C)) w[a] <- Ni[tail_of(C,a)]*No[head_of(C,a)]
  S <- incident(C,"_T_",mode="in"); flow <- 0
  for(a in S) flow <- flow + w[a]
  return(list(flow=flow,SPC=w[1:m],Ni=Ni[1:n],No=No[1:n]))
}

# Limassol, July 5-6, 2025
CPM_path <- function(C,SPC="SPC"){
  n <- vcount(C); m <- ecount(C)
  M <- rep(0,n); F <- vector("list",n)
  s <- topo_sort(C,mode="out")
  w <- edge_attr(C,SPC)
  for(v in s){ S <- incident(C,v,mode="in")
    if(length(S)>0) for(a in S) { u <- as.integer(tail_of(C,a))
      wu <- M[u] + w[a]
      if(wu == M[v]) F[[v]] <- c(F[[v]],u) else {
      if(wu > M[v]) { M[v] <- wu; F[[v]] <- u }} 
    }
  }
  Term <- which(degree(C,mode="out")==0); D <- max(M[Term])
  Q <- as.integer(Term[M[Term]==D]); P <- NULL
  while(length(Q)>0){
    v <- Q[1]; Q <- Q[-1]; k <- length(F[[v]])
    P <- cbind(P,rbind(F[[v]],rep(v,k)))
    Q <- union(Q,F[[v]])
  }
  return(as.vector(P))
}

# Limassol, July 6-7, 2025
main_path <- function(C,SPC="SPC"){
  w <- edge_attr(C,SPC); D <- max(w)
  M <- B <- F <- which(w==D)
  while(length(F)>0){ # forward
    a <- F[1]; F <- F[-1]
    L <- incident(C,head_of(C,a),mode="out")
    if(length(L)>0){
      wa <- w[L]; D <- max(wa); S <- which(wa==D)
      F <- union(F,L[S]); M <- union(M,L[S])
    }
  }
  while(length(B)>0){ # backward
    a <- B[1]; B <- B[-1]
    L <- incident(C,tail_of(C,a),mode="in")
    if(length(L)>0){
      wa <- w[L]; D <- max(wa); S <- which(wa==D)
      B <- union(B,L[S]); M <- union(M,L[S])
    }
  }
  return(M)
}

# Triangles / 3-rings
# Limassol, July 9, 2025 by Vladimir Batagelj
rings3 <- function(N,inp=TRUE,out=TRUE,cyc=TRUE,tra=TRUE){
  if(is_directed(N)){
    inp3 <- out3 <- cyc3 <- tra3 <- NA
    if(inp) inp3 <- rep(0,gsize(N))
    if(out) out3 <- rep(0,gsize(N))
    if(cyc) cyc3 <- rep(0,gsize(N))
    if(tra) tra3 <- rep(0,gsize(N))
    for(a in E(N)) {
      u <- tail_of(N,a); v <- head_of(N,a);
      Uo <- neighbors(N,u,mode="out"); Ui <- neighbors(N,u,mode="in")
      Vo <- neighbors(N,v,mode="out"); Vi <- neighbors(N,v,mode="in")
      if(inp) inp3[a] <- length(intersect(Ui,Vi))
      if(out) out3[a] <- length(intersect(Uo,Vo))
      if(cyc) cyc3[a] <- length(intersect(Ui,Vo))
      if(tra) tra3[a] <- length(intersect(Uo,Vi))
    }
    return(list(dir=TRUE,inp3=inp3,out3=out3,cyc3=cyc3,tra3=tra3))
  } else {
    ring3 <- rep(0,gsize(N)) 
    for(e in E(N)) {
      u <- tail_of(N,e); U <- neighbors(N,u,mode="all")
      v <- head_of(N,e); V <- neighbors(N,v,mode="all")
      ring3[e] <- length(intersect(U,V))  
    }
    return(list(dir=FALSE,ring3=ring3))
  }
}

# Quadrangles / Undirected simple
# July 13-14, 2025 
rings4 <- function(N){
  W <- as_sparse_matrix(N)
  W2 <- W %*% W; diag(W2) <- 0
  m <- gsize(N); w <- rep(0,m)
  for(a in 1:m) {
    u <- as.integer(tail_of(N,E(N)[a]))
    v <- as.integer(head_of(N,E(N)[a]))
    suv <- 0; il <- W2@p[u]+1; ir <- W2@p[u+1]
    Nuv <- intersect(W2@i[il:ir]+1,neighbors(N,v,mode="in"))
    # Nuv <- setdiff(Nuv,c(u,v))
    for(t in Nuv) suv <- suv + max(0,W2[u,t]-1)*W[t,v]
    w[a] <- suv
  }
  return(w)
}

# C <- readRDS(file="class.rds")
# H <- simplify(as_undirected(C,mode="each")); E(H)$weight <- 1
# w <- rings4(H); lab <- as.character(w)
# plot(H,edge.width=1+0.3*w,edge.label=lab)


