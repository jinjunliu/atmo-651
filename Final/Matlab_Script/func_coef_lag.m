function[r,lag]=func_coef_lag(x,y,max_lag)
n=length(x);
r(1:2*max_lag+1)=nan;
r_sig(1:2*max_lag+1)=nan;
lag(1:2*max_lag+1)=nan;
if sum(isnan(x))>=1
else
    for l=1:2*max_lag+1
        lag(l)=l-max_lag-1;
        if lag(l)<0
           xnew=x(1:n+lag(l));
           ynew=y(1-lag(l):n);
        else
           xnew=x(1+lag(l):n);
           ynew=y(1:n-lag(l));
        end
        R=corrcoef(xnew,ynew);
        r(l)=R(1,2);
    end
end





