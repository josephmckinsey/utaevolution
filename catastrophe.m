function [ f ] = catastrophe( t, x )
%CATASTROPHE Summary of this function goes here
%   Detailed explanation goes here

if t < 100
    p1 = 1;
    p2 = -0.8;
    p3 = 0;
    p4 = 1;
    p5 = 3.5;
    p6 = -0.6;
else
    p1 = 1;
    p2 = -0.8 + 2;
    p3 = 0;
    p4 = 1;
    p5 = 3.5;
    p6 = -0.6;
end

U = [ 0  p1  p2;
     p3   0  p4;
     p5  p6   0];

f = ((U*x) - x'*U*x).*x;
 
end

