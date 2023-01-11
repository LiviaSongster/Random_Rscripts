rm(list=ls())
df=NULL
setwd(choose.dir(default = "Y:/LiviaSongster/10-Analysis/", caption = "Select folder with .csv compiled"))

#save the names of the files you want to import
file_names <- list.files(path = ".", pattern="*.csv$", full.names = FALSE, recursive = FALSE) #where you have your files
# file_names<- file_names[grep("*perox*",file_names)]

#combines all the csv files and adds a column at the end with the name of the file the data came from
df <- do.call(rbind, lapply(file_names, function(x) cbind(read.csv(x), Experiment=strsplit(x,'\\.')[[1]][1])))
#saves name of your directory as variable dir_name
dir_name<-basename(getwd())

#save the final compiled document
write.csv(df, paste0(dir_name, '_allfiles.csv'), row.names=FALSE)

