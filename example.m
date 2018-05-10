U = [ 0    0.5   -1;
     -1    0    1;
      1   -1    0];
%     B    Y    O

%U = [.9,1,2.8;1,1.9,.8;1.8,1,1];
%U = U - ones(3);

p = [0; 0; 1];
q = [1; 0; 0];
W = p' * U * q
q = [0; 1; 0];
W = p' * U * q

f = @(t, x) ((U*x) - x'*U*x).*x;

MJRS = 0;

[~, xout] = ode45(f, [0 30], [0.5; 0.25; 0.25]);
ternplot(xout(:, 1), xout(:, 2), xout(:, 3),'k','majors',MJRS);

hold on

[~, xout] = ode45(f, [0 30], [0.8; 0.1; 0.1]);
ternplot(xout(:, 1), xout(:, 2), xout(:, 3),'k','majors',MJRS);


[~, xout] = ode45(f, [0 30], [0.9; 0.05; 0.05]);
ternplot(xout(:, 1), xout(:, 2), xout(:, 3),'k','majors',MJRS);


[~, xout] = ode45(f, [0 33], [0.2; 0.6; 0.2]);
ternplot(xout(:, 1), xout(:, 2), xout(:, 3),'k','majors',MJRS);

[~, xout] = ode45(f, [0 30], [.33,.33,.34]);
ternplot(xout(:,1), xout(:,2), xout(:,3),'k','majors',MJRS);

ternplot(xout(end,1),xout(end,2),xout(end,3),'majors', MJRS,'.k','MarkerSize',20)

%title("Some Solutions to $$\frac{dx_i}{dt} = \left(\left( U x \right)_i - x^T U x \right) x_i$$",'Interpreter','latex')
vertexlabel('Blue','Yellow','Orange')
set(gca,'FontSize',18);

%---------------vector field--------------
figure
ternquiver(f,20,'majors',MJRS,'k');
vertexlabel('Blue','Yellow','Orange')
%title("Vector field for $$\frac{dx_i}{dt} = \left(\left( U x \right)_i - x^T U x \right) x_i$$",'Interpreter','latex')
set(gca,'FontSize',18);
hold on
ternplot(xout(end,1),xout(end,2),xout(end,3),'majors', MJRS,'.k','MarkerSize',20)
xout(end,:)
