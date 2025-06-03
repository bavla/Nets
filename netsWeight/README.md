# netsWeight

<img src="./workIP.jpg" width="200" />

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

## References
