
biHist <- function(author,TQ,first,last){
  i <- 1; k <- 1
  years <- first:last; n <- length(years); value <- rep(0,n) 
  year <- first; v <- 0; TQ <- rbind(TQ,c(last+1,0,0))
  while(i<=n){
    while((year<TQ[i,1])&(year<=last)){
      value[k] <- v; k <- k+1; year <- year+1}
    if(year>last) break
    v <- TQ[i,3]; i <- i+1
  }
  names <- as.character(years)
  fs <- cumsum(value); fr <- fs-value; D <- rbind(value,fr)
  par(mar=c(6,4,4,4))
  barplot(height=D, col=c("blue","red"), names.arg=names, 
    las=2, cex.axis=0.7, cex.names=0.7, space=0, border = NA 
  )
  text(5,0.9*max(fr),author)
}
