clc
clear all

c = [-4;
     -3;
     -2;
     -2;
     -1];
A = [2 0 0 0 0;
     0 2 2 2 1;
     0.2 1 0 0.5 0;
     1 0 0 0 0;
     0 0 1 0 0;
     1 1 1 0 0;
     0 0 0 1 1];
 b = [36;
      216;
      18;
      16;
      2;
      34;
      28];
 lb = [0;
       0;
       0;
       0;
       0];
 %options = optimoptions('linprog', 'Algorithm', 'interior-point', 'Display', 'iter');
 %options = optimoptions('linprog', 'Algorithm', 'interior-point', 'Display', 'off');
 %options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'iter');
 options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'off');
 [x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options)
 fval = -fval
 
 opt = x;
 %There is no upper limit sice the optimal solution already uses the max
 %amount of PI so the upper limit will be infinity
 while 1
     c(1) = c(1) + 0.001;
      [x,fval,exitflag,output,lambda] = linprog(c', A, b, [], [], lb, [], [], options);
      if ~isequal(x,opt)
          break; 
      end  
 end;
 c
 x
 
 %gives alpha = 0.6 and beta = inf