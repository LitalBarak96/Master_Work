function [] = runOneGroupInteractionsNoAngelSub(param, allFolders)

 
for i = 1:length(allFolders)
    folderPath = allFolders{i};
    fileName = fullfile(folderPath, param.jaabaFileName);
   [COMPUTERPERFRAMESTATSSOCIAL_SUCCEEDED,savenames] = compute_perframe_stats_social_f('matname', fileName);
    [newInteractions, newNoInteractions] = computeAllMovieInteractionsAllinteraction(savenames, param);
end
