#Function to plot lakes from two sources
  #find a lake in spdf HUC01
  #create a bounding box around the lake and increase the size by a scaling percentage
  #find lakes in WBIDLakes that intersect the boundary box
  #plot results
  #choose the HUC01 lake

  plotLakes<-function(WBID=1720193,Scale=.2){
    a1<-HUC01[V2@data$COMID==WBID,] #get lake
  #create boundary box polygon
    bb<-bbox(a1) #get the bbox
      #scale the box
        dx<-(bb[1,2]-bb[1,1])*Scale
        dy<-(bb[2,2]-bb[2,1])*Scale
        X<-c(bb[1,1]-dx,bb[1,2]+dx)
        Y<-c(bb[2,1]-dy,bb[2,2]+dy)
        bb<-rbind(X,Y)
      #create bbox polygon object
        xpol<-c(bb[1,1],bb[1,2],bb[1,2],bb[1,1],bb[1,1])
        ypol<-c(bb[2,1],bb[2,1],bb[2,2],bb[2,2],bb[2,1])
        pol = SpatialPolygons(list(Polygons(list(Polygon(cbind(xpol,ypol))), ID="x1")),proj4string=Albers)
  #interect scaled bbox with WBIDLakes and create new SP object with these lakes
    keep<-gIntersects(WBIDLakes,pol,byid=TRUE)  #intersect step
    LakesV1<-WBIDLakes[drop(keep),]  #drop needed to reduce this to just the boolean
  #plot results
    plot(LakesV1,col='blue',border=NA)  
    plot(a1,col=NA,border='red',lwd=2,add=TRUE)
    #text(coordinates(LakesV1), labels=LakesV1@data$WB_ID, cex=.8)
  }
plotLakes()
 