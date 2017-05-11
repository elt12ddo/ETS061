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
 b = [4;
      1;
      12];
 lb = zeros(2,1);

 options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'off');
 [x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options)
 fval = -fval