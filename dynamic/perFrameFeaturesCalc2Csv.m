
%creating all other features to csv of all flies in avarge
%getting the path of the expremnt dirs
filename="per_framefeatures_sum_allflies.csv";

parent_dir_current ="D:\Elia\cyp6a20\WT";

files = dir(parent_dir_current);
dirFlags = [files.isdir];
subDirs = files(dirFlags);
subDirsNames = {subDirs(3:end).name};
%changing to the parent dir
cd(parent_dir_current)
%giving the per frame name to the folders
full_path_name=strcat(subDirsNames,"\perframe");
%not until the end becuase it is sometimes missing
num_of_frames=26997;

for index_dir=1:length(full_path_name)
 %init
 all=[];
%subfile to get the names
current_path=full_path_name{index_dir};
%changge to struct to get accses
current_dir_cell_features=struct2cell(dir(fullfile(current_path)));



%the 1 and 2 are the current dir 
for feature =3:length(current_dir_cell_features)
featureName=current_dir_cell_features{1,feature}
load(fullfile(current_path,current_dir_cell_features{1,feature}))
perFrameAvgAllFlies=zeros(1,num_of_frames);
%calculating avarge
for i=1:num_of_frames
 sum_per_frame=sum(cellfun(@(v)v(i),data));
perFrameAvgAllFlies(i)=sum_per_frame;
end
%flipping 
horizen_perFrameAvgAllFlies=perFrameAvgAllFlies';
table_of_current_perframe = array2table(horizen_perFrameAvgAllFlies, 'VariableNames',{featureName});
all=horzcat(all,table_of_current_perframe);
end



fullPath2Csv=fullfile(subDirsNames{index_dir},filename)
writetable(all,fullPath2Csv)
end