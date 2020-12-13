clear all;
syms x y;

ph = [(1-x-y)*(1-2*x-2*y), x*(2*x-1), y*(2*y-1), 4*x*(1-x-y), 4*x*y,...
    4*y*(1-x-y)];

%mass matrix on reference element
for i = 1:6
    for j = 1:6 
        M(i,j) = int(int(ph(i)*ph(j),x,0,1-y),y,0,1);
    end
end

%compute the gradient as row vectors
for i=1:6 
    G(i,:) = [diff(ph(i),x),diff(ph(i),y)];
end

%stiffness matrix

for i=1:6
    for j=1:6 
        S(i,j) = int(int(G(i,:)*G(j,:)',x,0,1-y),y,0,1);
    end
end

M;
G;
S;



for i=1:6
    for j=1:6 
        S1(i,j) = int(int(diff(ph(i),x)*diff(ph(j),x),x,0,1-y),y,0,1);
    end
end

for i=1:6
    for j=1:6 
        S2(i,j) = int(int(diff(ph(i),y)*diff(ph(j),y),x,0,1-y),y,0,1);
    end
end

for i=1:6
    for j=1:6 
        S3(i,j) = int(int(diff(ph(i),x)*diff(ph(j),y)+...
            diff(ph(i),y)*diff(ph(j),x),x,0,1-y),y,0,1);
        
    end
end

S1
S2
S3