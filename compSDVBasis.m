function compSDVBasis(info)

% read low-level features
disp('reading dt features ......');
feats = readFeatDTF(info);
disp(['number of features: ', num2str(size(feats, 1))]);
% depart descriptors
feats_hog = feats(:,1:96);
feats_hof = feats(:,97:204);
feats_mbhx = feats(:,205:300);
feats_mbhy = feats(:,301:396);
% Do PCA on  data to half-size original descriptors
feats_hog = compute_mapping(feats_hog,'PCA',48);
feats_hof = compute_mapping(feats_hof,'PCA',54);
feats_mbhx = compute_mapping(feats_mbhx,'PCA',48);
feats_mbhy = compute_mapping(feats_mbhy,'PCA',48);
% whitening hog
feats_hog = feats_hog';
feats_hog = feats_hog - repmat(mean(feats_hog), size(feats_hog, 1), 1);
feats_hog = feats_hog ./ repmat(sqrt(sum(feats_hog.^2)), size(feats_hog, 1), 1);
% whitening hof
feats_hof = feats_hof';
feats_hof = feats_hof - repmat(mean(feats_hof), size(feats_hof, 1), 1);
feats_hof = feats_hof ./ repmat(sqrt(sum(feats_hof.^2)), size(feats_hof, 1), 1);
% whitening mbhx
feats_mbhx = feats_mbhx';
feats_mbhx = feats_mbhx - repmat(mean(feats_mbhx), size(feats_mbhx, 1), 1);
feats_mbhx = feats_mbhx ./ repmat(sqrt(sum(feats_mbhx.^2)), size(feats_mbhx, 1), 1);
% whitening mbhy
feats_mbhy = feats_mbhy';
feats_mbhy = feats_mbhy - repmat(mean(feats_mbhy), size(feats_mbhy, 1), 1);
feats_mbhy = feats_mbhy ./ repmat(sqrt(sum(feats_mbhy.^2)), size(feats_mbhy, 1), 1);
% compute visual descriptor words by sparse coding
 
param.iter = 1000;
param.K = info.ncenter;
param.lambda = 0.12;
%param.lambda = 1.2 / sqrt(size(feats, 1));
%hog dictionary
hog_basis = mexTrainDL_Memory(feats_hog, param);
hog_basisFileName = [info.type, '_Basis_hog', num2str(info.ncenter), '.mat'];
save(hog_basisFileName, 'hog_basis');
%hof dictonary
hof_basis = mexTrainDL_Memory(feats_hof, param);
hof_basisFileName = [info.type, '_Basis_hof', num2str(info.ncenter), '.mat'];
save(hof_basisFileName, 'hof_basis');
%mbhx dictionary
mbhx_basis = mexTrainDL_Memory(feats_mbhx, param);
mbhx_basisFileName = [info.type, '_Basis_mbhx', num2str(info.ncenter), '.mat'];
save(mbhx_basisFileName, 'mbhx_basis');
%mbhy dictionary
mbhy_basis = mexTrainDL_Memory(feats_mbhy, param);
mbhy_basisFileName = [info.type, '_Basis_mbhy', num2str(info.ncenter), '.mat'];
save(mbhy_basisFileName, 'mbhy_basis');
end


