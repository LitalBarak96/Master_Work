
command = '"C:\Program Files\R\R-4.2.2\bin\x64\Rscript.exe" main_per_fly_csv.R ';
expGroups = uipickfiles('Prompt', 'Select experiment groups folders');
[suggestedPath, ~, ~] = fileparts(expGroups{1});
savePath =suggestedPath;
numOfGroups = length(expGroups);

color ="";
groupNameDir =[];
colorValue=[];

groupNameDir=expGroups';
tables=table(groupNameDir);

OriginFolder = pwd;
folder=savePath;
if ~exist(folder, 'dir')
    mkdir(folder);
end
cd(folder)
baseFileName = 'paths.xlsx';
path_of_xlsx = fullfile(folder, baseFileName);
writetable(tables,baseFileName)

cd(OriginFolder)
command = append(command,path_of_xlsx) 
[status,cmdout]=system(command,'-echo');