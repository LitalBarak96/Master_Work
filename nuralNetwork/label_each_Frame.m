%doing load to what chose,choose trx file
uiopen('*.mat')

flyIdentity = 2;
classifier = [(1:length(pairtrx(flyIdentity).distnose2ell))', pairtrx(flyIdentity).distnose2ell'];
% remove data of all frames which are not interactions
%classifier(classifier(:, 3) == param.interactionsAnglesub, :) = [];
%close is 2 far is 1

tmp = [(1:length(pairtrx(flyIdentity).distnose2ell))', pairtrx(flyIdentity).distnose2ell'];

tmp(classifier(:, 2) > 11, 3) = 1;
tmp(classifier(:, 2) < 9, 3) = 2;

%spical condition
tmp((classifier(:, 2) < 10.5) & (classifier(:, 2) > 9.5), 3) = 3;

frames_that_between=classifier(tmp(:,3) == 3);



csvwrite('C:\Users\barakli8\OneDrive - Bar Ilan University\Lital\weekly presentation\07.07.2022\file.csv',tmp)

%everything in between is 0 netween 10.5 and 11 and between 9.5 and 9