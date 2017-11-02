
function [tagNames, namesMetaFilesSorted] = propagagteMetaFileNames(metaDir)
metaFiles = dir(fullfile(metaDir, '*.mat*'));

nMetaFiles = numel(metaFiles);
% Now we find all the date directory names
for j = 1: nMetaFiles
    namesMetaFiles{j} = metaFiles(j).name;
end

[namesMetaFilesSorted,~] = sort(namesMetaFiles);

dash = '-';
dot = '.';
for q = 1: nMetaFiles
    dashes2 = find(namesMetaFilesSorted{q} == dash);
    dots2 = find(namesMetaFilesSorted{q} == dot);
    
    if numel(dots2) > 1
        dots2 = dots2(end);
    else
        dots2 = dots2(1);
        disp('')
    end
    
    if numel(dashes2) > 4
        dashes2 = dashes2(4);
    else
        dashes2 = dashes2(end);
        disp('')
    end
    
    
    str2 = namesMetaFilesSorted{q}(dashes2+1:dots2-1);
    
    tagNames{q} = str2;
    
end

end