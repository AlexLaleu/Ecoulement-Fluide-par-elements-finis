function [AA_tilde, LL_tilde] = elimine_stokes(AA,LL,Refneu,Coorneu)

    [n, m] = size(AA);
    Nbpt=size(Refneu,1);
    LL_tilde = sparse(n,1);
    AA_tilde = zeros(n,m);
    AA_tilde = AA;
    LL_tilde=LL;
    for i=1:Nbpt
        % si on est sur la partie du bord concernée par les conditions aux limites de Dirichlet
        if Refneu(i)==1 || Refneu(i)==2
            AA_tilde(i,:)=0;
            AA_tilde(i,i)=1;
            AA_tilde(i+Nbpt,:)=0;
            AA_tilde(i+Nbpt,i+Nbpt)=1;
            LL_tilde(i)=g1(Refneu,Coorneu, i);
            LL_tilde(i+Nbpt)=g2(Refneu, Coorneu, i);
        end
    end
end

