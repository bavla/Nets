# TFI - UKRI's Transforming Foundation Industries Challenge

[Christopher Pilgrim TFI Network](https://public.flourish.studio/story/2938215/) created by [Christopher Pilgrim](https://iuk-business-connect.org.uk/people/christopher-pilgrim/) on 27 Feb 2025.
A [network diagram](https://public.flourish.studio/visualisation/20838395/) represents the organisations collaborating in projects supported by UKRI's Transforming Foundation Industries Challenge


The network description is contained in the [HTML page](https://flo.uri.sh/visualisation/20838395/embed). I extracted the JSON description of the network and save it in the file `Network.json`.
An inconsistency turned out in the original description - in links the label `UNIVERSITY COLLEGE LONDON` is used and in nodes the label `University College London`. 



```
> setwd(wdir <- "C:/data/flourish")
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> library(jsonlite)
> TFI <- read_json("Network.json",simplifyVector=TRUE)
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
> uvLab2net(TFI$nodes$id,TFI$links$source,TFI$links$target,Net="TFI.net")
> vector2clu(TFI$nodes$size,Clu="TFIsize.vec")
> vecnom2clu(TFI$nodes$group,Clu="TFIgroup.clu")
```

In Pajek I joined all three files into a Pajek project file (manually added metadata) [TFI.paj](TFI.paj).
