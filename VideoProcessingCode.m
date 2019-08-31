clear all;clc;close all;

alinan_video = VideoReader('araclar.avi');
Frame_sayisi = alinan_video.NumberOfFrames;

prompt = {'Arkaplan güncelleme sikligini belirtiniz(sn):','threshold  deðeri giriniz:',...
    'mean-median','Video isleme sonunda kaydedilsin mi(evet,hayir)?'};
Baslik = 'Video Ýsleme Ayarlar';
ontanimli = {'10','55','mean','hayýr'};
cevaplar = inputdlg(prompt,Baslik,1,ontanimli);

guncelleme = str2num(cevaplar{1,1})*alinan_video.BitsPerPixel;
threshold  = str2num(cevaplar{2,1});
yontem = cevaplar{3,1};
video_kayit = cevaplar{4,1};


if strcmp(yontem,'mean')
    arkaplan_matris = arkaplan_mean(alinan_video,guncelleme);
elseif strcmp(yontem,'median')
    arkaplan_matris = arkaplan_median(alinan_video,guncelleme);
end


if strcmp(video_kayit,'evet')
    if strcmp(yontem,'mean')
        videokayit = VideoWriter('Arkaplani_cikartilmiþ_video_mean.avi');
    elseif strcmp(yontem,'median')
        videokayit = VideoWriter('Arkaplani_cikartilmiþ_video_median.avi');
    end
    videokayit.FrameRate = alinan_video.BitsPerPixel;
    videokayit.Quality   = 70;
    open(videokayit);
end


i=0;
goster = vision.VideoPlayer;
goster.Name = 'Arkaplaný Cikartilmis Video';

for p=0:guncelleme:Frame_sayisi-guncelleme
    i=i+1;
    for k=1:guncelleme
        arkaplan_cikmis_video = ((double(rgb2gray(read(alinan_video,p+k)))- arkaplan_matris(:,:,i)) > threshold);
        
        step(goster,arkaplan_cikmis_video);
        if strcmp(video_kayit,'evet')
            writeVideo(videokayit, double(arkaplan_cikmis_video));
        end
        
    end
end
if strcmp(video_kayit,'evet')
    close(videokayit);
end