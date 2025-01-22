function [Kel] = matK_elem_p2(S1, S2, S3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calcul de la matrice de rigidité elementaire en P2 Lagrange
%
% SYNOPSIS [Kel] = matK_elem_p2(S1, S2, S3)
%
% INPUT * S1, S2, S3 : les 2 coordonnees des 3 sommets du triangle
%                      (vecteurs reels 1x2)
%
% OUTPUT - Kel matrice de rigidité elementaire (matrice 6x6)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% preliminaires, pour faciliter la lecture:
x1 = S1(1); y1 = S1(2);
x2 = S2(1); y2 = S2(2);
x3 = S3(1); y3 = S3(2);

% calcul de la matrice de rigidité
% -------------------------------
% Initialisation
Kel = zeros(6,6);
Bl = zeros(2,2);
Bl = [x2-x1, x3-x1 ; y2-y1, y3-y1];
d=abs((x2-x1)*(y3-y1) - (x3-x1)*(y2-y1));
Bl_inv = inv(Bl');   %'
% Points et poids de quadrature
S_hat = [1/6, 1/6;
         2/3, 1/6;
         1/6, 2/3];
for i=1:6
    for j=1:6
        sum = 0;
        for k=1:3
            sum = sum + 1/6*dot(Bl_inv*gradw(i,S_hat(k,:)),Bl_inv*gradw(j,S_hat(k,:))) ;
        end % k
        Kel(i,j)=d*sum;
    end
end

end %fin de la fonction principale

%Definition fonction des gradients des w_i
function grad = gradw(i, coord)
  x=coord(1);
  y=coord(2);
  if i==1
    grad = [-3+4*y+4*x; -3+4*x+4*y];
  elseif i==2
    grad = [4*x-1; 0];
  elseif i==3
    grad = [0; 4*y-1];
  elseif i==4
    grad = [4-8*x-4*y; -4*x];
  elseif i==5
    grad = [4*y; 4*x];
  elseif i==6
    grad = [-4*y; 4-4*x-8*y];
  end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                        fin de la routine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%24
