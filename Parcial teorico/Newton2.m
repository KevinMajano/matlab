% Newton-Raphson for a system of 2 nonlinear equations (course script)
% Enter each equation in the form f(x,y) = 0, without quotes.
disp('-----------------Método de Newton-Raphson multivariable---------------')
syms x y
f=input('Introduzca la función f: ');
g=input('Introduzca la función g: ');
x0=input('Introduzca el valor de x0: ');
y0=input('Introduzca el valor de y0: ');
tol=input('Introduzca el margen de error: 10^-');
F=[f,g];
J=jacobian([f,g],[x,y]);          % symbolic Jacobian matrix
X0=[x0,y0]';
tol=10^-tol;
cont=1;
error=1;
fprintf('n || x\t\t\t\t\t|| y\t\t\t\t  ||  error\n')
fprintf('%d ||  %.15f ||  %.15f || %e\n', cont, double(x0), double(y0), 0)
while error>tol  &&  cont<100
    cont=cont+1;
    F0=double(subs(F,{x,y},{X0(1),X0(2)}));   % F evaluated at current point
    J0=double(subs(J,{x,y},{X0(1),X0(2)}));   % J evaluated at current point
    I=inv(J0);
    X1=X0-I*F0';                              % Newton step
    error=norm(X1-X0);                        % Euclidean norm of the change
    X0=X1;
    fprintf('%d ||  %.15f ||  %.15f || %e\n', cont, double(X1(1)), double(X1(2)), double(error))
end