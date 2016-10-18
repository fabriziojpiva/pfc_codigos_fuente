function [chi,eta]=mapeo_inverso_bilineal(punto,X)
p1=X(1,:);
p2=X(2,:);
p3=X(3,:);
p4=X(4,:);

C_chi=cruz2D(punto,p4+p3-p1-p2)+.5*cruz2D(p4+p3,p1+p2);
B_chi=cruz2D(punto,(p3-p4-p2+p1))+cruz2D(p3,p2)+cruz2D(p1,p4);
A_chi=.5*cruz2D(p3-p4,p2-p1);

if(B_chi>0)
 if(A_chi!=0)
    chi=-B_chi+sqrt(B_chi*B_chi-4*A_chi*C_chi);
    chi=chi/(2*A_chi);
   else
      chi=-C_chi/B_chi;
   end
else
  chi=2*C_chi/(-B_chi+sqrt(B_chi*B_chi-4*A_chi*C_chi));
end

C_eta=cruz2D(punto,(p3+p2-p1-p4))+.5*cruz2D(p2+p3,p1+p4);
B_eta=cruz2D(punto,(p3-p2-p4+p1))+cruz2D(p3,p4)+cruz2D(p1,p2);
A_eta=.5*cruz2D(p3-p2,p4-p1);

if(B_eta>0)
  if(A_eta!=0)
    eta=-B_eta+sqrt(B_eta*B_eta-4*A_eta*C_eta);
    eta=eta/(2*A_eta);
   else
      eta=-C_eta/B_eta;
   end
else
  eta=2*C_eta/(-B_eta-sqrt(B_eta*B_eta-4*A_eta*C_eta));
end


endfunction