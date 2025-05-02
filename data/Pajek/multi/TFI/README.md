# TFI - UKRI's Transforming Foundation Industries Challenge

[Christopher Pilgrim TFI Network](https://public.flourish.studio/story/2938215/) created by [Christopher Pilgrim](https://iuk-business-connect.org.uk/people/christopher-pilgrim/) on 27 Feb 2025.
A [network diagram](https://public.flourish.studio/visualisation/20838395/) represents the organisations collaborating in projects supported by UKRI's Transforming Foundation Industries Challenge


The network description is contained in the [HTML page](https://flo.uri.sh/visualisation/20838395/embed). I extracted the JSON description of the network and save it in the file `Network.json`.
An inconsistency turned out in the original description - in links the label `UNIVERSITY COLLEGE LONDON` is used and in nodes the label `University College London`. 



```
> wdir <- "C:/data/flourish"
> setwd(wdir)
> library(jsonlite)
> TFI <- read_json("Network.json",simplifyVector=TRUE)
> names(TFI)
[1] "links" "nodes"
> typeof(TFI$links)
[1] "list"
> head(TFI$links)
                source                      target
1 WI INTERNATIONAL LTD             CAMBOND LIMITED
2 WI INTERNATIONAL LTD      LUNTS CASTINGS LIMITED
3 WI INTERNATIONAL LTD           Bangor University
4 WI INTERNATIONAL LTD Sheffield Hallam University
5 WI INTERNATIONAL LTD            SOLOMON & WU LTD
6      CAMBOND LIMITED        WI INTERNATIONAL LTD
> head(TFI$nodes)
      group                              id image                          metadata size
1    Metals   ABBEY FORGED PRODUCTS LIMITED         ABBEY FORGED PRODUCTS LIMITED,     1
2 Chemicals                 ACCELYO LIMITED                       ACCELYO LIMITED,     1
3    Cement AGGREGATE INDUSTRIES UK LIMITED       AGGREGATE INDUSTRIES UK LIMITED,     3
4 Chemicals              AGRIFOOD X LIMITED                    AGRIFOOD X LIMITED,     1
5     Other                  AKT II LIMITED                        AKT II LIMITED,     1
6    Metals                 Alleima Limited                       Alleima Limited,     1
> str(TFI)
List of 2
 $ links:'data.frame':  1472 obs. of  2 variables:
  ..$ source: chr [1:1472] "WI INTERNATIONAL LTD" "WI INTERNATIONAL LTD" "WI INTERNATIONAL LTD" "WI INTERNATIONAL LTD" ...
  ..$ target: chr [1:1472] "CAMBOND LIMITED" "LUNTS CASTINGS LIMITED" "Bangor University" "Sheffield Hallam University" ...
 $ nodes:'data.frame':  177 obs. of  5 variables:
  ..$ group   : chr [1:177] "Metals" "Chemicals" "Cement" "Chemicals" ...
  ..$ id      : chr [1:177] "ABBEY FORGED PRODUCTS LIMITED" "ACCELYO LIMITED" "AGGREGATE INDUSTRIES UK LIMITED" ...
  ..$ image   : chr [1:177] "" "" "" "" ...
  ..$ metadata:List of 177
  .. ..$ : chr [1:2] "ABBEY FORGED PRODUCTS LIMITED" ""
  .. ..$ : chr [1:2] "ACCELYO LIMITED" ""
  .. ..$ : chr [1:2] "AGGREGATE INDUSTRIES UK LIMITED" ""
  .. ..$ : chr [1:2] "AGRIFOOD X LIMITED" ""
  .. ..$ : chr [1:2] "AKT II LIMITED" ""
  .. ..$ : chr [1:2] "Manufacturing Technology Centre" ""
  .. .. [list output truncated]
  ..$ size    : chr [1:177] "1" "1" "3" "1" ...
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> uvLab2net(TFI$nodes$id,TFI$links$source,TFI$links$target,Net="TFI.net")
> vector2clu(TFI$nodes$size,Clu="TFIsize.vec")
> vecnom2clu(TFI$nodes$group,Clu="TFIgroup.clu")
```

In Pajek I joined all three files into a Pajek project file (manually added metadata) [TFI.paj](TFI.paj).
