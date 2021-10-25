command = '"C:\Program Files\R\R-4.0.4\bin\x64\Rscript.exe" createExperimentNetworks2pop.R';

for i =1:2
s1='Select a color for group number ';
s2 = int2str(i);
s = append(s1,s2);
c = uisetcolor([1 1 0],s)
color_in_char =[];
B=[];
color_in_char= sprintf(' %f', c)
B = color_in_char
command= append(command,B)
end
[status,cmdout]=system(command,'-echo');
