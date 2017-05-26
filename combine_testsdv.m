clc;
clear;
info.dirvector = '/home/wcj/code/gfxy-sc/data/';
info.ngroup = 25;
info.cls = {'ApplyEyeMakeup','ApplyLipstick','Archery','BabyCrawling',...
    'BalanceBeam','BandMarching','BaseballPitch','Basketball'};
t = 0;
 for i = 1:length(info.cls)
     for j = 1:info.ngroup
        idxgroup = sprintf('%02d',j);
         k = 1;
while 1
        idxVid = sprintf('%02d',k);
        if j > 7
            break;
        
        else if j<= 7
    filename = [info.dirvector,info.cls{i},'/v_',info.cls{i},'_g',...
        idxgroup,'_c',idxVid,'_mbhySDV.mat'];
if ~exist(filename,'file')
            break;
end
    if exist(filename,'file')
    t = t+1;
    k = k+1;
 
    load (filename,'sdv_mbhy');
       test_mbhySDV(t,:) = sdv_mbhy;
     
 continue;
    end
end


     end
        
     end

 end
 
 end
save test_mbhySDV;


