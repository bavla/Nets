<img src="./workIP.jpg" width="200" />

# netsWeight


`netsWeight` is an R package of functions extending iGraph with some Pajek functionalities.

```
source("https://raw.githubusercontent.com/bavla/Nets/refs/heads/master/netsWeight/netsWeight.R")
```
## Functions

### top(v,k)

### read_Pajek_clu(f,skip=1)

### read_Pajek_vec(f,skip=1)

### extract_clusters(N,atn,clus)

### interlinks(N,atn,c1,c2,col1="red",col2="blue")
  
### vertex_cut(N,atn,t)

### edge_cut(N,atn,t)

### kNeighbors(Net,k,weight="weight",mode="out",strict=TRUE,loops=FALSE) 

### network_reverse(N)

### as_sparse_matrix(N,weight="weight")

### mult_network_vector(N,v,mode="row",weight="weight")

### cross_networks(N1,N2,side="left",weight="weight",twomode=TRUE)

### mult_networks(N1,N2,weight="weight",twomode=TRUE)

### normalize_matrix_Markov(M)

### normalize_matrix_Newman(M)

### normalize_matrix_Balassa(M)

### normalize_matrix_activity(M)

### normalize_matrix_RSI(M)

### Salton(W)

### Euclid(W)

### CorSalton(W)

### CorEuclid(W)

sym_net <- function(N){
  T <- as_adjacency_matrix(N,attr="weight")
  d <- diag(T)
  TT <- 2*T
  diag(TT) <- d
  return( graph_from_adjacency_matrix(TT,
    mode="undirected",weighted="weight") )
}

Co_net <- function(N){
  return(sym_net(cross_networks(N,N,twomode=FALSE)))
}

Cn_net <- function(N){ 
  return(sym_net(graph_from_adjacency_matrix(
          crossprod(
           normalize_matrix_Markov(as_sparse_matrix(N))),
         mode="undirected",weighted="weight")))
}

Cs_net <- function(N){
  KS <- as_sparse_matrix(N)
  KCs <- crossprod(
    normalize_matrix_Markov(KS),
    normalize_matrix_Newman(KS))
  diag(KCs) <- 0
  return(sym_net(graph_from_adjacency_matrix(
    KCs,weighted="weight")))
}
### authors(L)

### write_graph_netsJSON(N,file="test.json",vname="name",leg=list() )

### netsJSON_to_graph(J,directed=FALSE)

## References

  - Batagelj, V. On fractional approach to analysis of linked networks. [Scientometrics](https://link.springer.com/article/10.1007/s11192-020-03383-y) 123, 621–633 (2020). https://doi.org/10.1007/s11192-020-03383-y
  - Batagelj, V., Zaveršnik, M. Fast algorithms for determining (generalized) core groups in social networks. [Adv Data Anal Classif](https://doi.org/10.1007/s11634-010-0079-y) 5, 129–145 (2011). https://doi.org/10.1007/s11634-010-0079-y



