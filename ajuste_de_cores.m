function [resultado]= ajuste_de_cores()

% recuperando a imagem orignal
figure(1);
ImagemOriginal = double(imread('obama.jpeg'));
imshow(uint8(ImagemOriginal));
title('Imagem Original');

% ajustando a imagem e separando os canais para filtragem bilateral
ImagemOriginal = ImagemOriginal/255;
red = ImagemOriginal(:,:,1);
green = ImagemOriginal(:,:,2);
blue = ImagemOriginal(:,:,3);
ImagemFiltrada = zeros(size(ImagemOriginal));
[ImagemFiltrada(:,:,1)] = filtragem_bilateral(red,12,30,2);
[ImagemFiltrada(:,:,2)] = filtragem_bilateral(green,12,30,2);
[ImagemFiltrada(:,:,3)] = filtragem_bilateral(blue,12,30,2);

% arrumando os níveis de intensidade para que eles não fiquem entre 0 e 1
ImagemFiltrada = ImagemFiltrada*255;
figure(2);
imshow(uint8(ImagemFiltrada));
title('Imagem Filtrada');

% pegando o resultado da filtragem bilateral e aplicando sobre ele um
% filtro de mediana e uma operação de quantização
ImagemQuantizada = mediana_e_quantizacao(ImagemFiltrada, 35, 7);

% imprimindo na tela o resultado final do ajuste de cores para imagem
% com efeito cartoon
figure(3);
imshow(ImagemQuantizada);
title('Imagem Quantizada');

end
