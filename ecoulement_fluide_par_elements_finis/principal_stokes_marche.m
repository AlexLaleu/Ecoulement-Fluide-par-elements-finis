% =====================================================
%
% une routine pour la mise en oeuvre des EF Taylor-Hood
% (P^2-P^1) pour l equation de Stokes
%
% | - nu*\Delta u + \Grad p = f,   dans \Omega
% |                 - div u = 0,   dans \Omega
% |                       u = g,   sur \Gamma_D
% |           nu*du/dn - pn = 0,   sur \Gamma_N
%
% =====================================================

% lecture du maillage et affichage
% ---------------------------------
nom_maillage = 'geomRectangle_partie3_marche.msh';
[Nbpt,Nbtri,Coorneu,Refneu,Numtri,~,~,~,~] = lecture_msh_ordre2(nom_maillage);

nu =1;      % viscosite, valeur pouvant etre modifiee

% ----------------------
% calcul des matrices EF
% ----------------------

% declarations
% ------------

% on ne connait pas encore le nombre de sommets, attention ce n est pas la moitie du nombre des noeuds !

MM = sparse(Nbpt, Nbpt);    % matrice de masse
KK = sparse(Nbpt, Nbpt);    % matrice de rigidite : bloc (u_i, v_i)
EEtmp = zeros(Nbpt, Nbpt);  % bloc (p, v1) carre temporaire, ce bloc sera rectangulaire apres extraction des noeuds correspondant aux sommets
FFtmp = zeros(Nbpt, Nbpt);  % bloc (p, v2) carre temporaire, ce bloc sera rectangulaire apres extraction des noeuds correspondant aux sommets
isavertex = zeros(Nbpt, 1); % tableau booleen "is a vertex" reperant les noeuds qui sont des sommets (et pas des milieux)

% boucle sur les triangles
% ------------------------
for l=1:Nbtri

  % Coordonnees des sommets du triangle
    T = Numtri(l,:);
    S1=Coorneu(T(1),:);
    S2=Coorneu(T(2),:);
    S3=Coorneu(T(3),:);

  % On met 1 dans les entrees de isavertex correspondants aux 3 sommets
  isavertex(Numtri(l,1)) = 1;
  isavertex(Numtri(l,2)) = 1;
  isavertex(Numtri(l,3)) = 1;

  % Calcul des matrices elementaires du triangle l
  Mel = matM_elem_p2(S1, S2, S3);
  Kel = matK_elem_p2(S1, S2, S3);
  Eel = matE_elem(S1, S2, S3); 
  Fel = matF_elem(S1, S2, S3);
  
  % On fait l assemblage des blocs (u_i, v_i)
  for i=1:6
        I = T(i);
        for j=1:6
          J = T(j);
          KK(I,J) = KK(I,J) + Kel(i,j);
        end
    end 

  % On fait l assemblage des blocs (p, v1) et (p, v2)
   for i=1:6
        I = T(i);
        for j=1:3
          J = T(j);
          EEtmp(I,J) = EEtmp(I,J) + Eel(i,j);
          FFtmp(I,J) = FFtmp(I,J) + Fel(i,j);
        end
    end 

end % for l

%find(isavertex~=0) %donne la liste des numeros des sommets
numsommets = find(isavertex==1);
Ns = length(numsommets);   % nombre de sommets

EE = zeros(Nbpt, Ns);      % bloc rectangulaire (p, v1)
FF = zeros(Nbpt, Ns);      % bloc rectangulaire (p, v2)

% On extrait de EEtmp et FFtmp les colonnes correspondantes a des sommets
% (par ailleurs les autres colonnes sont a priori nulles)
EE=EEtmp(:,numsommets);
FF=FFtmp(:,numsommets);

% Matrice elements finis par blocs
% --------------------------------
AA = sparse(2*Nbpt + Ns, 2*Nbpt + Ns);

AA(1:Nbpt, 1:Nbpt) = nu*KK;
AA((Nbpt+1):(2*Nbpt), (Nbpt+1):(2*Nbpt)) = nu*KK;
AA(1:Nbpt, (2*Nbpt+1):(2*Nbpt + Ns)) = EE;
AA((Nbpt+1):(2*Nbpt), (2*Nbpt+1):(2*Nbpt + Ns)) = FF;
AA((2*Nbpt+1):(2*Nbpt + Ns), 1:Nbpt) = EE';
AA((2*Nbpt+1):(2*Nbpt + Ns), (Nbpt+1):(2*Nbpt)) = FF';

% Pseudo-elimination
% ------------------
% on n impose Dirichlet que sur les inconnues P2 de la vitesse
LL = zeros(2*Nbpt+Ns,1);  % vecteur second membre
[tilde_AA, tilde_LL] = elimine_stokes_marche(AA,LL,Refneu,Coorneu);

% Resolution du systeme lineaire
% ----------
UU = tilde_AA\tilde_LL;

% visualisation
% -------------
U1 = UU(1:Nbpt);
U2 = UU((Nbpt+1):(2*Nbpt));
P = UU((2*Nbpt+1):(2*Nbpt + Ns));

affiche_ordre2(U1, Numtri, Coorneu,sprintf('U1 - %s', nom_maillage));
affiche_ordre2(U2, Numtri, Coorneu,sprintf('U2 - %s', nom_maillage));

% Dans la i-eme entree de DEnumnoeudAnumsommet on trouve le numero en tant que sommet du i-eme noeud  
% (et on trouve 0 si l'i-eme noeud n'est pas un sommet) 
DEnumnoeudAnumsommet = zeros(Nbpt, 1);
DEnumnoeudAnumsommet(numsommets) = 1:Ns;   
% Pour l affichage on decale les numeros dans Numtri
NumtriDecale = zeros(Nbtri,3); 
NumtriDecale = DEnumnoeudAnumsommet(Numtri(:,1:3)); 
affiche_ordre1(P, NumtriDecale, Coorneu(numsommets,:),sprintf('pression - %s', nom_maillage));

% Affichage des flèches du vecteur vitesse
figure;
hold on;
quiver(Coorneu(:,1), Coorneu(:,2), U1, U2, 'r'); % Affiche les flèches en rouge
title(sprintf('Champ de vitesse - %s', nom_maillage));
xlabel('x');
ylabel('y');
axis equal; 
grid on;
hold off;
