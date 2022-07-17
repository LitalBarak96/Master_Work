

handles.allFolders = uipickfiles('Prompt', 'Select movies to run inteactions');



for numofmovie=1:length(handles.allFolders)
folderPath = handles.allFolders{numofmovie};
cd(folderPath)
struct_of_perfly=dir("*registered_trx_perframepairs_*.mat");

for i=1:10
 name_of_trx=struct_of_perfly(i).name;
index = strfind(name_of_trx, string(i));
foundIt = ~isempty(index);
if(foundIt)
load(name_of_trx)
for j=i+1:10
perfly_dist=pairtrx(j).distnose2ell;
rouneddistance_per_fly{i,j} = round(perfly_dist,1);
end
end
end

values_for_hist=cell2mat(cellfun(@(x)x(:),rouneddistance_per_fly(:),'un',0));
h1=histogram(values_for_hist);
hold on
end
