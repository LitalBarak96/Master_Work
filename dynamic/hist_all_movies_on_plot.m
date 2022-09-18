

handles.allFolders = uipickfiles('Prompt', 'Select movies to run inteactions');

parts = strsplit(handles.allFolders{1}, '\');
GroupName = parts{end-1};

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
edges = linspace(0, 65, 66);
h1=histogram(values_for_hist,"FaceAlpha",0.5,"BinEdges",edges);
h1.BinWidth = 1;
h1.Normalization = 'probability';
%set(gca, 'XTick', linspace(0,60,13));
set(gca, 'XTick', linspace(0,60,61))
xlabel('Distance', 'FontSize', 15);
ylabel('Count', 'FontSize', 15);
ylim([0, 0.15]); % Give some headroom above the bars.
yl = ylim;
hold on
sgtitle(GroupName)
%sgtitle("Low Aggregation")
end