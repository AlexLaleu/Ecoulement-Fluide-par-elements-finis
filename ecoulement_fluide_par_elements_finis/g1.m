function g1=g1(Refneu, Coorneu, i)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fonction qui renvoie la valeur de g1 au point M_i du bord 
% concerné par les conditions de Dirichlet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    if Refneu(i)==2
        g1=0;
    end
    if Refneu(i)==1
        g1=(2-Coorneu(i,2))*Coorneu(i,2);
    end
end
