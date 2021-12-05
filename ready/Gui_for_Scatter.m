
command = '"C:\Program Files\R\R-4.1.2\bin\x64\Rscript.exe" main.R ';
expGroups = uipickfiles('Prompt', 'Select experiment groups folders');
[suggestedPath, ~, ~] = fileparts(expGroups{1});
savePath =suggestedPath;
numOfGroups = length(expGroups);

prompt = {'insert height window size','insert width window size','insert font size','insert asterisk size','insert x-axis size(abs value)','insert dot size'};
dlgtitle = 'parameters';
dims = [1 35];
definput = {'12','12','5','3','3','1'};
opts.Resize = 'on';
answer_size = inputdlg(prompt,dlgtitle,dims,definput,opts);
height= str2num(answer_size{1});
width =str2num(answer_size{2});
font =str2num(answer_size{3});
asterisk =str2num(answer_size{4});
xsize =str2num(answer_size{5});
dot =str2num(answer_size{6});


answer_change = questdlg('Would you like to run from the beginning or only change visual?', ...
	'run or vizual', ...
	'change vizual','run from the beginning','run from the beginning');
% Handle response
switch answer_change
    case 'change vizual'
        warndlg(' you choose change vizual  ','this is not and error')
        disp([answer_change ' start running vizual soon '])
        change = 2;
    case 'run from the beginning'
        warndlg(' calculating from beginning ','this is not error')
        disp([answer_change ' lets start from the beginning '])
        change = 1;
end

answer_delete = questdlg('wish to delete paramters files at the end?', ...
	'delete or keep', ...
	'delete','keep','keep');
% Handle response
switch answer_delete
    case 'delete'
        warndlg(' will be deleted ','this is not error')
        disp([answer_delete ' will be deleted '])
        deleted = 1;
    case 'keep'
        warndlg(' we wont delete ','this is not error')
        disp([answer_delete ' wont be deleted '])
        deleted = 0;
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
tables_params=table(height,width,font,asterisk,xsize,change,deleted,dot);

OriginFolder = pwd;
folder=savePath;
if ~exist(folder, 'dir')
    mkdir(folder);
end
cd(folder)
baseFileName = 'color.xlsx';
path_of_xlsx = fullfile(folder, baseFileName);
writetable(tables,baseFileName)

baseFileName = 'params.xlsx';
path_of_xlsx_params = fullfile(folder, baseFileName);
writetable(tables_params,baseFileName)
cd(OriginFolder)
command = append(command,path_of_xlsx) 
[status,cmdout]=system(command,'-echo');