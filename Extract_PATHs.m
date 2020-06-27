function [filelist, folderlist] = Extract_PATHs(FolderPath, sortbydate)

currentDir = pwd;

cd(FolderPath);
DirList = dir;

if sortbydate
    S = [DirList(:).datenum];
    [~,S] = sort(S);
    DirList = DirList(S);
end

counter = 1;
counter2 = 1;
filelist={};
folderlist={};
for filenum_i = 1:numel(DirList)
    if DirList(filenum_i).isdir
        if strfind(DirList(filenum_i).name,'.') | strfind(DirList(filenum_i).name,'..')
            continue;
        end
        folderlist{counter2}=...
            sprintf('%s',strcat(FolderPath,'\',DirList(filenum_i).name));
        counter2 = counter2 + 1;
    else
        filelist{counter}=...
            sprintf('%s',strcat(FolderPath,'\',DirList(filenum_i).name));
        counter = counter +1;
    end
end
% fclose(fid);
if ~isempty(filelist)
    filelist = pad0Nsort(filelist); 
end
if ~isempty(folderlist)
    folderlist = pad0Nsort(folderlist);
end
cd(currentDir);

function outputlist = pad0Nsort(pathlist)
% sort path list ending with '_1.jpg', '_10.jpg' or '_2.jpg',etc. with
% padding zero first (_01.jpg), sort and resort the original path again
%   Apr. 10th, 2017 Akinori F. Ebihara

for iFile = 1:numel(pathlist)
    temp = regexp(pathlist{iFile},'_','split');
    if numel(temp{end}) == 5
        temp{end} = strcat('0',temp{end});
    end
    inputList2{iFile} = strjoin(temp,'_');
end
[~,ind2] = sort(inputList2);
outputlist = pathlist(ind2);
end

end

