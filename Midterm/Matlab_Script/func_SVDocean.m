function[a,b,P,Q,thegma,SCF,r_coor]=func_SVDocean(S,Z,mod_num)

[Ns,n]=size(S);
[Nz,n]=size(Z);
Csz=1/n*S*Z';
[P,thegma,Q]=svd(Csz,'econ');
disp(size(P));
disp(size(thegma));
disp(size(Q));
%[P,thegma,Q]=svdecon(Csz);
K=min(Ns,Nz);
r=thegma(1:K,1:K)*thegma(1:K,1:K);
C=trace(r);
for i=1:mod_num
SCF(i)=r(i,i)/C;
end

a=P'*S;
disp(size(a));
b=Q'*Z;
Css=1/n*S*S';
Czz=1/n*Z*Z';
ds=trace(Css);
dz=trace(Czz);
Css_svd=1/n*a*a';
Czz_svd=1/n*b*b';

for i=1:mod_num
    r_coor(i)=sqrt(r(i,i)/(Css_svd(i,i)*Czz_svd(i,i)));
end

P=P(:,1:mod_num);
Q=Q(:,1:mod_num);
a=a(1:mod_num,:);
b=b(1:mod_num,:);

