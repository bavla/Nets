# NetsJSON

```
# archiving networks in JSON

> library(jsonlite)
> write_graph_netsJSON(T,file="test1.json")
> TT <- netsJSON_to_graph(fromJSON("test1.json"),directed=TRUE)
> TT
IGRAPH 0e9ae04 DNW- 9 13 -- 
+ attr: by (g/c), cdate (g/c), title (g/c), network (g/c), org (g/n), nNodes (g/n),
| nArcs (g/n), nEdges (g/n), meta (g/x), name (v/c), age (v/n), sex (v/l), x (v/n), y
| (v/n), fact (v/n), deg (v/n), type (e/c), weight (e/n)
+ edges from 0e9ae04 (vertex names):
 [1] Ana  ->Bor   Ana  ->Cene  Eva  ->Bor   Cene ->Ana   Jan  ->Gaj   Gaj  ->Dana  Iva  ->Franc
 [8] Cene ->Gaj   Gaj  ->Ana   Bor  ->Franc Franc->Dana  Gaj  ->Bor   Iva  ->Jan  
> V(TT)[[]]
+ 9/9 vertices, named, from 0e9ae04:
   name age   sex      x      y   fact deg
1   Ana  20  TRUE 0.1429 0.4882 0.2500   4
...
9   Jan  19 FALSE 0.7615 0.7889 0.5000   2
> E(TT)[[]]
+ 13/13 edges from 0e9ae04 (vertex names):
    tail  head tid hid type weight
1    Ana   Bor   1   2  arc      3
...
13   Iva   Jan   8   9  arc      5
>


```

```

```


```

```

<hr />

[How to](./README.md)
