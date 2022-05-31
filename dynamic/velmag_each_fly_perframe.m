%getting the first value in each cell
path="D:\allGroups\Females_Grouped\Assa_Females_Grouped__Unknown_RigA_20220206T090743";

num_of_frames=27001;
perframe_avarge_allflies=zeros(1,num_of_frames);
for i=1:num_of_frames
 sum_per_frame=sum(cellfun(@(v)v(i),data));
perframe_avarge_allflies(i)=sum_per_frame;
end
horizen_perframe_avarge_allflies=perframe_avarge_allflies'
name_of_file="velmag_perframe_sum_allflies.csv"

full_path_tocsv=fullfile(path,name_of_file)
csvwrite(full_path_tocsv,horizen_perframe_avarge_allflies)
