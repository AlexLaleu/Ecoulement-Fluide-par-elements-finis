function result = f_homogene(x, y)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %calcul du second membre à linterieur de Omega 
    %pour les conditions de Dirichlet homogènes
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    result = (3 + 6 * pi^2)* sin(pi * x) .* sin(pi * y);
end