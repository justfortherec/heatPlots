#######################
##### Prepare data ####

# Data must be available at path specified in data.dir. All csv files are read into one data frame.

# It is assumed that
# * Data is separated by whitespace (spaces, tabs, ...);
# * No header line is present;
# * Order of the columns is:
#     N, M, k, p (as specified as input parameters for heat) followed by
#     all columns which are printed to stdout by heat (We just take the last line of each run.)


# Read all csv files in the data directory into one dataframe
csv.header <- c('N', 'M', 'k', 'p', 'Iterations', 'T.min', 'T.max', 'T.diff', 'T.avg', 'Time', 'FLOPs')
df <- do.call('rbind', lapply(list.files(pattern="*.csv$"), function(x) read.csv(x, sep='', header=FALSE, col.names=csv.header)))

# Compute means of columns Time and FLOPs 
df.mean <- aggregate(cbind(Time, FLOPs) ~ N + M + k + p, FUN=mean, data=df)
# Compute standard deviations
df.sd <- aggregate(cbind(Time, FLOPs) ~ N + M + k + p, FUN=sd, data=df)

# Get all possible combinations of MxN
dimensions <- unique(cbind(df.mean$M, df.mean$N))
# Get all values of p (number of threads)
no.of.threads <- unique(df.mean$p)