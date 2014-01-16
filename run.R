ptm<-proc.time()
require(plyr)
ft_sum <- function(ftable) {
        return(sum(ftable[,1]))
}

ft_mean <- function(ftable,sum) {
        total=0
        for(i in 1:length(ftable[,1])) {
                total=total+ftable[i,1]*ftable[i,2]
        }
        return(total/sum)
}

ft_std <- function(ftable,mean,sum) {
	total=0
	for(i in 1:length(ftable[,1])) {
		total=total+(ftable[i,2]-mean)*(ftable[i,2]-mean)*ftable[i,1]
	}
	return(sqrt(total/sum))
}

ft_med <- function(ftable,sum) {
	csize=0
	med=0
	for(i in 1:length(ftable[,1])) {
		if(csize < sum/2 && sum/2 <= csize+ftable[i,1]) {
			med=ftable[i,2]
			break
		}
		csize=csize+ftable[i,1]
	}
	return(med)
}

#table=system('tar -Oxf FILAENAME | cut -d , -f 15 | sed \'1d\' | sort | uniq -c | sort -k 1 -r | awk \'{ print $1 "\t" $2}\')'
ftable=system(sprintf("cat %s | cut -d , -f 15 | sed \'1d\' | sort | uniq -c | sort -k 2 -g -r | grep -v NA | awk \'{ print $1 \"\t\" $2}\'",commandArgs()[4]),intern=TRUE)
ftable=ldply(strsplit(ftable,'\t'))
ftable$V1=as.numeric(ftable$V1)
ftable$V2=as.numeric(ftable$V2)

sum=ft_sum(ftable)
mean=ft_mean(ftable,sum)
std=ft_std(ftable,mean,sum)
med=ft_med(ftable,sum)
proc_time=proc.time()-ptm
cat("Mean: ",mean,"\n")
cat("Std: ",std,"\n")
cat("Med: ",med,"\n")
cat("Time: ",proc_time[3],"\n")
info=list(proc_time=proc_time[3], time = time, results = c(mean = mean, median = med, sd = std),system = Sys.info(),  session = sessionInfo())
save(info,file="results1.rda")

