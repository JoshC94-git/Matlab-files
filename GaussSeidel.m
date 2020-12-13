N=50;
u=zeros(N,N);
x=linspace(0,1,N);
y=x;
[X,Y]=meshgrid(x,y);
u(end,:)=sin(2*pi*y);
l=1;
m=10000;

for iterations = 1:m+1;
    for i=2:N-1
        for j=2:N-1
            u(i,j)=1/4*(u(i+1,j)+u(i-1,j)+u(i,j+1)+u(i,j-1));
        end
    end 
    
    if mod(iterations-1,m/8)==0
        subplot(3,3,l);
        mesh(X,Y,u);
        axis('tight')
       
        title(['Iteration =',num2str(iterations)])
        l=l+1;
        pause(0.2)
    end 
end 

for yi = 1:length(y)
    for xi = 1:length(x)
           ye(xi,yi)=sin(2.*pi.*y(yi)).*sinh(2.*pi.*x(xi))./sinh(2.*pi);
    end
end
figure('Name','Exact Solution');
mesh(X,Y,ye);
title('Exact Solution')

figure('Name','Error');
error=abs(ye-u);
mesh(X,Y,error)
title('Error')