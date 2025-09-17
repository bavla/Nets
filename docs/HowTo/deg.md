# Degrees

```
# Edinburgh associative thesaurus / degree distributions

# https://github.com/bavla/Nets/blob/master/data/Pajek/dic/EAT/eat.md
# C:\Users\vlado\docs\papers\2025\Sunbelt\ws\R
# https://raw.githubusercontent.com/bavla/Nets/refs/heads/master/data/Pajek/dic/EAT/EATnew.net
> Nets <- "https://raw.githubusercontent.com/bavla/Nets/refs/heads/master/data/"
> setwd("C:/Users/Public/Sunbelt25")
> EAT <- read_graph(paste0(Nets,"Pajek/dic/EAT/EATnew.net"),format="pajek")
> EAT
> ad <- degree(EAT,mode="all",loops=TRUE)
> id <- degree(EAT,mode="in",loops=TRUE)
> od <- degree(EAT,mode="out",loops=TRUE)
> top(ad,10)
      name value
1       ME  1108
2      MAN  1074
> wad <- strength(EAT,mode="all",weights=E(EAT)$weight,loops=TRUE)
> wid <- strength(EAT,mode="in",weights=E(EAT)$weight,loops=TRUE)
> wod <- strength(EAT,mode="out",weights=E(EAT)$weight,loops=TRUE)
> top(wad,10)
    name value
1  MONEY  4484
2  WATER  3396
...
> top(wid,10)
> top(wod,10)
> w <- E(EAT)$weight
> E(EAT)[1:20]
> names(w) <- attr(E(EAT),"vnames")
> top(w,30)
                 name value
1            LOBE|EAR    91
2      CHEDDAR|CHEESE    90
3           HONG|KONG    89
...

> EAT$name <- "The Edinburgh Associative Thesaurus"
> EAT$url <- "https://github.com/bavla/Nets/blob/master/data/Pajek/dic/EAT/eat.md"
> EAT$by <- "Vladimir Batagelj"
> EAT$cdate <- "July 31, 2003"
> saveRDS(EAT,file="EATnew.rds")


> Ta <- table(ad); Ti <- table(id); To <- table(od)
> d <- as.integer(names(Ta)); f <- unname(Ta)
> di <- as.integer(names(Ti[Ti>0])); fi <- unname(Ti[Ti>0])
> do <- as.integer(names(To[To>0])); fo <- unname(To[To>0])
> plot(d,f,log="xy",axes=FALSE,pch=16,cex=0.8)
> axis(1); axis(2)
> points(di,fi,pch=16,cex=0.8,col="red")
> points(do,fo,pch=16,cex=0.8,col="blue")
> 

```

```

```


```

```

<hr />

[How to](./README.md)

