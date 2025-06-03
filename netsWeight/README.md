# netsWeight

`netsWeight` is an R package of functions extending iGraph with some Pajek functionalities.

```
source("https://raw.githubusercontent.com/bavla/Nets/refs/heads/master/netsWeight/netsWeight.R")
```

top <- function(v,k){

read_Pajek_clu <- function(f,skip=1){

read_Pajek_vec <- function(f,skip=1){

extract_clusters <- function(N,atn,clus){

interlinks <- function(N,atn,c1,c2,col1="red",col2="blue"){
  
vertex_cut <- function(N,atn,t){

edge_cut <- function(N,atn,t){

kNeighbors <- function(Net,k,weight="weight",mode="out",strict=TRUE,loops=FALSE){ 

network_reverse <- function(N){

as_sparse_matrix <- function(N,weight="weight"){

mult_network_vector <- function(N,v,mode="row",weight="weight"){


cross_networks <- function(N1,N2,side="left",weight="weight",twomode=TRUE){

mult_networks <- function(N1,N2,weight="weight",twomode=TRUE){

normalize_matrix_Markov <- function(M){

normalize_matrix_Newman <- function(M){

normalize_matrix_Balassa <- function(M){

normalize_matrix_activity <- function(M){

normalize_matrix_RSI <- function(M){

