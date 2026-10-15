% Fixed-point iteration for a system of 3 nonlinear equations (course script)
% Each equation must be solved for one variable first:
%   x = g1(x,y,z),  y = g2(x,y,z),  z = g3(x,y,z)
% Enter only the right-hand sides, without quotes.
fprintf('-----------------Método de Punto fijo multivariable---------------\n');
syms x y z
fx=input('Ingrese X: ');
fy=input('Ingrese Y: ');
fz=input('Ingrese Z: ');
x0=input('Introduzca el valor inicial de x: ');
y0=input('Introduzca el valor inicial de y: ');
z0=input('Introduzca el valor inicial de z: ');
tol=input('Introduzca el margen de error: 10^-');
tol=10^-tol;
% double() added: keeps values numeric so iterations do not slow down
x1=double(subs(fx,{x,y,z},{x0,y0,z0}));
y1=double(subs(fy,{x,y,z},{x0,y0,z0}));
z1=double(subs(fz,{x,y,z},{x0,y0,z0}));
cont=1;
ERROR(1)=double(abs(x1-x0));
ERROR(2)=double(abs(y1-y0));
ERROR(3)=double(abs(z1-z0));
error=double(max(ERROR));            % largest change among x, y, z
fprintf('n || x\t\t\t\t\t|| y\t\t\t\t  ||  z\t\t\t\t  ||  error\n')
fprintf('%d ||  %.15f ||  %.15f ||  %.15f || %e\n', cont, double(x1), double(y1), double(z1), double(error))
while error>tol  &&  cont<100
    x0=x1;
    y0=y1;
    z0=z1;
    % All three updates use the values from the previous iteration
    x1=double(subs(fx,{x,y,z},{x0,y0,z0}));
    y1=double(subs(fy,{x,y,z},{x0,y0,z0}));
    z1=double(subs(fz,{x,y,z},{x0,y0,z0}));
    ERROR(1)=double(abs(x1-x0));
    ERROR(2)=double(abs(y1-y0));
    ERROR(3)=double(abs(z1-z0));
    error=double(max(ERROR));
    cont=cont+1;
    fprintf('%d ||  %.15f ||  %.15f ||  %.15f || %e\n', cont, double(x1), double(y1), double(z1), double(error))
end
fprintf('\nEl valor aproximado de x es: %.15f\n', double(x1));
fprintf('\nEl valor aproximado de y es: %.15f\n', double(y1));
fprintf('\nEl valor aproximado de z es: %.15f\n', double(z1));
fprintf('\nEl error es: %.15f\n', double(error));