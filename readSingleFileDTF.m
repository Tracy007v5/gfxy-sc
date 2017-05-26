function  feats = readSingleFileDTF(file)
feats = [];
count = 1;
fp = fopen(file, 'r');
% read header
%fgetl(fp); fgetl(fp); fgetl(fp);
%fgetl(fp);fgetl(fp);
% read keys and descriptors
while ~isempty(fscanf(fp, '%d', 1))%read point type
    fscanf(fp, '%f', 39);
    feats(count, :) = fscanf(fp, '%f', 396);
    count = count + 1;
end
fclose(fp);
% remove empty rows
feats(count:end, :) = [];
end