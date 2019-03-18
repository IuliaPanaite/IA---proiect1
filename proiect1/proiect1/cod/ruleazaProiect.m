%proiect REALIZAREA DE MOZAICURI
%

%%
%seteaza parametri pentru functie

%culoaea pozei
%optiuni: 'color', 'alb-negru'
params.culoare = 'color';

%citeste imaginea care va fi transformata in mozaic
%puteti inlocui numele imaginii
switch params.culoare
    case 'color'
        params.imgReferinta = imread('../data/imaginiTest/ferrari.jpeg');
        
    case 'alb-negru'
        params.imgReferinta = rgb2gray(imread('../data/imaginiTest/ferrari.jpeg'));
end

[h,w,c] = size(params.imgReferinta);

if (c ~= 3)
    params.culoare = 'alb-negru';
end
%seteaza directorul cu imaginile folosite la realizarea mozaicului
%puteti inlocui numele directorului
params.numeDirector = '../data/colectie/';

params.tipImagine = 'png';

%seteaza numarul de piese ale mozaicului pe orizontala
%puteti inlocui aceasta valoare
params.numarPieseMozaicOrizontala = 100;
%numarul de piese ale mozaicului pe verticala va fi dedus automat

%seteaza optiunea de afisare a pieselor mozaicului dupa citirea lor din
%director
params.afiseazaPieseMozaic = 0;

%seteaza modul de aranjare a pieselor mozaicului
%optiuni: 'aleator','caroiaj'
params.modAranjare = 'caroiaj';

%seteaza criteriul dupa care realizeze mozaicul
%optiuni: 'aleator','distantaCuloareMedie'
params.criteriu = 'distantaCuloareMedie';

%%
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);

imwrite(imgMozaic,'mozaic.jpg');
figure, imshow(imgMozaic)