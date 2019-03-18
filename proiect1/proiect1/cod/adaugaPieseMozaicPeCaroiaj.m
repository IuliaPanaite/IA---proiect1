function imgMozaic = adaugaPieseMozaicPeCaroiaj(params)
%
%tratati si cazul in care imaginea de referinta este gri (are numai un canal)

imgMozaic = uint8(zeros(size(params.imgReferintaRedimensionata)));
[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);

switch(params.criteriu)
    case 'aleator'
        %pune o piese aleatoare in mozaic, nu tine cont de nimic
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                %alege un indice aleator din cele N
                indice = randi(N);    
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
    case 'distantaCuloareMedie'
        nrPieseAdaugate = 0;
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        %completati codul Matlab
        for i = 1: size(params.pieseMozaic,4)
            vmR = mean(mean(params.pieseMozaic(:,:,1,i)));
            vmG = mean(mean(params.pieseMozaic(:,:,2,i)));
            vmB = mean(mean(params.pieseMozaic(:,:,3,i)));
            
            CuloareMediePiese(i,:) = [vmR, vmG, vmB];
        end
%             params.imgReferintaRedimensionata
         for i =1:size(params.pieseMozaic(:,:,:,1),1):size(params.imgReferintaRedimensionata,1)
            for j=1:size(params.pieseMozaic(:,:,:,1),2):size(params.imgReferintaRedimensionata,2)
               % extrag ferestre din imgReferintaRedimensionata
               fereastra = params.imgReferintaRedimensionata(i:i+size(params.pieseMozaic(:,:,:,1),1)-1, j:j+size(params.pieseMozaic(:,:,:,1),2)-1,:);
               fmR = mean(mean(fereastra(:,:,1))); 
               fmG = mean(mean(fereastra(:,:,2)));
               fmB = mean(mean(fereastra(:,:,3)));
               
               % Calculez dist euclidiana
%                for k = 1:size(CuloareMediePiese,1)
%                   de(k) = sqrt(sum( (CuloareMediePiese(k,:)-[fmR, fmG, fmB]).^2 )) ;
%                end
               de = sqrt(sum( ((CuloareMediePiese-repmat([fmR, fmG, fmB],[size(CuloareMediePiese,1),1])).^2 ) ,2));
               % Aleg cea mai mica valoare din de
               [~, locatii] = sort(de);
                if(i == 1 && j == 1)
                    imgMozaic(i:i+size(params.pieseMozaic(:,:,:,1),1)-1, j:j+size(params.pieseMozaic(:,:,:,1),2)-1,:) = params.pieseMozaic(:,:,:,locatii(1));
                elseif(i == 1 && j ~= 1)
                        imgStanga = imgMozaic(i:i+size(params.pieseMozaic(:,:,:,1),1)-1, j-size(params.pieseMozaic(:,:,:,1),2):j-1,:);
                        imgStangaR = mean(mean(imgStanga(:,:,1))); 
                        imgStangaG = mean(mean(imgStanga(:,:,2)));
                        imgStangaB = mean(mean(imgStanga(:,:,3)));
                        
                        diff = sqrt(sum( ((CuloareMediePiese-repmat([imgStangaR, imgStangaG, imgStangaB],[size(CuloareMediePiese,1),1])).^2 ) ,2));
                        [~,locDiff] = sort(diff);
                        if(locDiff(1) == locatii(1))
                            imgMozaic(i:i+size(params.pieseMozaic(:,:,:,1),1)-1, j:j+size(params.pieseMozaic(:,:,:,1),2)-1,:) = params.pieseMozaic(:,:,:,locatii(2));
                        else
                            imgMozaic(i:i+size(params.pieseMozaic(:,:,:,1),1)-1, j:j+size(params.pieseMozaic(:,:,:,1),2)-1,:) = params.pieseMozaic(:,:,:,locatii(1));
                        end
                elseif (i ~= 1 && j == 1)
                        imgSus = imgMozaic(i-size(params.pieseMozaic(:,:,:,1),1):i-1, j:j+size(params.pieseMozaic(:,:,:,1),2)-1,:);
                        imgSusR = mean(mean(imgSus(:,:,1))); 
                        imgSusG = mean(mean(imgSus(:,:,2)));
                        imgSusB = mean(mean(imgSus(:,:,3)));
                        
                        diff = sqrt(sum( ((CuloareMediePiese-repmat([imgSusR, imgSusG, imgSusB],[size(CuloareMediePiese,1),1])).^2 ) ,2));
                        [~,locDiff] = sort(diff);
                        if(locDiff(1) == locatii(1))
                            imgMozaic(i:i+size(params.pieseMozaic(:,:,:,1),1)-1, j:j+size(params.pieseMozaic(:,:,:,1),2)-1,:) = params.pieseMozaic(:,:,:,locatii(2));
                        else
                            imgMozaic(i:i+size(params.pieseMozaic(:,:,:,1),1)-1, j:j+size(params.pieseMozaic(:,:,:,1),2)-1,:) = params.pieseMozaic(:,:,:,locatii(1));
                        end
                else
                    imgStanga = imgMozaic(i:i+size(params.pieseMozaic(:,:,:,1),1)-1, j-size(params.pieseMozaic(:,:,:,1),2):j-1,:);
                        imgStangaR = mean(mean(imgStanga(:,:,1))); 
                        imgStangaG = mean(mean(imgStanga(:,:,2)));
                        imgStangaB = mean(mean(imgStanga(:,:,3)));
                        
                        diffStanga = sqrt(sum( ((CuloareMediePiese-repmat([imgStangaR, imgStangaG, imgStangaB],[size(CuloareMediePiese,1),1])).^2 ) ,2));
                        [~,locDiffStanga] = sort(diffStanga);
                        
                        imgSus = imgMozaic(i-size(params.pieseMozaic(:,:,:,1),1):i-1, j:j+size(params.pieseMozaic(:,:,:,1),2)-1,:);
                        imgSusR = mean(mean(imgSus(:,:,1))); 
                        imgSusG = mean(mean(imgSus(:,:,2)));
                        imgSusB = mean(mean(imgSus(:,:,3)));
                        
                        diffSus = sqrt(sum( ((CuloareMediePiese-repmat([imgSusR, imgSusG, imgSusB],[size(CuloareMediePiese,1),1])).^2 ) ,2));
                        [~,locDiffSus] = sort(diffSus);
                        
                        index = 1;
                        
                        if(locDiffStanga(1) == locatii(1) || locDiffSus(1) == locatii(1))
                            index = index + 1;
                            if(locDiffStanga(1) == locatii(2) || locDiffSus(1) == locatii(2))
                                index = index + 1;
                            end
                        end
                        imgMozaic(i:i+size(params.pieseMozaic(:,:,:,1),1)-1, j:j+size(params.pieseMozaic(:,:,:,1),2)-1,:) = params.pieseMozaic(:,:,:,locatii(index));
                end
               %
%                 imgMozaic(i:i+size(params.pieseMozaic(:,:,:,1),1)-1, j:j+size(params.pieseMozaic(:,:,:,1),2)-1,:) = params.pieseMozaic(:,:,:,locatii(1));
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
    otherwise
        printf('EROARE, optiune necunoscuta \n');
    
end
    
    
    
    
    
