clc
clear all

c = -[1 5];
A = [2 -1;
     -1 1;
     1 4];
 b = [4;
      1;
      12];
 lb = zeros(2,1);
 %options = optimoptions('intlinprog', 'Display', 'iter');
 options = optimoptions('intlinprog', 'Display', 'off');
 intcon = [1;
           2];
[x, fval, exitflag, output] = intlinprog(c, intcon, A, b, [], [], lb, [], options)
fval = -fval

%%
clc
clear all

c = -[1 5];
A = [2 -1;
     -1 1;
     1 4];
   %  -1 0
   %  0 -1];
 b = [4;
      1;
      12];
    %  -2;
   %   -3];
 lb = zeros(2,1);

 options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'off');
 [x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options)
 fval = -fval
 
 %%
 % floor() and ceil()
 %initial values on x1 and x2
 objFunc = @(x) x(1)+5.*x(2);
 x = [1.6;
     2.6];
 %initial upper bound
 upBound = objFunc(x)
 lowBound = objFunc(floor(x))
 
 
 %if rem(value,1) == 0 => value is integer
 
 
 