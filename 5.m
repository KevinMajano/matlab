% Newton-Raphson for a system of 3 nonlinear equations
% Same logic as the 2-variable course script, extended to x, y, z.
% Enter each equation in the form f(x,y,z) = 0, without quotes.
disp('-----------------Método de Newton-Raphson multivariable (3 variables)---------------')
syms x y z
f1=input('Introduzca la función f1: ');
f2=input('Introduzca la función f2: ');
f3=input('Introduzca la función f3: ');
x0=input('Introduzca el valor de x0: ');
y0=input('Introduzca el valor de y0: ');
z0=input('Introduzca el valor de z0: ');
tol=input('Introduzca el margen de error: 10^-');
F=[f1,f2,f3];
J=jacobian([f1,f2,f3],[x,y,z]);   % symbolic 3x3 Jacobian matrix
X0=[x0,y0,z0]';
tol=10^-tol;
cont=1;
error=1;
fprintf('n || x\t\t\t\t\t|| y\t\t\t\t  || z\t\t\t\t  ||  error\n')
fprintf('%d ||  %.15f ||  %.15f ||  %.15f || %e\n', cont, double(x0), double(y0), double(z0), 0)
while error>tol  &&  cont<100
    cont=cont+1;
    F0=double(subs(F,{x,y,z},{X0(1),X0(2),X0(3)}));   % F evaluated at current point
    J0=double(subs(J,{x,y,z},{X0(1),X0(2),X0(3)}));   % J evaluated at current point
    I=inv(J0);
    X1=X0-I*F0';                                      % Newton step
    error=norm(X1-X0);                                % Euclidean norm of the change
    X0=X1;
    fprintf('%d ||  %.15f ||  %.15f ||  %.15f || %e\n', cont, double(X1(1)), double(X1(2)), double(X1(3)), double(error))
end
fprintf('\nEl valor aproximado de x es: %.15f\n', double(X0(1)));
fprintf('El valor aproximado de y es: %.15f\n', double(X0(2)));
fprintf('El valor aproximado de z es: %.15f\n', double(X0(3)));
fprintf('El error es: %e\n', double(error));