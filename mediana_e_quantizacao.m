function [resultado]= mediana_e_quantizacao(Imagem, nivel_quantizacao, tam_filtro_mediana)

% criando o espaço de armazenamento para a imagem resultante
resultado = zeros(size(Imagem));

% aplicando o filtro de mediana em cada canal
resultado(:,:,1) = medfilt2(Imagem(:,:,1), [tam_filtro_mediana, tam_filtro_mediana]);
resultado(:,:,2) = medfilt2(Imagem(:,:,2), [tam_filtro_mediana, tam_filtro_mediana]);
resultado(:,:,3) = medfilt2(Imagem(:,:,3), [tam_filtro_mediana, tam_filtro_mediana]);

% quantizando a imagem
resultado = round(resultado/nivel_quantizacao);
resultado = uint8(resultado.*nivel_quantizacao);

% REFERENCIAS
% https://www.mathworks.com/help/images/ref/medfilt2.html
% https://stacks.stanford.edu/file/druid:yt916dh6570/Dade_Toonify.pdf

end
