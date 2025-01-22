function [Eel] = matE_elem(S1, S2, S3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calcul de la matrice elementaire du bloc rectangulaire (p, dv1/dx)
%
% SYNOPSIS [Eel] = matE_elem(S1, S2, S3)
%
% INPUT * S1, S2, S3 : les 2 coordonnees des 3 sommets du triangle
%                      (vecteurs reels 1x2)
%
% OUTPUT - Eel matrice elementaire rectangulaire (matrice 6x3)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% preliminaires, pour faciliter la lecture:
x1 = S1(1); y1 = S1(2);
x2 = S2(1); y2 = S2(2);
x3 = S3(1); y3 = S3(2);

% calcul de la matrice elementaire du bloc rectangulaire (p, dv1/dx)
% ------------------------------------------------------------------
Eel = zeros(6,3);
Bl = zeros(2,2);
Bl = [x2-x1, x3-x1 ; y2-y1, y3-y1];
d=abs((x2-x1)*(y3-y1) - (x3-x1)*(y2-y1));
Bl_inv = inv(Bl');   %'
% Points et poids de quadrature
S_hat = [1/6, 1/6;
         2/3, 1/6;
         1/6, 2/3];

for i=1:6
    for j=1:3
        sum = 0;
        for k=1:3
            sum = sum + 1/6*lambda_hat(j,S_hat(k,:))*dot(Bl_inv(1,:),gradw(i,S_hat(k,:)));
        end % k
        Eel(i,j)=-d*sum;
    end
end
end % de la fonction principale


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

%Définition des lambdas
function lambda=lambda_hat(i,coord)
    x=coord(1);
    y=coord(2);
    if i==1
        lambda=1-x-y;
    elseif i==2
        lambda=x;
    elseif i==3
        lambda=y;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                        fin de la routine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%24