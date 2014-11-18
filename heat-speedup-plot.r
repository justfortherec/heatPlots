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
title.speedup <- 'Speedup relative to sequential implementation'


#######################
##### Prepare data ####

# Change to data directory
setwd(data.dir)

# For details regarding data files read the included script prepare-data.r.
source(paste(script.dir, 'prepare-data.r', sep='/'))

# Create and switch to output directory
setwd(plots.dir)


#########################################
##### Cerate line plot for speedup ####

# Colors for the lines
line.colors <- rainbow(5)

# Six shapes for the points. These are empty box, circle, upwards triangle, diamond, downwards triangle, x
# If you need more, look in help(points)
point.shapes <- c(0:2, 5:6, 4) 

# Only get speedup for runs without reduction
subset <- df.mean$k != 1

# Compute relative speedup for each p and each dimension
speedups <- apply(
  dimensions, 1,
  function(dim){
    subset.filter <- subset & df.mean$N == dim[1] & df.mean$M == dim[2]
    baseline <- df.mean[which(subset.filter & df.mean$p == 0), 'Time']
    speedup <- baseline / df.mean[which(subset.filter), 'Time']
  }
)

# Write to pdf file. Remove this to see graph in your R IDE
# Other options are png, jpeg, etc. For details try help(png) or similar.
pdf('heat-speedup-nored.pdf')

# Create empty frame with x axis from 0 to 16 and y axis from 0 to the maximum of all speedups.
plot(0,0, xlim=c(0, 16), ylim=c(0, max(sapply(speedups, max))), type="n", xlab="Number of threads", ylab="Speedup", main=title.speedup)

# Add each of the speedup lines
for(i in 1:ncol(speedups)){
  lines(0:16, speedups[,i], col=line.colors[i], type='b', pch=point.shapes[i], lwd=3)
}

# Add dimensions to legend
legend.text <- apply(dimensions, 1, function(dim) sprintf('%dx%d', dim[1], dim[2]))
legend(
  'bottomright', 
  legend=legend.text, 
  title='Input dimensions',
  col=line.colors,
  lwd=3,
  pch=point.shapes
)

# Close pdf file. Remove if file is not opened with pdf() above.
dev.off()

##### Return to initial path ####
setwd(cur.dir)
