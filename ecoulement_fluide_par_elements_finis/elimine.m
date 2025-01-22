function [AA_tilde, LL_tilde] = elimine(AA, LL, Refneu, Coorneu, test_homogene)

% Les noeuds du bord ont une reference 1 donc on copie les autres noeuds utiles
REFINT = find(Refneu==0);
Nbpt = size(Refneu,1);
LL_tilde = zeros(Nbpt,1);
LL_tilde(REFINT) = LL(REFINT);

AA_tilde = zeros(Nbpt,Nbpt);
AA_tilde = AA;
REFINT_bis = find(Refneu==1);

AA_tilde(REFINT_bis,:) = 0;
if test_homogene==1
    AA_tilde(:,REFINT_bis) = 0;
end
for i=1:Nbpt
        if Refneu(i) == 1
            AA_tilde(i,i) = 1;
        end
end

GG = zeros(Nbpt,1);
if test_homogene == 0  %dans ce cas on a une condition non nulle sur le bord : il faut changer LL_tilde
    GG = g(Refneu, Coorneu, Nbpt);
    REFINT_bis = find(Refneu==1);
    LL_tilde(REFINT_bis) = GG(REFINT_bis);
end

end 