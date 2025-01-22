function [Mel] = matM_elem_p2(S1, S2, S3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calcul de la matrice de masse elementaire en P2 Lagrange
%
% SYNOPSIS [Mel] = matM_elem_p2(S1, S2, S3)
%
% INPUT * S1, S2, S3 : les 2 coordonnees des 3 sommets du triangle
%                      (vecteurs reels 1x2)
%
% OUTPUT - Mel matrice de masse elementaire (matrice 6x6)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% preliminaires, pour faciliter la lecture:
x1 = S1(1); y1 = S1(2);
x2 = S2(1); y2 = S2(2);
x3 = S3(1); y3 = S3(2);

% calcul de la matrice de masse
% -------------------------------
% Initialisation
Mel = sparse(6,6); 

% Points et poids de quadrature
S_hat = [0.0915762135098, 0.0915762135098;
         0.8168475729805, 0.0915762135098;
         0.0915762135098, 0.8168475729805;
         0.1081030181681, 0.4459484909160;
         0.4459484909160, 0.1081030181681;
         0.4459484909160, 0.4459484909160];
poids = [0.05497587183, 0.05497587183, 0.05497587183, 0.1116907948, 0.1116907948, 0.1116907948];
Bl = zeros(2,2);
Bl = [x2-x1 x3-x1 ; y2-y1 y3-y1];
d=abs(det(Bl));
Sl = [x1 ; y1];
for i=1:6
    for j=1:6
        sum = 0;
        for k=1:6
            sum = sum + poids(k)*w(i,S_hat(k,:))*w(j,S_hat(k,:));
        end % k
        Mel(i,j)=d*sum;
    end
end

end %fin de la fonction principale

% définition des w_i : 
function s = w(i,coord)
    x=coord(1);
    y=coord(2);
  if i==1
    s = (1-x-y)*(1-2*x-2*y);
  end
  if i==2
    s = x*(2*x-1);
  end
  if i==3
    s = y*(2*y-1);
  end
  if i==4
    s = 4*x*(1-x-y);
  end
  if i==5
    s = 4*x*y;
  end
  if i==6
    s = 4*y*(1-x-y);
  end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                        fin de la routine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%24
