
withSubPlot=true;

%pick the movies
handles.allFolders = uipickfiles('Prompt', 'Select movies to run inteactions');
%get the group name - please choose by groups and not combine them
parts = strsplit(handles.allFolders{1}, '\');
GroupName = parts{end-1};

currentFolder = pwd;
for numofmovie=1:length(handles.allFolders)
    %the folder path
folderPath = handles.allFolders{numofmovie};
cd(folderPath)
%get the trx files for distances per 2 flys
struct_of_perfly=dir("*registered_trx_perframepairs_*.mat");
%assuming there is 10 flys
for i=1:10
 name_of_trx=struct_of_perfly(i).name;
 %find if the index exist
index = strfind(name_of_trx, string(i));
foundIt = ~isempty(index);
if(foundIt)
load(name_of_trx)
for j=i+1:10
perfly_dist=pairtrx(j).distnose2ell;
rouneddistance_per_fly{i,j} = round(perfly_dist,1);
end
else
    warning("we didn't found the index")
end
end
%return to the script path

%break down the cell for the histogram
values_for_hist=cell2mat(cellfun(@(x)x(:),rouneddistance_per_fly(:),'un',0));
if(withSubPlot)
subplot(2,round((length(handles.allFolders))/2),numofmovie)
end
h1=histogram(values_for_hist,"FaceAlpha",0.2);
h1.BinWidth = 1;
h1.Normalization = 'probability';
xlabel('Distance', 'FontSize', 15);
ylabel('Count', 'FontSize', 15);
% Compute mean and standard deviation.
mu = mean(values_for_hist);
sigma = std(values_for_hist);
xline(mu, 'Color', 'g', 'LineWidth', 1);
xline(mu - sigma, 'Color', 'r', 'LineWidth', 1, 'LineStyle', '--');
xline(mu + sigma, 'Color', 'r', 'LineWidth', 1, 'LineStyle', '--');
%ylim([0, max(h1.Values)+1000]); % Give some headroom above the bars.
ylim([0, 0.15]); % Give some headroom above the bars.
yl = ylim;
sMean = sprintf('  Mean = %.3f\n  SD = %.3f', mu, sigma);
text(mu, 0.9*yl(2), sMean, 'Color', 'r', ...
	'FontWeight', 'bold', 'FontSize', 6, ...
	'EdgeColor', 'b');
%sMean2= sprintf('Mean = %.3f.  SD = %.3f', mu, sigma);
%title(GroupName, 'FontSize', 10);

hold on
sgtitle(GroupName)
end
cd(currentFolder)



 