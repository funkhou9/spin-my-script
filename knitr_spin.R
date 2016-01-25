# Designed to automatically submit an R script
# 	for literate programming conversion directly
#	to the MSU HPCC clusters.

library(knitr)


args <- commandArgs(TRUE)
file_name <- args[1]

knitr::spin(file_name)