for k = 1:9
    num = num2str(k);
    
    fileC = strcat('task1_5_c_',num,'.mat');
    C = task1_6(fileC);
    
    %fileImg = strcat('task1_6_imgs_',num,'.pdf');
    %save(fileImg, 'C');
end