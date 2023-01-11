#step one - read in all data frames
#setwd(choose.dir(default = "S:/LAB-titus004/LiviaSongster/Analysis", caption = "Select folder with all analysis dirs"))
setwd(choose.dir(default = "E:/Sspa-ssoa-blinded/Tips/Linescan-Results", caption = "Select folder with all analysis dirs"))

rm(list=ls())
home <- getwd()
dir.create("Prism_style_xy_compiled")
library(dplyr)

# loop through all files and merge them by the x coordinate
file_names <- list.files(path = ".", full.names = FALSE, recursive = FALSE) #where you have your files

# import key with genotypes and experiment numbers
key <- read_csv("E:/Sspa-ssoa-blinded/Key3-final.csv")
key <- key[,3:6]

# get lists of all randomnames per line
# WT
key1305 <- subset(key, Line == "rpa1305")
key1326 <- subset(key, Line == "rpa1326")
key1327 <- subset(key, Line == "rpa1327")
key.wt <- rbind(key1305, key1326, key1327)

# pxdA KO
key1319 <- subset(key, Line == "rpa1319")
key1320 <- subset(key, Line == "rpa1320")
key.pxda <- rbind(key1319, key1320)

# hookA KO
key1324 <- subset(key, Line == "rpa1324")
key1325 <- subset(key, Line == "rpa1325")
key.hooka <- rbind(key1324, key1325)

# hexA KO
key1321 <- subset(key, Line == "rpa1321")
key1322 <- subset(key, Line == "rpa1322")
key.hexa <- rbind(key1321, key1322)

library(reshape2)
decoded <- colsplit(string=file_names, pattern="-", names=c("Part1", "Part2"))
decoded$FileName <- file_names

# now subset the filenames
names.wt <- decoded[decoded$Part1 %in% key.wt$RandomName, 3]
names.pxda <- decoded[decoded$Part1 %in% key.pxda$RandomName, 3]
names.hooka <- decoded[decoded$Part1 %in% key.hooka$RandomName, 3]
names.hexa <- decoded[decoded$Part1 %in% key.hexa$RandomName, 3]

# next loop through these filenames in the third column and merge for prism

# read csv files and return them as items in a list()
dataset.wt <- read.table(names.wt[1])
for (x in 2:length(names.wt)){
    temp_dataset <- read.table(names.wt[x])
    dataset.wt<-merge(dataset.wt, temp_dataset, by = "V1", all = TRUE)
}
write.csv(dataset.wt,"wildtype_compiled.csv")

# repeat now for other genotypes
dataset.pxda <- read.table(names.pxda[1])
for (x in 2:length(names.pxda)){
  temp_dataset <- read.table(names.pxda[x])
  dataset.pxda<-merge(dataset.pxda, temp_dataset, by = "V1", all = TRUE)
}
write.csv(dataset.pxda,"pxda_compiled.csv")

dataset.hooka <- read.table(names.hooka[1])
for (x in 2:length(names.hooka)){
  temp_dataset <- read.table(names.hooka[x])
  dataset.hooka<-merge(dataset.hooka, temp_dataset, by = "V1", all = TRUE)
}
write.csv(dataset.hooka,"hooka_compiled.csv")

dataset.hexa <- read.table(names.hexa[1])
for (x in 2:length(names.hexa)){
  temp_dataset <- read.table(names.hexa[x])
  dataset.hexa<-merge(dataset.hexa, temp_dataset, by = "V1", all = TRUE)
}
write.csv(dataset.hexa,"hexa_compiled.csv")

