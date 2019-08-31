function arkaplan_matris = arkaplan_median(alinan_video,n)
i=0;
Frame_sayisi = alinan_video.NumberOfFrames;
t=zeros(alinan_video.Height,alinan_video.Width);
for p=0:n:Frame_sayisi-n
    i=i+1;
    for j=1:n
        t(:,:,j)=double(rgb2gray(read(alinan_video,p+j)));
    end
    for x=1:1:alinan_video.Height
        for y=1:1:alinan_video.Width
            arkaplan_matris(x,y,i)= median(t(x,y,:));
        end
    end
end
end