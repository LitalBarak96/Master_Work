
%for spcific number of mvoies
jaabaFileName = 'registered_trx.mat';
%jaabaFileName = 'ctrax_results - Copy.mat';


param = struct();
param.interactionsNumberOfFrames = 60;
param.interactionsDistance = 8;
param.interactionsAnglesub = 0;
param.oneInteractionThreshold = 120;
param.startFrame = 0;
param.endFrame = 27000;
%i can change here to false and get undirected network parametrs
param.directed = false;
%param.interactionLength = true;

interactions = [];
noInteractions = [];

handles.allFolders = uipickfiles('Prompt', 'Select movies to run inteactions');
for i = 1:length(handles.allFolders)
    folderPath = handles.allFolders{i};
    fileName = fullfile(folderPath, jaabaFileName);
    [COMPUTERPERFRAMESTATSSOCIAL_SUCCEEDED,savenames] = compute_perframe_stats_social_f('matname', fileName);
    [newInteractions, newNoInteractions, txtFileName] = computeAllMovieInteractionsAllinteraction(savenames, param);
    interactions = [interactions, newInteractions];
    noInteractions = [noInteractions, newNoInteractions];
end


