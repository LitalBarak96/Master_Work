

param = struct();
param.interactionsNumberOfFrames = 60;
param.interactionsDistance = 8;
param.interactionsAnglesub = 0;
param.oneInteractionThreshold = 120;
param.startFrame = 0;
param.endFrame = 27000;
param.directed = false;
param.jaabaFileName = 'registered_trx.mat';
maxExperimentInteractions = -1;


expGroups = uipickfiles('Prompt', 'Select experiment groups folders');
[suggestedPath, ~, ~] = fileparts(expGroups{1});
savePath = uigetdir(suggestedPath, 'Select folder to save csv file');
numOfGroups = length(expGroups);
xlsxFileName = fullfile(savePath, ['expData_', num2str(param.startFrame), '_to_', num2str(param.endFrame), '.xlsx']);
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
    [maxGroupInteractions, foldersNames] = runOneGroupInteractions(param, allFolders, xlsxFileName, groupName);
    if size(foldersNames, 1) > size(data, 1)
        cellsToAdd = cell(size(foldersNames, 1) - size(data, 1), size(data, 2));
        data = [data; cellsToAdd];
    elseif size(foldersNames, 1) < size(data, 1)
        cellsToAdd = cell(size(data, 1) - size(foldersNames, 1), size(foldersNames, 2));
        foldersNames = [foldersNames; cellsToAdd];
    end
    data = [data, foldersNames];

    maxExperimentInteractions = max(maxExperimentInteractions, maxGroupInteractions);
end

maxInter = cell(size(data, 1), 1);
maxInter{1} = 'Max number of interaction';
maxInter{2} = maxExperimentInteractions;
data = [data, maxInter];

xlswrite(xlsxFileName, data);
[num,txt,raw] = xlsread(xlsxFileName);

command_for_3 = '"C:\Program Files\R\R-4.0.4\bin\x64\Rscript.exe" createExperimentNetworks3pop.R';
command_for_2 = '"C:\Program Files\R\R-4.0.4\bin\x64\Rscript.exe" createExperimentNetworks2pop.R';

my_size = num(1);

for i =1:my_size
s1='Select a color for group ';
%for the group names
s2 = txt(i+1,2);
s = append(s1,s2);
c = uisetcolor([1 1 0],s)
color_in_char =[];
B=[];
color_in_char= sprintf(' %f', c)
B = color_in_char
if(my_size == 2)
    command_for_2= append(command_for_2,B);
end
if(my_size == 3)  
command_for_3= append(command_for_3,B);
end
end
if(my_size(1) == 3) 
    [status,cmdout]=system(command_for_3,'-echo');
end
if(my_size(1) == 2) 
    [status,cmdout]=system(command_for_2,'-echo');
end
