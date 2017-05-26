function compSDV(info)
 addpath('/home/wcj/software/spams-matlab-v2.6/build/');          
% load visual descriptor words
hog_basisFileName = [info.type, '_Basis_hog', num2str(info.ncenter), '.mat'];
load(hog_basisFileName, 'hog_basis');
% load visual descriptor words
hof_basisFileName = [info.type, '_Basis_hof', num2str(info.ncenter), '.mat'];
load(hof_basisFileName, 'hof_basis');
% load visual descriptor words
mbhx_basisFileName = [info.type, '_Basis_mbhx', num2str(info.ncenter), '.mat'];
load(mbhx_basisFileName, 'mbhx_basis');
% load visual descriptor words
mbhy_basisFileName = [info.type, '_Basis_mbhy', num2str(info.ncenter), '.mat'];
load(mbhy_basisFileName, 'mbhy_basis');
% do the job
for i = 1:length(info.cls)
    for j = 1:info.ngroup
                                                 idxGroup = sprintf('%02d', j);
        disp(['computing class: ', info.cls{i}, ', group: ', idxGroup, ' ......']);
        
        k = 1;
        while 1
            idxVid = sprintf('%02d', k);
            featFileName = [info.dirfeat,  info.cls{i}, ...
                           '/v_', info.cls{i}, '_g', idxGroup, '_c', idxVid, info.suffix];
            if ~exist(featFileName, 'file')
                break;
            end      
            hog_vecFileName = [info.dirvec,  info.cls{i}, ...
                           '/v_', info.cls{i}, '_g', idxGroup, '_c', idxVid, '_hogSDV.mat'];
            hof_vecFileName = [info.dirvec,  info.cls{i}, ...
                           '/v_', info.cls{i}, '_g', idxGroup, '_c', idxVid, '_hofSDV.mat']; 
            mbhx_vecFileName = [info.dirvec,  info.cls{i}, ...
                           '/v_', info.cls{i}, '_g', idxGroup, '_c', idxVid, '_mbhxSDV.mat']; 
            mbhy_vecFileName = [info.dirvec,  info.cls{i}, ...
                           '/v_', info.cls{i}, '_g', idxGroup, '_c', idxVid, '_mbhySDV.mat'];
            if exist(hog_vecFileName, 'file')
                k = k + 1;
                continue;
            end      
            % read low-level features
            feats = readSingleFileDTF(featFileName);
            %depart features into descriptors
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
           feats_hog = feats_hog';
% whitening hof
           feats_hof = feats_hof';
           feats_hof = feats_hof - repmat(mean(feats_hof), size(feats_hof, 1), 1);
           feats_hof = feats_hof ./ repmat(sqrt(sum(feats_hof.^2)), size(feats_hof, 1), 1);
           feats_hof = feats_hof';
% whitening mbhx
           feats_mbhx = feats_mbhx';
           feats_mbhx = feats_mbhx - repmat(mean(feats_mbhx), size(feats_mbhx, 1), 1);
           feats_mbhx = feats_mbhx ./ repmat(sqrt(sum(feats_mbhx.^2)), size(feats_mbhx, 1), 1);
           feats_mbhx = feats_mbhx';
% whitening mbhy
           feats_mbhy = feats_mbhy';
           feats_mbhy = feats_mbhy - repmat(mean(feats_mbhy), size(feats_mbhy, 1), 1);
           feats_mbhy = feats_mbhy ./ repmat(sqrt(sum(feats_mbhy.^2)), size(feats_mbhy, 1), 1);
           feats_mbhy = feats_mbhy';
           %coding
           % parameters
           param.pos = 1;
           param.lambda = 0.12;
           % sparse coding by lasso
           codes_hog = mexLasso(feats_hog', hog_basis, param);
           codes_hog = full(codes_hog)';
           codes_hof = mexLasso(feats_hof', hof_basis, param);
           codes_hof = full(codes_hof)';
           codes_mbhx = mexLasso(feats_mbhx', mbhx_basis, param);
           codes_mbhx = full(codes_mbhx)';
           codes_mbhy = mexLasso(feats_mbhy', mbhy_basis, param);
           codes_mbhy = full(codes_mbhy)'; 
           %pooling
           sdv_hog = poolingFeats_hog(hog_basis,feats_hog,codes_hog);
           sdv_hof = poolingFeats_hof(hof_basis,feats_hof,codes_hof);
           sdv_mbhx = poolingFeats_mbhx(mbhx_basis,feats_mbhx,codes_mbhx);
           sdv_mbhy = poolingFeats_mbhy(hog_basis,feats_mbhy,codes_mbhy);
            save(hog_vecFileName, 'sdv_hog');
            save(hof_vecFileName, 'sdv_hof');
            save(mbhx_vecFileName, 'sdv_mbhx');
            save(mbhy_vecFileName, 'sdv_mbhy');
            k = k + 1; 
        end
    end
end

