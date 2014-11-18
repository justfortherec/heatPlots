
# Function to plot a barchart with standard deviation
plot.bars <- function(data, sd, title=NULL, sub=NULL, bar.names=NULL, bar.col=NULL, ylab=NULL, legend.text=NULL, legend.position='bottom', file.prefix=NULL, ...){

  # Save to pdf if suffix for filename is given.
  # Other options are png, jpeg, etc. For details try help(png) or similar.
  if(!is.null(file.prefix)) pdf(paste(file.prefix, '.pdf', sep=''))

  # Allow plots do be drawn outside plot region (i.e. legend)
  par(xpd=TRUE)

  # Get max height of bars + standard deviation
  y.height <- max(data + sd)

  mp <- barplot(
    data,
    beside=TRUE,
    main=title,
    sub=sub,
    ylim=c(0, y.height),
    ylab=ylab,
    names.arg=bar.names,
    las=3,
    col=bar.col,
    ...
  )

  # Length of bars at top and bottom of standard deviation
  epsilon=0.2

  # Draw standard deviations
  segments(mp, data - sd, mp, data + sd)
  segments(mp - epsilon, data - sd, mp + epsilon, data - sd)
  segments(mp - epsilon, data + sd, mp + epsilon, data + sd)

  # Add legend if legend.text is specified
  if(!is.null(legend.text)){      
    print(legend.position)
    legend(
      legend.position,
      legend=legend.text,
      horiz=FALSE,
      fill=bar.col,
      bty='o',
      bg=rgb(1, 1, 1, .7)
    )
  }

  # Close file if file was written
  if(!is.null(file.prefix)) dev.off()
}

# Call plot.bars with a subset of data and sd given
plot.subset <- function(data, sd, column, subset=TRUE, ...){
  plot.bars(
    data[which(subset), column],
    sd[which(subset), column],
    ...
  )
}
