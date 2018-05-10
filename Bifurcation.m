p1 = 1;
p2 = -0.8;
p3 = 0;
p4 = 1;
p5 = 3.5;
p6 = -0.6;

U = [ 0  p1  p2;
     p3   0  p4;
     p5  p6   0];

x0 = [1/3; 1/3; 1/3];

tspan = [0, 200];

n = 300;

pval = linspace(-20,20,n);
equil = zeros(n,3);

figure

for j=1:n
    U(2,1) = pval(j); %bifurcating p1
    p3 = pval(j);
    f = @(t,x) ((U*x) - x'*U*x).*x; %turns out you have to define @f after U
    [~,x] = ode45(f,tspan,x0);
    equil(j,:) = x(end,:); %taking the approximate equilibrium pt.
    
    alpha = p1*p4 + p2*p6 - p4*p6;
    beta = p2*p3 + p4*p5 - p2*p5;
    gamma = p1*p5 + p3*p6 - p1*p3;
    
    eq1 = [0; p4/(p4+p6); p6/(p4+p6)]; %equilibrium points acording to
    %mathematica, they don't seem too accurate though...
    eq2 = [p2/(p2+p5); 0; p5/(p2+p5)];
    eq3 = [p1/(p1+p3); p3/(p1+p3);0];
    eq4 = [alpha; beta; gamma] ./ (alpha + beta + gamma);
    
    ternquiver(f,30,'majors',0)
    hold on
    %ternplot(x(end,1),x(end,2),x(end,3),'.k','MarkerSize',15)
    ternplot(x(:,1),x(:,2),x(:,3),'m')
    if all(eq1 <= 1) && all(eq1 >= 0) && alpha < 0
        ternplot(eq1(1),eq1(2),eq1(3),'.r','MarkerSize',15)
    end
    if all(eq2 <= 1) && all(eq2 >= 0) && beta < 0
        ternplot(eq2(1),eq2(2),eq2(3),'.g','MarkerSize',15)
    end
    if all(eq3 <= 1) && all(eq3 >= 0) && gamma < 0
        ternplot(eq3(1),eq3(2),eq3(3),'.b','MarkerSize',15)
    end
    if all(eq4 <= 1) && all(eq4 >= 0) && (p1 + p3 > 0) && (p2 + p5 > 0) && (p4 + p6 > 0)
        ternplot(eq4(1),eq4(2),eq4(3),'.m','MarkerSize',15)
    end
    vertexlabel('Blue','Yellow','Orange')
    hold off
    
    pause(0.01);
end

figure
p = plot(pval,equil);
p(1).Color = 'r';
p(2).Color = 'b';
p(3).Color = 'k';
title("Bifurcation with respect to p[n]")
legend('Blue','Yellow','Orange')
