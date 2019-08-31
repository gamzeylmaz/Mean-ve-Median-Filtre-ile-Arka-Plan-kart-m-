function arkaplan_matris = arkaplan_mean(alinan_video,n)
i=0;
Frame_sayisi = alinan_video.NumberOfFrames;
t=zeros(alinan_video.Height,alinan_video.Width);
for p=0:n:Frame_sayisi-n
    i=i+1;
    for j=1:n
        t = t + double(rgb2gray(read(alinan_video,p+j)));
    end
    
    arkaplan_matris(:,:,i)=t/n;
    
    t=t*0;
end
end