function [resultado]= filtragem_bilateral(ImagemMonocromatica, janela, sigma_r, sigma_d)

% inicializando a imagem que irá conter a saída
[h w] = size(ImagemMonocromatica);
resultado = zeros(size(ImagemMonocromatica));

% obtendo a distância de cada ponto do centro de uma janela JxJ. Essa
% distância é que irá definir os pesos de cada posição do filtro quando
% estamos considerando a distância entre eles.
[x y] = meshgrid(-janela:janela, -janela:janela);

% a gaussiana abaixo calcula para cada pixel da janela qual que deve ser o
% seu peso quando estamos considerando a distância entre ele e o pixel
% central, que será o filtrado. Perceba que estes pesos serão os mesmos
% independente da posição da imagem que sobrepõe o pixel central, por isso,
% é necessário calcular estes valores apenas uma vez.
filtro_pesos_distancia = exp(-(x.^2+y.^2)/(2*sigma_d^2));

% para cada pixel...
for i=1:h
    for j=1:w
        
        % Definimos dentro da imagem, em relação ao pixel sendo avaliado
        % quais são os pixels pertencentes à janela que o circundam.
        % Perceba que para pixels na borda, a janela obtida pode ser menor 
        % do que o definido. Isso, porque, por exemplo, para um pixel na
        % posição (2,3), teremos imin = 1 e imax = 11 para janela indo de
        % -9 até 9. Perceba que deveríamos ter uma janela 18x18, mas ela
        % está menor pois o pixel está muito na borda para que a janela
        % possa sobrepo-lo sem deixar o espaço da imagem. 
        imin = max(i-janela,1);
        imax = min(i+janela,h);
        jmin = max(j-janela,1);
        jmax = min(j+janela,w);
        janela_imagem = ImagemMonocromatica(imin:imax,jmin:jmax);
        
        % Esta é a construção do filtro que considera o peso dos pixels
        % vizinhos ao central com base na instensidade destes pixels quando
        % elas são comparadas com a do pixel sendo filtrado. É uma
        % Gaussiana também.
        filtro_pesos_intensidades = exp(-(janela_imagem-ImagemMonocromatica(i,j)).^2/(2*sigma_r^2));
        
        % O filtro final será uma combinação dos pesos obtidos nos dois
        % filtros já calculados.
        filtro_bilateral = filtro_pesos_intensidades.*filtro_pesos_distancia((imin:imax)-i+janela+1,(jmin:jmax)-j+janela+1);
        
        % usado para normalizar o resultado
        divisor = sum(filtro_bilateral(:));
        
        % Aplicando o filtro de acordo com a equação. Aplicamos o filtro
        % para a janela da imagem em questão. Essa filtragem se dá elemento
        % por elementos por meio da multiplicação. Usamos sum of sum porque
        % ele soma primeiro todas as colunas e depois todas as linhas.
        resultado(i,j)=sum(sum(filtro_bilateral.*janela_imagem))/divisor;
    end
end

end

% REFERENCIAS
% https://github.com/GKalliatakis/Bilateral-Filtering/blob/master/bilateral_each_channel.m
% https://en.wikipedia.org/wiki/Bilateral_filter
% https://www.csie.ntu.edu.tw/~cyy/courses/vfx/10spring/lectures/handouts/lec14_bilateral_4up.pdf
