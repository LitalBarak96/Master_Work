 
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

command = '"C:\Program Files\R\R-4.1.2\bin\x64\Rscript.exe" main.R ';

expGroups = uipickfiles('Prompt', 'Select experiment groups folders');
[suggestedPath, ~, ~] = fileparts(expGroups{1});
numOfGroups = length(expGroups);
savePath =expGroups{1};


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
    [maxGroupInteractions, foldersNames] = runOneGroupInteractions_new(param, allFolders, groupName);
    if size(foldersNames, 1) > size(data, 1)
        cellsToAdd = cell(size(foldersNames, 1) - size(data, 1), size(data, 2));
        data = [data; cellsToAdd];
    elseif size(foldersNames, 1) < size(data, 1)
        cellsToAdd = cell(size(data, 1) - size(foldersNames, 1), size(foldersNames, 2));
        foldersNames = [foldersNames; cellsToAdd];
    end
    data = [data, foldersNames];
end

color ="";
groupNameDir =[];
colorValue=[];

groupNameDir=expGroups';

for i =1:numOfGroups
s1='Select a color for ';
[~,currentGroupName,~]=fileparts(groupNameDir(i));
displayOrder =char(strcat(s1,{' '},currentGroupName));
c = uisetcolor([1 1 0],displayOrder);
color_in_char =[];
color_in_char= sprintf(' %f', c)
colorValue = [colorValue;c];
end
tables=table(groupNameDir,colorValue);

OriginFolder = pwd;
folder=savePath;
if ~exist(folder, 'dir')
    mkdir(folder);
end
cd(folder)
baseFileName = 'dir_and_color.xlsx';
path_of_xlsx = fullfile(folder, baseFileName);
writetable(tables,baseFileName)

cd(OriginFolder)
command = append(command,path_of_xlsx) 
[status,cmdout]=system(command,'-echo');


