% Exact solution of y''' + 2y'' - y' - 2y = e^t with y(0)=1, y'(0)=2, y''(0)=0
exacta = dsolve('D3y+2*D2y-Dy-2*y=exp(t)','y(0)=1','Dy(0)=2','D2y(0)=0')

% Nodes from 0 to 0.5 with step 0.05
T = [0:0.05:0.5];

% Evaluate the exact solution at each node
Y = subs(exacta, T);

% Show the values as a decimal column
double(Y')