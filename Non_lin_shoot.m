%this is a nonlinear shooting method to compute 
%the solution of y'' =  f(x,y,y')
% y(a) = alpha and y(b) = beta. xspan gives
% the x-values where we want to compute the 
%solution.
clear figure

%alpha=17;beta=43/3;a=1;b=3;n=100;

alpha=1/2;beta=1/3;a=1;b=2;n=10;

%alpha = 0; beta =log(2);a=1;b=2;n=100;

%a=0;b=pi;alpha=2;beta=2;

options = odeset('RelTol',1e-14,'AbsTol',1e-14);
tol = 1e-15;
             
xspan =linspace(a,b,n);
tk=0; y = zeros(n,4);
while (abs(y(end,1) - beta) > tol)
y0=[alpha;tk;0;1];
[x, y] = ode45 ('rhsn1', xspan, y0,options);
%[x, y] = ode45 ('rhsn1', xspan, y0);
tk= tk - (y(end,1)-beta)/(y(end,3));
end

plot(xspan,y(:,1),'linewidth',1);
set(gca,'fontsize',15);

%yexact = @(x) (x.^2+16./x);
%yexact = @(x) (log(x));
yexact = @(x) (1./(1+x));
%yexact = @(x) (2+sin(x));

ye = feval(yexact,x);
figure; 
plot(xspan,y(:,1)-ye,'linewidth',1);
set(gca,'fontsize',15);
