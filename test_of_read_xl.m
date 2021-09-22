[num,txt,raw] = xlsread("F:\exp_2\Second_experiments\male_exp\expData_0_to_27000.xlsx");

command_for_3 = '"C:\Program Files\R\R-4.0.4\bin\x64\Rscript.exe" createExperimentNetworks3pop.R';
command_for_2 = '"C:\Program Files\R\R-4.0.4\bin\x64\Rscript.exe" createExperimentNetworks2pop.R';

my_size = num(1);

for i =1:my_size
s1='Select a color for group ';
%for the group names
s2 = txt(i+1,2);
s2=string(s2)
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