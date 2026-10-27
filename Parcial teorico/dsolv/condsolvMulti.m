% Exact solution of the system x' = -4x - 2y + cos(t) + 4sin(t), y' = 3x + y - 3sin(t)
% with x(0)=0, y(0)=-1
[X Y] = dsolve('Dx=-4*x-2*y+cos(t)+4*sin(t)','Dy=3*x+y-3*sin(t)','x(0)=0','y(0)=-1')

T = [0:0.02:0.2]; % Array of t values

% Table: column 1 = x(t), column 2 = y(t)
Exacta = [double(subs(X,T))' double(subs(Y,T))']