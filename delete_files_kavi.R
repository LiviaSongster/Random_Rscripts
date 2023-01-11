# delete files script
rm(list=ls()) # clears R environment
setwd(choose.dir()) # setwd
folder <- getwd()
# ideal outputs
#save the names of the files you want to import
file_names <- list.files(path = ".", full.names = FALSE, recursive = TRUE)

delete_files <- file_names[grep(".jpg",file_names)]

for (x in 1:length(delete_files)){
  file.remove(paste0(folder,delete_files[x]))
}

file.remove('gfg_data2.csv')