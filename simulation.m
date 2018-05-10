p1 = 1;
p2 = -1;
p3 = -1;
p4 = 1;
p5 = 1;
p6 = -1;

U = [ 0  p1  p2;
     p3   0  p4;
     p5  p6   0];

x0 = [.2; .2; .6];

tspan = [0, 100];

%n = 300;

pval = -5:0.1:5;
n = length(pval);
equil = zeros(n,3);

%M = VideoWriter('sim_a5.avi');
%M.FrameRate = 15;
%M.Quality = 100;

%open(M);

figure(1)
for j=1:n
    U(1,3) = pval(j);
    p2 = pval(j);
    f = @(t,x) ((U*x) - x'*U*x).*x; %turns out you have to define @f after U
    [~,x] = ode45(f,tspan,x0);
    
    eq1 = [0; p4/(p4+p6); p6/(p4+p6)]; %equilibrium points acording to
    %mathematica, they don't seem too accurate though...
    eq2 = [p2/(p2+p5); 0; p5/(p2+p5)];
    eq3 = [p1/(p1+p3); p3/(p1+p3);0];
    eq4 = [(p1*p4+(p2-p4)*p6)/(p4*p5+p1*(-p3+p4+p5)+p3*p6-p4*p6+p2*(p3-p5+p6));
           (p2*(p3-p5)+p4*p5)/(p4*p5+p1*(-p3+p4+p5)+p3*p6-p4*p6+p2*(p3-p5+p6));
           (p1*(p3-p5)-p3*p6)/(p4*p5+p1*(-p3+p4+p5)+p3*p6-p4*p6+p2*(p3-p5+p6))];
    a = p1*p4+p2*p6-p4*p6;
    b = p2*p3+p4*p5-p2*p5;
    c = p1*p5+p3*p6-p1*p3;
    eq5 = [a;b;c]/(a+b+c);
    eq6 = [1;0;0];
    eq7 = [0;1;0];
    eq8 = [0;0;1];
    
    ternquiver(f,30,'majors',0)
    hold on
    ternplot(x(:,1),x(:,2),x(:,3),'m')
    
    if all(eq1 <= 1) && all(eq1 >= 0) && p4 > 0 && p6 > 0 && a < 0
        ternplot(eq1(1),eq1(2),eq1(3),'.r','MarkerSize',15)
    end
    if all(eq2 <= 1) && all(eq2 >= 0) && p2 > 0 && p5 > 0 && b < 0
        ternplot(eq2(1),eq2(2),eq2(3),'.g','MarkerSize',15)
    end
    if all(eq3 <= 1) && all(eq3 >= 0) && p1 > 0 && p3 > 0 && c > 0
        ternplot(eq3(1),eq3(2),eq3(3),'.b','MarkerSize',15)
    end
    %if all(eq4 <= 1) && all(eq4 >= 0)
    %    ternplot(eq4(1),eq4(2),eq4(3),'.m','MarkerSize',15)
    %end
    if all(eq5 <= 1) && all(eq5 >= 0)
        ternplot(eq5(1),eq5(2),eq5(3),'.k','MarkerSize',15)
    end
    ternplot(eq6(1),eq6(2),eq6(3),'.k','MarkerSize',15)
    ternplot(eq7(1),eq7(2),eq7(3),'.k','MarkerSize',15)
    ternplot(eq8(1),eq8(2),eq8(3),'.k','MarkerSize',15)
    hold off
    
    title(num2str(pval(j)))
    vertexlabel('Blue','Yellow','Orange')
    
    %frame = getframe(gcf);
    %writeVideo(M,frame);
    
    pause(0.01);
    if pval(j)==-1/2 || pval(j)==1
        for i = 1:30
            %writeVideo(M, frame);
        end
        pause(1);
    end
end

%close(M);