function combine_test(info)
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
        idxgroup,'_c',idxVid,'_hofSDV.mat'];
if ~exist(filename,'file')
            break;
end
    if exist(filename,'file')
    t = t+1;
    k = k+1;
 
    load (filename,'sdv_hof');
       test_SDV(t,:) = sdv_hof;
      test_labels(t,1) = i;
 continue;
    end
end


     end
        
     end

 end
 
 end
save test_SDV;
save test_labels;
end
