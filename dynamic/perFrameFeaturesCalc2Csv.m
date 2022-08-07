
clear
%creating all other features to csv of all flies in avarge
%getting the path of the expremnt dirs
%pay attention to the length of the movie

filename="per_framefeatures_sum_allflies.csv";

num_of_frames=26997;

handles.allFolders = uipickfiles('Prompt', 'Select movies to run inteactions');
for i = 1:length(handles.allFolders)
    folderPath = handles.allFolders{i};
    if(not(isfile(fullfile(folderPath, filename))))
    fileName = fullfile(folderPath, "perframe");
    all=[];
    current_dir_cell_features=struct2cell(dir(fullfile(fileName)));
for feature =3:length(current_dir_cell_features)
        featureName=current_dir_cell_features{1,feature}
        load(fullfile(fileName,featureName))
        perFrameAvgAllFlies=zeros(1,num_of_frames);
%calculating avarge
for j=1:num_of_frames
    sum_per_frame=sum(cellfun(@(v)v(j),data));
    perFrameAvgAllFlies(j)=sum_per_frame;
end
%flipping 
    horizen_perFrameAvgAllFlies=perFrameAvgAllFlies';
    table_of_current_perframe = array2table(horizen_perFrameAvgAllFlies, 'VariableNames',{featureName});
    all=horzcat(all,table_of_current_perframe);
end

    fullPath2Csv=fullfile(folderPath,filename);
    writetable(all,fullPath2Csv)
    else
        folderPath 
    end
end


