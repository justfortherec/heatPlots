heat plots
============

R script to generate plots to visualize performance of implementations of the heat dissipation problem (Programming Concurrent Systems at University of Amsterdam, 2014).

Use this to create bar plots of execution time and floating points per second, or line plots for speedup compared to a baseline implementation.

Data format
-----------

The scripts in the current state assumes the following format of data:

* Any number of .csv files in the `data` directory.
* The .csv files don't have a header row
* Columns are separated by whitespace (e.g. spaces or tabs)
* Columns are in the following order:
  + N
  + M
  + k
  + p
  + Iterations
  + T.min
  + T.max
  + T.diff
  + T.avg
  + Time
  + FLOPs

Columns N, M, k, and p should include the values passed to heat as command line arguments. Remaining columns are exactly the last line printed to stdout by heat.

To distinguish between parallel and sequential implementations, column p (which denotes the number of threads) should be set to 0 for performance data of a sequential executable.

The `data` directory already includes one correctly formated example file.

Usage
-----

These scripts can be used manually or unattended.

### Manual usage

Just dump all data (as described above) in the `data` directory and run `heat-bar-plots.r` or `heat-speedup-plot.r`. Plots are generated in `plots` as PDF files.

### Unattended usage

Call for instance `R --quiet --vanilla --slave --file=heat-speedup-plot.r`

License
-------

You can freely use this modest piece of code for whatever you want. I gladly accpet pull requests for fixes and improvements.

