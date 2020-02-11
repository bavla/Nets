
biHist <- function(author,TQ,first,last,PDF=FALSE,w=6,h=4.2,col=c("blue","red")){
  i <- 1; m <- nrow(TQ); k <- 1
  while(TQ[i,3]<=0) i <- i+1
  ymin <- min(first,TQ[i,1]); ymax <- max(last,TQ[m,2])   
  years <- ymin:ymax; n <- length(years); value <- rep(0,n) 
  year <- ymin; TQ <- rbind(TQ,c(ymax+1,0,0))
  while(i<=m){
    while((year<TQ[i,1])&(year<=ymax)){
      value[k] <- 0; k <- k+1; year <- year+1}
    while((year<TQ[i,2])&(year<=ymax)){
      value[k] <- TQ[i,3]; k <- k+1; year <- year+1}
    if(year>ymax) break
    i <- i+1
  }
  range <- first:last; names <- as.character(range)
  fs <- cumsum(value); fr <- fs-value;
  for(j in 1:n) if(years[j]==first) break
  index <- j:(j+length(range)-1)  
  D <- rbind(value[index],fr[index])
  if(PDF) pdf(paste(author,".pdf",sep=""),width=w,height=h)
  par(mar=c(6,4,4,4))
  barplot(height=D, col=col, names.arg=names, 
    las=2, cex.axis=0.7, cex.names=0.7, space=0, border = NA 
  )
  text(5,0.9*fs[index[length(index)]],author)
  if(PDF) dev.off() 
}

siHist <- function(author,TQ,first,last,instant=TRUE,PDF=FALSE,w=6,h=4.2,col="blue"){
  i <- 1; m <- nrow(TQ); k <- 1
  while(TQ[i,3]<=0) i <- i+1
  ymin <- min(first,TQ[i,1]); ymax <- max(last,TQ[m,2])   
  years <- ymin:ymax; n <- length(years); value <- rep(0,n) 
  year <- ymin; TQ <- rbind(TQ,c(ymax+1,0,0))
  while(i<=m){
    while((year<TQ[i,1])&(year<=ymax)){
      value[k] <- 0; k <- k+1; year <- year+1}
    while((year<TQ[i,2])&(year<=ymax)){
      value[k] <- TQ[i,3]; k <- k+1; year <- year+1}
    if(year>ymax) break
    i <- i+1
  }
  range <- first:last; names <- as.character(range)
  for(j in 1:n) if(years[j]==first) break
  index <- j:(j+length(range)-1); D <- value[index]
  if(!instant) D <- cumsum(value)[index] 
  if(PDF) pdf(paste(author,".pdf",sep=""),width=w,height=h)
  par(mar=c(6,4,4,4))
  barplot(height=D, col=col, names.arg=names, 
    las=2, cex.axis=0.7, cex.names=0.7, space=0, border = NA 
  )
  text(5,0.9*max(D),author)
  if(PDF) dev.off() 
}
