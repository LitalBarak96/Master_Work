command = '"C:\Program Files\R\R-4.1.2\bin\x64\Rscript.exe" creatExpNet.R ';
color ="";
num_of_pop =3;
group_name =[]
color_value=[];

for i =1:num_of_pop
s1='Select a color for group number ';
s2 = int2str(i);
group_name= [group_name;s2];
s = append(s1,s2);
c = uisetcolor([1 1 0],s)
color_in_char =[];
color_in_char= sprintf(' %f', c)
color_value = [color_value;c];
%color = append(color,B)
end
tables=table(group_name,color_value);
OriginFolder = pwd;
dname = uigetdir();
folder = dname;
if ~exist(folder, 'dir')
    mkdir(folder);
end
cd(dname)
baseFileName = 'color.xlsx';
path_of_xlsx = fullfile(folder, baseFileName);
writetable(tables,baseFileName)

cd(OriginFolder)
command = append(command,path_of_xlsx) 
[status,cmdout]=system(command,'-echo');
