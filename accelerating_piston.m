close all
clear all
clc

set(gca,'FontSize',18)
set(gca,'LineWidth',2)

c_0 = 1;a = 1;

for t_0 = [0.2:0.2:2]
    t = t_0:0.01:2;
    X = (3/2*a*t_0 + c_0)*t - c_0*t_0 - a*t_0^2;
    plot(X,t,'b','Linewidth',2)
    hold on
end

t = 0:0.01:2;
plot(t,t,'g','Linewidth',2)

for t_0 = [0.2:0.2:3]
    plot(t+t_0,t,'r','Linewidth',2)
    axis([0,3,0,2])
    hold on
end

plot(1/2*a*t.^2,t,'k--','Linewidth',2)
xlabel('x')
ylabel('t')
hold off

print -djpeg accelerating_piston

figure
set(gca,'FontSize',18)
set(gca,'LineWidth',2)

delete accelerating_piston.gif

for t = 0:0.05:0.8;
t_0 = 0:0.01:t;
x = (3/2*a*t_0 + c_0)*t - c_0*t_0 - a*t_0.^2;
c_plate = a*t_0/2 + c_0;
h = (c_plate).^2;
x_2 = c_0*t + 0:0.01:1;
plot(x,h,'Linewidth',2)
hold on
plot(x,h,x_2,ones(size(x_2)),'Linewidth',2)
rectangle('Position',[0,0,a*t^2/2+0.000001,3],'FaceColor','r')
axis([0,1,0,4])
xlabel('x')
ylabel('h')
title(['t = ',num2str(t,'%1.1f')],'FontSize',18)
pause(0.1)
gif_add_frame(gcf,'accelerating_piston.gif',1);
hold off
end
