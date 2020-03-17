plot(Complete ~ d$TimeTotal,data=d,las=1,yaxt="n")
axis(side = 2, at=c(20,40,60,80,100)/100,labels = paste0(c(20,40,60,80,100),"%"), las=1)
points(Complete ~ TimeTotal ,data=subset(d,Fit=="yes"),col="salmon",pch=16)
points(Complete ~ TimeTotal ,data=subset(d,Fit=="no"),col="green",pch=16)

library(ggplot2)
ggplot(d,aes(x=TimeTotal, y= Complete,color=Fit))+geom_point(size=4)
