%%% Illustration of SSCV on the YouTube dataset
close all; clear; clc;
% data information
info.type = 'DTF';
info.suffix = '.features';
info.ncenter = 500;
info.cls = {'BalanceBeam','BandMarching','BaseballPitch','Basketball'};
info.ngroup = 25;
info.rate = 20;
info.dirfeat = '/home/wcj/UCF101_DTF/';
info.dirvec = '/home/wcj/code/gfxy-sc/data/';
addpath('/home/wcj/software/spams-matlab-v2.6/build/');
% compute visual descriptor words
%compSDVBasis(info);

compSDV(info);

