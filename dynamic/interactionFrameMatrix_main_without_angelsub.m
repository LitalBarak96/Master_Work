 
%here you can change the threshold for interaction
%please note that if you choose more than 1 group only the first file of
%each group will be tranfom to dynamicnet
param = struct();
param.interactionsNumberOfFrames = 60;
param.interactionsDistance = 8;
%param.interactionsAnglesub = 0;
param.oneInteractionThreshold = 120;
param.startFrame = 0;
param.endFrame = 27000;
param.directed = false;
param.jaabaFileName = 'registered_trx.mat';
maxExperimentInteractions = -1;

%please note that need to be in each movie 10 flys

addpath 'C:\Users\barakli8\OneDrive - Bar Ilan University\Lital\code\interactions_network\dynamic\code'
expGroups = uipickfiles('Prompt', 'Select experiment groups folders');
[suggestedPath, ~, ~] = fileparts(expGroups{1});
numOfGroups = length(expGroups);
%you can choose more than 1 group to creat 
groupNumber = [{'Number of groups'; numOfGroups}; cell(numOfGroups - 1, 1)];
groupNames = cell(numOfGroups + 1, 1);
groupNames{1} = 'Groups names';
groupLength = cell(numOfGroups + 1, 1);
groupLength{1} = 'Number of movies';
data = [groupNumber, groupNames, groupLength];
for i = 1:numOfGroups
    [~, groupName, ~] = fileparts(expGroups{i});
    data{i + 1, 2} = groupName;
    d = dir(expGroups{i});
    isub = [d(:).isdir];
    allFolders = {d(isub).name}';
    allFolders(ismember(allFolders,{'.','..'})) = [];
    allFolders = fullfile(expGroups{i}, allFolders);
    data{i + 1, 3} = length(allFolders);
    runOneGroupInteractions_new(param, allFolders, groupName);

end
