

#function to read csv file and return a dataframe
read_csv <- function(file_name) {
  data_frame <- read.csv(file_name)
  return(data_frame)
}
#delete the first row of the dataframe 
delete_column <- function(data_frame, column_name) {
  data_frame <- data.frame(data_frame)
  data_frame <- data_frame[,-c(column_name)]
  return(data_frame)
}

#print column names of the dataframe
print_column_names <- function(data_frame) {
  colnames(data_frame)
}

#read many csv files and combine them into one dataframe
read_many_csv <- function(file_names) {
  data_frame <- read_csv(file_names[1])
  for (i in 2:length(file_names)) {
    data_frame <- rbind(data_frame, read_csv(file_names[i]))
  }
  return(data_frame)
}

#get path of all files with csv extension 
get_csv_files <- function(path) {
  dir <- dir(path)
  csv_files <- dir[dir %in% "*.csv"]
  return(csv_files)
}


#go recursively through all folders and get all csv files
get_csv_files_recursively <- function(path) {
  dir <- dir(path)
  csv_files <- dir[dir %in% "*.csv"]
  for (i in 1:length(dir)) {
    if (dir[i] %in% "*") {
      csv_files <- rbind(csv_files, get_csv_files_recursively(path %/% dir[i]))
    }
  }
  return(csv_files)
}
print(get_csv_files_recursively("D:\\allGroups\\Females_Mated"))


#print(dir("D:\\allGroups\\Females_Mated"))
#print(find_file_in_directory_list("all_frames_degree.csv",dir("D:\\allGroups\\Females_Mated")))

#print(print_subdirectories("D:\\allGroups\\Females_Mated"))

#print(find_file("all_frames_degree.csv", "D:\\allGroups\\Females_Mated"))

#get all subdirectories of a directory list
get_subdirectories <- function(directory_list) {
  subdirectories <- list()
  for (i in 1:length(directory_list)) {
    subdirectories <- c(subdirectories, list.files(directory_list[i], pattern = "*", full.names = TRUE))
  }
  return(subdirectories)
}

sub_dirs<-get_subdirectories("D:\\allGroups\\Females_Mated")

#print(sub_dirs)

#find path that conatins the file name in specified directory as list
find_path <- function(file_name, directory) {
  file_path <- list()
  for (i in 1:length(directory)) {
    if (file.exists(directory[i])) {
      file_path <- append(file_path, directory[i])
    }
  }
  return(file_path)
}


all_name<-find_path("all_frames_degree.csv", "D:\\allGroups\\Females_Mated")


#print(all_name)



list_of_dir_of_csv<-list_csv_files("D:\\allGroups\\Females_Mated")


#print(list_of_dir_of_csv)
#csv_file<-as.data.frame(read_csv("D:/allGroups/Females_Mated/Assa_Female_Mated_Unknown_RigA_20211025T120646/all_frames_degree.csv")) # nolint




#drops <- c("Frame")
#new_csv_file<-csv_file[ , !(names(csv_file) %in% drops)]

#print(head(new_csv_file))
