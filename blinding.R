# first make random list of words for blinding, and save it as random.csv
# have one random word for each file you want to rename
# https://www.randomlists.com/random-words
# save this file ONE FOLDER LEVEL ABOVE where your files are

# change dir to location of files
setwd(choose.dir(default = "C:/Users/Livia Songster/Documents", caption = "Select folder with all analysis dirs"))

# define file type
# filetype <- readline(prompt="Enter filetype of ALL files in the directory: ")
filetype <- ".tif"

files <- list.files(pattern = filetype)
wd <- getwd()

# to read in a specific list, uncomment rows below
# setwd("..")
# random <- read.csv("random.csv",header=FALSE)$V1
# random <- random[1:length(files)]
# make sure both files and random have the same length/number of values


# GENERATE RANDOM LIST
library("stringr")
library(randomNames)

# find number of files
nfiles <- length(files)

# first make a random list of first names
random <- randomNames(nfiles, which.names = "both", name.order = "first.last", name.sep = "_")

# then, remove names with a space (space is tricky for filename formatting)
# random_list <- random_list[!str_detect(random_list, " ")]

# substitute spaces and apostrophes with underscores
random <- gsub(" ", "_", random)
random <- gsub("'", "_", random)

# check if all values in random are unique
length(unique(random)) == nfiles

#change to dir of files to blind
setwd(wd)

#rename files
file.rename(files,paste0(random,filetype))

#save names of files + random name as key
df <- ""
df$File <- files
df$RandomName <- random
setwd("..")
write.csv(df,"Cytoplasm-Blinding-Key.csv")
