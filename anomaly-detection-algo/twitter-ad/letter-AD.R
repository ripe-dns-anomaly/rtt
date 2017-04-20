#letter-level anomaly detection for the Roots
#giovane moura
#giovane.moura@sidn.nl
#GPL license
#2017-04-20

#read the input file (.csv)
#format: timestamp,nSites,q25rtt,q50rtt,q75rtt,q90rtt

args = commandArgs(trailingOnly=TRUE)
#that's Twitter's library
library(AnomalyDetection)

# test if there is at least 2 arguments: if not, return an error
if (length(args)==0) {

  stop("At least tw0 argument must be supplied (input file).n", call.=FALSE)

} else if (length(args)==2) {
  # default output file
  inFile <- args[1]
  outFile <- paste(getwd(),args[2],sep="/")
}

reg<-read.csv(file=inFile, sep=',',h=T)


#if there's data to analyze
if (length(reg$nSites) >  1)
{

    #for each column, run the algorithm of anomaly detection
      for(i in names(reg))
      {

          if (i!="timestamp")
          {


            #we need to evaluate also these parameters here
            #first: max_anoms tunes how sensitive is the algorithm.
            #direction= which direction the anomalies shoudl be. for a letter,  it is both
            #period= what is the period of the data (in number of intervals, I use two but the data should
            # be stable, I believe.. need to see the real data
            res = AnomalyDetectionVec(reg[,i], max_anoms=0.02, direction='both',plot=FALSE,period=2)


            #then, write it out

            a=toString(res$anoms$index)

            b=toString(res$anoms$anoms)
            inx=reg$timestamp[as.numeric(a)]
            anomaly=paste(inx,",",i,",",a,",",b)

            #please notice that we re-run the algorith for all the datasets -- so anomalies may "disappear"
            #write(toStr res = AnomalyDetectionVec(reg$i, max_anoms=0.02, direction='both',plot=FALSE,period=2)
            #then, write it out

           # a=toString(res$anoms$index)
           # b=toString(res$anoms$anoms)
            #anomaly=paste(a,",",b)
            #please notice that we re-run the algorith for all the datasets -- so anomalies may "disappear"
            write(toString(anomaly), file=outFile,append=TRUE)
          }
      }
}

