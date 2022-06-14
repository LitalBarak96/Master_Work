%getting the first value in each cell

%PATH TO THE PER FRAME 
%path="D:\allGroups\Females_Mated\Assa_Female_Mated_Unknown_RigA_20211025T120646\perframe";

%creating alll other features to csv
%getting the path of the expremnt dirs
parent_dir_current ="D:\allGroups\Males_Mated";
files = dir(parent_dir_current);
dirFlags = [files.isdir];
subDirs = files(dirFlags);
subDirsNames = {subDirs(3:end).name};
%changing to the parent dir
cd(parent_dir_current)
%giving the per frame name to the folders
full_path_name=strcat(subDirsNames,"\perframe");



for current_path=1:length(full_path_name)
%subfile to get the names
path_current=full_path_name{current_path};
perframedir=dir(fullfile(path_current));
%changge to struct to get accses
cell_dir=struct2cell(perframedir);
all=[];

%the 1 and 2 are the current dir 
for j =3:81
name=cell_dir{1,j}
load(fullfile(path_current,cell_dir{1,j}))
num_of_frames=26997;
perframe_avarge_allflies=zeros(1,num_of_frames);
for i=1:num_of_frames
 sum_per_frame=sum(cellfun(@(v)v(i),data));
perframe_avarge_allflies(i)=sum_per_frame;
end
horizen_perframe_avarge_allflies=perframe_avarge_allflies';
table_of_current_perframe = array2table(horizen_perframe_avarge_allflies, 'VariableNames',{name});
all=horzcat(all,table_of_current_perframe);

end


filename="per_framefeatures_sum_allflies.csv";

full_path_tocsv=fullfile(subDirsNames{current_path},filename)
writetable(all,full_path_tocsv)
end