
% Script for running task1_6.m
for k = 1:9
    num = num2str(k);
    
    fileC = strcat('task1_5_c_',num,'.mat');
    C = task1_6(fileC);
end