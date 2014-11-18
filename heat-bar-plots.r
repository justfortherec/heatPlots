##### Directories ####
# Change these to the actual paths

# Path where data is stored as .csv files
data.dir <- normalizePath('data')
# Path where plots are going to be stored
plots.dir <- normalizePath('plots')

# Current working directory is automatically stored
cur.dir <- getwd()
# Path where included scripts are stored
script.dir <- normalizePath('includes')


##### Define plot titles ####
title.flops <- 'Mean floating point operations per second'
title.time <- 'Mean execution time'


############################
##### Import functions #####
source(paste(script.dir, 'barplot-standarderror.r', sep='/'))


#######################
##### Prepare data ####

# Switch to data directory
setwd(data.dir)

# For details regarding data files read the included script prepare-data.r.
source(paste(script.dir, 'prepare-data.r', sep='/'))
       
# Switch to output directory
setwd(plots.dir)


#######################################
##### Bar plots for all dimensions ####
# Creates bar plots for each dimension (with and without reduction):
#  * Number of threads vs 'column.name'

for(row in 1:nrow(dimensions)){

  # Store current M and N
  M <- dimensions[row, 1]
  N <- dimensions[row, 2]

  # Locigal vector: TRUE if row has reduction disabled (k!=1) and dimensions match current M and N
  subset <- df.mean$k != 1 & df.mean$N == N & df.mean$M == M

  # Bar plot for FLOPs with reduction disabled
  plot.subset(
    df.mean,
    df.sd,
    column='FLOPs',
    subset=subset,
    title=title.flops,
    sub=paste(M, 'x', N, ' without reduction'),
    bar.names=sprintf('p: %d', df.mean[which(subset), 'p']),
    ylab='FLOP/s',
    file.prefix=paste('flops-', M, 'x', N, '-nored', sep='')
  )

  # Bar plot for Time with reduction disabled
  plot.subset(
    df.mean,
    df.sd,
    column='Time',
    subset=subset,
    title=title.time,
    sub=paste(M, 'x', N, ' without reduction'),
    bar.names=sprintf('p: %d', df.mean[which(subset), 'p']),
    ylab='seconds',
    file.prefix=paste('time-', M, 'x', N, '-nored', sep='')
  )

  # And the same with reduction enabled (k==1)
  subset <- df.mean$k == 1 & df.mean$N == N & df.mean$M == M

  # Bar plot for FLOPs with reduction enabled
  plot.subset(
    df.mean,
    df.sd,
    column='FLOPs',
    subset=subset,
    title=title.flops,
    sub=paste(M, 'x', N, ' with reduction'),
    bar.names=sprintf('p: %d', df.mean[which(subset), 'p']),
    ylab='FLOP/s',
    file.prefix=paste('flops-', M, 'x', N, '-red', sep='')
  )

  # Bar plot for Time with reduction enabled
  plot.subset(
    df.mean,
    df.sd,
    column='Time',
    subset=subset,
    title=title.time,
    sub=paste(M, 'x', N, ' with reduction'),
    bar.names=sprintf('p: %d', df.mean[which(subset), 'p']),
    ylab='seconds',
    file.prefix=paste('time-', M, 'x', N, '-red', sep='')
  )
}

##### Return to initial path ####
setwd(cur.dir)
