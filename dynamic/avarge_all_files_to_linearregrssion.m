%avarge all movies for linear regrssion
clear
parent_dir_current ="D:/cyp6a20_assa/5_Cyp6a20 RNAi";
files = dir(parent_dir_current);
dirFlags = [files.isdir];
subDirs = files(dirFlags);
subDirsNames = {subDirs(3:end).name};
%changing to the parent dir
cd(parent_dir_current)

%giving the per frame name to the folders
full_path_name_all_features=strcat(subDirsNames,"\per_framefeatures_sum_allflies.csv");
full_path_name_degree=strcat(subDirsNames,"\all_frames_degree_new");

numfiles=length(full_path_name_all_features);
all_features=readmatrix(full_path_name_all_features(1));
degree=readmatrix(full_path_name_degree(1));
%degree=tmp(2:end,3);
for k = 2:numfiles %1
all_features = all_features + readmatrix(full_path_name_all_features(k)); %2
degree=degree+readmatrix(full_path_name_degree(k));
end

all_degree=degree(2:end,3);
all_degree=all_degree/numfiles;
all_features=all_features/numfiles;
%pay attention,it is writing it without the headers
csvwrite(fullfile(cd, 'avg_all_movies_all_features.csv'), all_features); %4
csvwrite(fullfile(cd, 'avg_all_movies_degree.csv'), all_degree); %4

