function [L,T,lmd,VC,CVC]=func_EOF_svd(x,M)
% EOF is calculated on the basis of Matlab function svd
[L S V]=svd(x, 0);% SVD(X,0) produces the "economy size" decomposition.

T=S*V';
lmd=(diag(S)).^2/size(x, 2); % lmd is a colum vector.
lmd=lmd'; % row vector.

VC(1:M)=lmd(1:M)/sum(lmd);
CVC=zeros(1, M);
for i=1:M
    CVC(i)=sum(VC(1:i));
end
lmd=lmd(1:M);
L=L(:,1:M)*diag(sqrt(lmd));
T=diag(1./sqrt(lmd))*T(1:M,:);
