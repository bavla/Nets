
byYear <- function(TQ,i,ymin,ymax){
  n <- ymax-ymin+1; value <- rep(0,n); k <- 1; m <- nrow(TQ) 
  year <- ymin; TQ <- rbind(TQ,c(ymax+1,0,0))
  while(i<=m){
    while((year<TQ[i,1])&(year<=ymax)){
      value[k] <- 0; k <- k+1; year <- year+1}
    while((year<TQ[i,2])&(year<=ymax)){
      value[k] <- TQ[i,3]; k <- k+1; year <- year+1}
    if(year>ymax) break
    i <- i+1
  }
  return(value)
}

biHist <- function(H,first,last,PDF=FALSE,w=6,h=4.2,ylim=NULL,main=NULL,
  col=c("steelblue","khaki2"),cex.axis=0.7,cex.names=0.7,xpd=FALSE){
  author <- H[[1]]; TQ <- H[[2]]; i <- 1
  while(TQ[i,3]<=0) i <- i+1
  ymin <- min(first,TQ[i,1]); ymax <- max(last,TQ[nrow(TQ),2])   
  years <- ymin:ymax 
  value <- byYear(TQ,i,ymin,ymax)
  range <- first:last; names <- as.character(range)
  fs <- cumsum(value); fr <- fs-value;
  for(j in 1:length(years)) if(years[j]==first) break
  index <- j:(j+length(range)-1)  
  D <- rbind(value[index],fr[index])
  if(PDF) pdf(paste(author,".pdf",sep=""),width=w,height=h)
  par(mar=c(6,4,4,4))
  barplot(height=D, col=col, names.arg=names, las=2, 
    cex.axis=cex.axis, cex.names=cex.names, space=0, border = NA,
    ylim=ylim, main=main, xpd=xpd 
  )
  ylab <- if(is.null(ylim)) fs[index[length(index)]] else ylim[2] 
  text(0,0.9*ylab,author,pos=4)
  if(PDF) dev.off() 
}

siHist <- function(H,first,last,instant=TRUE,PDF=FALSE,w=6,h=4.2,
  col="blue",cex.axis=0.7,cex.names=0.7,ylim=NULL,main=NULL,xpd=FALSE){
  author <- H[[1]]; TQ <- H[[2]]; i <- 1
  while(TQ[i,3]<=0) i <- i+1
  ymin <- min(first,TQ[i,1]); ymax <- max(last,TQ[nrow(TQ),2])   
  years <- ymin:ymax 
  value <- byYear(TQ,i,ymin,ymax)
  range <- first:last; names <- as.character(range)
  for(j in 1:length(years)) if(years[j]==first) break
  index <- j:(j+length(range)-1); D <- value[index]
  if(!instant) D <- cumsum(value)[index] 
  if(PDF) pdf(paste(author,".pdf",sep=""),width=w,height=h)
  par(mar=c(6,4,4,4))
  barplot(height=D, col=col, names.arg=names, 
    las=2, cex.axis=cex.axis, cex.names=cex.names, space=0, border = NA,
    ylim=ylim, main=main, xpd=xpd 
  )
  ylab <- if(is.null(ylim)) max(D) else ylim[2] 
  text(0,0.9*ylab,author,pos=4)
  if(PDF) dev.off() 
}

coHist <- function(H1,H2,first,last,PDF=FALSE,w=6,h=4.2,ylim=NULL,
  main=NULL,col=c("purple4","royalblue1","tomato1"),cex.axis=0.7,
  cex.names=0.7,xpd=FALSE){
  author1 <- H1[[1]]; TQ1 <- H1[[2]]; author2 <- H2[[1]]; TQ2 <- H2[[2]]
  i <- 1; while(TQ1[i,3]<=0) i <- i+1
  ymin <- min(first,TQ1[i,1]); ymax <- max(last,TQ1[nrow(TQ1),2])
  j <- 1; while(TQ2[j,3]<=0) j <- j+1
  ymin <- min(ymin,TQ2[j,1]); ymax <- max(ymax,TQ2[nrow(TQ2),2])
  years <- ymin:ymax  
  value1 <- byYear(TQ1,i,ymin,ymax); value2 <- byYear(TQ2,j,ymin,ymax)
  range <- first:last; names <- as.character(range)
  c <- pmin(value1,value2); a <- value1-c; b <- value2-c
  for(j in 1:length(years)) if(years[j]==first) break
  index <- j:(j+length(range)-1)  
  D <- rbind(c[index],a[index],b[index])
  label <- paste(author1,"+",author2,sep="")
  if(PDF) pdf(paste(label,".pdf",sep=""),width=w,height=h)
  par(mar=c(6,4,4,4))
  barplot(height=D, col=col, names.arg=names, las=2,
    cex.axis=cex.axis, cex.names=cex.names, space=0, border = NA,
    ylim=ylim, main=main, xpd=xpd 
  )
  ylab <- if(is.null(ylim)) max(value1[index],value2[index]) else ylim[2] 
  text(0,0.9*ylab,label,pos=4)
  if(PDF) dev.off() 
}

