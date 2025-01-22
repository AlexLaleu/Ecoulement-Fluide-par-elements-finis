function g1=g1_marche(Refneu, Coorneu, i)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fonction qui renvoie la valeur de g1 au point M_i du bord 
% concerné par les conditions de Dirichlet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if Refneu(i)==1
        g1=-4*(Coorneu(i,2)-1)*(Coorneu(i,2)-2);
    end
    if Refneu(i)==2
        g1=0;
    end
end