# XY

```
# manually changing node positions

> Rnet <- "https://raw.githubusercontent.com/bavla/Rnet/"
> source(paste0(Rnet,"master/R/igraph+.R"))
> Pt <- tkplot(TT,800,800,edge.curved=0,edge.width=E(TT)$weight/5)
# tkplot window is still active
> coor <- tk_coords(Pt,norm=F) # save new coordinates
> tk_close(Pt)
> V(TT)$x <- coor[,1]; V(TT)$y <- coor[,2]

> # write_graph_paj(TT,file="test1.paj")
> # write_graph_paj(TT,file="test1.paj",coor=cbind(V(TT)$x,V(TT)$y),va=c("age","deg","sex"))
```

```

```


```

```

<hr />

[How to](./README.md)

