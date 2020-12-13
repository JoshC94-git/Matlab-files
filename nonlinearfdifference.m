%nonlinear finite difference method

 tol = 1e-10; %tolerance
 NN = 1000; %maximum number of iterations
 
%f = @(x,y,yp) -yp.^2-y+log(x); %right hand side
%fy = @(x,y,yp) -1+0*x;         %partial derivative of f with respect to y
%fyp = @(x,y,yp)  -2*yp;        %partial derivative of f with respect to y'

%f = @(x,y,yp) 0.5*(1-yp.^2-y.*sin(x));
%fy = @(x,y,yp) -0.5*sin(x);
%fyp = @(x,y,yp) -1.*yp;

f = @(x,y,yp) -y.*yp+y.^3;
fy = @(x,y,yp) -yp+3.*y.^2;
fyp = @(x,y,yp) -y;

N = 10; %number of points in the interval 
%alpha =0; beta =log(2);
alpha=0.5; beta=1/3;
a=1;b=2;
%a=0; b=pi;
h = (b-a)/(N+1);
w = linspace(alpha,beta,N+2)';
w = w(2:end-1);

 A = zeros(N,1);
 B = zeros(N,1);
 C = zeros(N,1);
 D = zeros(N,1);
 
 for j=1:NN 
     
x= a+h;
t= (w(2)-alpha)/(2*h);
A(1) = 2+h^2*fy(x,w(1),t);
B(1)=-1+h/2*(fyp(x,w(1),t));
D(1) = -(2*w(1)-w(2)-alpha+h^2*f(x,w(1),t));

x=b-h;t=(beta-w(N-1))/(2*h);
A(N) = 2+h^2*fy(x,w(N),t);
C(N)=-1-h/2*fyp(x,w(N),t);
D(N) = -(2*w(N)-w(N-1)-beta+h^2*f(x,w(N),t));

for i =2:N-1
x= a+i*h;t=(w(i+1)-w(i-1))/(2*h);
A(i) = 2+h^2*fy(x,w(i),t);
B(i)= -1+h/2*fyp(x,w(i),t);
C(i)= -1-h/2*fyp(x,w(i),t);
D(i) = -(2*w(i)-w(i+1)-w(i-1)+h^2*f(x,w(i),t));
end

C=[C(2:end);0];B=[0;B(1:end-1)];
M = spdiags([C,A,B],-1:1,N,N);%M is the Jacobian matrix

%Newton iteration

v = M\D;
w = w+v;
if (norm(v) <= tol)
break;
end
end

w = [alpha;w;beta];

yexact = @(x) 1./(1+x);



xi = linspace(a,b,N+2);
ye=feval(yexact,xi);
error = norm(ye-w')
figure;
plot(xi,abs(ye-w'),'linewidth',1);
%legend('exact','numerical');
set(gca,'fontsize',15);
