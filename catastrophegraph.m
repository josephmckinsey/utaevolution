x0 = [0.6; 0.2; 0.2];

tspan = [0, 300];

figure
[t,x] = ode45(@(t, x) catastrophe(t, x),tspan,x0);

index = find(t > 100, 1);

ternquiver(@(t, x) catastrophe(200, x), 30,'majors',0)
hold on
%ternplot(x(end,1),x(end,2),x(end,3),'.k','MarkerSize',15)
ternplot(x(1:index,1),x(1:index,2),x(1:index,3),'k')
ternplot(x(index:end,1), x(index:end, 2), x(index:end, 3), 'b')
vertexlabel('Blue','Yellow','Orange', 0.03, true, 'FontSize', 22)
hold off
    
figure
plot(t, x(:, 1), 'b')
hold on
plot(t, x(:, 2), 'r')
plot(t, x(:, 3), 'k')
title("Abrupt Catastrophe of Population at t=100")
legend('Blue','Yellow','Orange')
set(gca, 'fontsize', 18)