%getting the first value in each cell

%PATH TO THE PER FRAME 
path="D:\allGroups\Females_Mated\Assa_Female_Mated_Unknown_RigA_20211025T120646\perframe";

%subfile to get the names
perframedir=dir(fullfile(path));
%changge to struct to get accses
cell_dir=struct2cell(perframedir);
all=[];

%the 1 and 2 are the current dir 
for j =3:81
name=cell_dir{1,j}
load(fullfile(path,cell_dir{1,j}))


%name_of_ferframe=zeros(1,81)

%for i=1:81
 %   name_of_ferframe(i)=cell_dir{1,i}
%end

num_of_frames=27001;
perframe_avarge_allflies=zeros(1,num_of_frames);
for i=1:num_of_frames
 sum_per_frame=sum(cellfun(@(v)v(i),data));
perframe_avarge_allflies(i)=sum_per_frame;
end
horizen_perframe_avarge_allflies=perframe_avarge_allflies'

table_of_current_perframe = array2table(horizen_perframe_avarge_allflies, 'VariableNames',{name});

all=horzcat(all,table_of_current_perframe);

end


filename="perframe_sum_allflies.csv";

full_path_tocsv=fullfile(path,filename)
writetable(all,full_path_tocsv)
