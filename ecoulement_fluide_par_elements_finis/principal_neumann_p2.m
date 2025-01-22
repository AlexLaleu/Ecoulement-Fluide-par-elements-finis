% =====================================================
%
% une routine pour la mise en oeuvre des EF P2 Lagrange
% pour l equation de Laplace suivante, avec conditions de Neumann
%
% | -\Delta u + u= f,   dans \Omega
% |         du/dn = 0,   sur le bord
%
% =====================================================

% lecture du maillage et affichage
% ---------------------------------

% problème : valeurs de U obtenues trop grandes (de l ordre de 150 alors que ca devrait être de l ordre de 3)
% bug dans plot_log_log plot_log_log_regression_errL2

list_h = [0.4, 0.2, 0.1, 0.05];
err_L2 = zeros(4,1);
err_H1 = zeros(4,1);
for a=1:4
  h = list_h(a);
      if h==0.4
     nom_maillage = 'geomRectangle0.msh';
  end
  if h==0.2
    nom_maillage = 'geomRectangle1.msh';
  end
  if h==0.1
    nom_maillage = 'geomRectangle2.msh';
  end
  if h==0.05
     nom_maillage = 'geomRectangle3.msh';
  end

  [Nbpt,Nbtri,Coorneu,Refneu,Numtri,Reftri]= lecture_msh_ordre2(nom_maillage);

  % ----------------------
  % calcul des matrices EF
  % ----------------------

  % declarations
  % ------------
  KK = sparse(Nbpt,Nbpt); % matrice de rigidite
  MM = sparse(Nbpt,Nbpt); % matrice de masse
  LL = zeros(Nbpt,1);     % vecteur second membre

  % boucle sur les triangles
  % ------------------------
  for l=1:Nbtri

    % Coordonnees des sommets du triangles
    T = Numtri(l,:);
    S1=Coorneu(T(1),:);
    S2=Coorneu(T(2),:);
    S3=Coorneu(T(3),:);

    % Calcul des matrices elementaires du triangle l
    Kel=matK_elem_p2(S1, S2, S3);
    Mel=matM_elem_p2(S1, S2, S3);
    % On fait l assemblage des matrices globales
    for i=1:6
        I = T(i);
        for j=1:6
          J = T(j);
          MM(I,J) = MM(I,J)+Mel(i,j);
          KK(I,J) = KK(I,J) + Kel(i,j);
        end
    end 
  end % for l
  % Calcul du second membre
  % -------------------------
  % utiliser la routine f.m
  X = Coorneu(:,1); % Coorneu(:,1) = tous les x des sommets
  Y = Coorneu(:,2); % Coorneu(:,2) = tous les y des sommets
  FF = zeros(1,Nbpt);
  for i=1:Nbpt
    FF(i) = f(X(i),Y(i));
  end
  LL = MM*FF';  %l'interpolation

  % Resolution du systeme lineaire
  % ----------
  UU = (MM+KK)\LL;

  % visualisation
  % -------------
  affiche_ordre2(UU, Numtri, Coorneu,sprintf('Neumann - %s', nom_maillage));

  validation = 'oui';
  % validation
  % ----------
  if strcmp(validation,'oui')
    UU_exact = 3 * cos(pi * X) .* cos( 2*pi * Y);
    % Calcul de l erreur L2
    val_L2 = sqrt((UU_exact-UU)'*MM*(UU_exact-UU))/sqrt(UU_exact'*MM*UU_exact);  
    err_L2(a)= val_L2;       
    % Calcul de l erreur H1
    val_H1 = sqrt((UU_exact-UU)'*KK*(UU_exact-UU))/sqrt(UU_exact'*KK*UU_exact);  
    err_H1(a) = val_H1;
    % attention de bien changer le terme source (dans FF)
  end
  h = h/2;
end
disp(err_H1)
disp(err_L2)
plot_log_log_regression_errL2(list_h,err_L2,err_H1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                        fin de la routine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%24
