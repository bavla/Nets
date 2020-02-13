
biHist <- function(author,TQ,first,last,PDF=FALSE,w=6,h=4.2,
  col=c("blue","red"),cex.axis=0.7,cex.names=0.7){
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
    las=2, cex.axis=cex.axis, cex.names=cex.names, space=0, border = NA 
  )
  text(0,0.9*fs[index[length(index)]],author,pos=4)
  if(PDF) dev.off() 
}

siHist <- function(author,TQ,first,last,instant=TRUE,PDF=FALSE,w=6,h=4.2,
  col="blue",cex.axis=0.7,cex.names=0.7){
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
    las=2, cex.axis=cex.axis, cex.names=cex.names, space=0, border = NA 
  )
  text(0,0.9*max(D),author,pos=4)
  if(PDF) dev.off() 
}

coHist <- function(H1,H2,first,last,PDF=FALSE,w=6,h=4.2,
  col=c("purple4","royalblue1","tomato1"),cex.axis=0.7,cex.names=0.7){
  author1 <- H1[[1]]; TQ1 <- H1[[2]]
  author2 <- H2[[1]]; TQ2 <- H2[[2]]
  i <- 1; m <- nrow(TQ1)
  while(TQ1[i,3]<=0) i <- i+1
  ymin <- min(first,TQ1[i,1]); ymax <- max(last,TQ1[m,2])
  j <- 1; l <- nrow(TQ2)
  while(TQ2[j,3]<=0) j <- j+1
  ymin <- min(ymin,TQ2[j,1]); ymax <- max(ymax,TQ2[l,2])
  years <- ymin:ymax; n <- length(years); value1 <- rep(0,n) 
  year <- ymin; TQ1 <- rbind(TQ1,c(ymax+1,0,0)); k <- 1
  while(i<=m){
    while((year<TQ1[i,1])&(year<=ymax)){
      value1[k] <- 0; k <- k+1; year <- year+1}
    while((year<TQ1[i,2])&(year<=ymax)){
      value1[k] <- TQ1[i,3]; k <- k+1; year <- year+1}
    if(year>ymax) break
    i <- i+1
  }
  year <- ymin; TQ2 <- rbind(TQ2,c(ymax+1,0,0)); k <- 1
  value2 <- rep(0,n)
  while(j<=l){
    while((year<TQ2[j,1])&(year<=ymax)){
      value2[k] <- 0; k <- k+1; year <- year+1}
    while((year<TQ2[j,2])&(year<=ymax)){
      value2[k] <- TQ2[j,3]; k <- k+1; year <- year+1}
    if(year>ymax) break
    j <- j+1
  }
  range <- first:last; names <- as.character(range)
  c <- (value1+value2-abs(value1-value2))/2
  a <- value1-c; b <- value2-c
  for(j in 1:n) if(years[j]==first) break
  index <- j:(j+length(range)-1)  
  D <- rbind(c[index],a[index],b[index])
  label <- paste(author1,"+",author2,sep="")
  if(PDF) pdf(paste(label,".pdf",sep=""),width=w,height=h)
  par(mar=c(6,4,4,4))
  barplot(height=D, col=col, names.arg=names, 
    las=2, cex.axis=cex.axis, cex.names=cex.names, space=0, border = NA 
  )
  text(0,0.9*max(value1[index],value2[index]),label,pos=4)
  if(PDF) dev.off() 
}

