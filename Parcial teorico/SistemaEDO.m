% RK4 for a system of two first-order ODEs: x' = f(t,x,y), y' = g(t,x,y)
syms x y t
disp('Sistemas de EDO')
f=input('Ingrese la primer ecuación diferencial dx/dt:');
g=input('Ingrese la segunda ecuación diferencial dy/dt:');
intervalo=input('Ingrese el intervalo [a,b]:');
x0=input('Ingrese el valor inicial x0:');
y0=input('Ingrese el valor inicial y0:');
%F=input('Ingrese la solución exacta de la ecuación diferencial:');
h=input('Ingrese le valor de h:');
a=intervalo(1);
b=intervalo(2);
T=[a:h:b];
n=length(T)-1;
Y(1)=y0;
X(1)=x0;

% Table header (the initial row is commented out in the original)
fprintf('ti\t\t\t\t\t\t || k11\t\t\t     || k12\t\t\t     || k21\t\t\t     || k22\t\t\t     || k31\t\t\t     || k32\t\t\t     || k41\t\t\t     || k42\t\t\t     || Xi\t\t\t\t\t\t || Y(i)\t\t\t\t\t \n');
%fprintf('%.15f\t ||  %.9f\t ||  %.9f\t ||  %.9f\t ||  %.9f\t ||  %.9f\t ||  %.9f\t ||  %.9f\t ||  %.9f\t || %.15f\t || %.15f\t \n', T(1),0,0,0,0,0,0,0,0,double(X(1)), double(Y(1)));

for i=1:n
    % k1: slopes at the start of the step
    k11=subs(f,{t,x,y},{T(i),X(i),Y(i)});
    k12=subs(g,{t,x,y},{T(i),X(i),Y(i)});
    % k2: slopes at the midpoint using k1
    k21=subs(f,{t,x,y},{T(i)+h/2,X(i)+(h/2)*k11,Y(i)+(h/2)*k12});
    k22=subs(g,{t,x,y},{T(i)+h/2,X(i)+(h/2)*k11,Y(i)+(h/2)*k12});
    % k3: slopes at the midpoint using k2
    k31=subs(f,{t,x,y},{T(i)+h/2,X(i)+(h/2)*k21,Y(i)+(h/2)*k22});
    k32=subs(g,{t,x,y},{T(i)+h/2,X(i)+(h/2)*k21,Y(i)+(h/2)*k22});
    % k4: slopes at the end of the step using k3
    k41=subs(f,{t,x,y},{T(i)+h,X(i)+h*k31,Y(i)+h*k32});
    k42=subs(g,{t,x,y},{T(i)+h,X(i)+h*k31,Y(i)+h*k32});
    % RK4 update for x and y
    X(i+1)=X(i)+(h/6)*(k11+2*k21+2*k31+k41);
    Y(i+1)=Y(i)+(h/6)*(k12+2*k22+2*k32+k42);
    %exacta=subs(F,T(i+1));
    %error=abs(exacta-Y(i+1));
    fprintf('%.15f\t ||  %.9f\t ||  %.9f\t ||  %.9f\t ||  %.9f\t ||  %.9f\t ||  %.9f\t ||  %.9f\t ||  %.9f\t || %.15f\t || %.15f\t \n', T(i+1),double(k11),double(k12),double(k21),double(k22),double(k31),double(k32),double(k41),double(k42),double(X(i+1)),Y(i+1));
end
%fprintf('El valor aproximado y(%.15f)=%.15f \n',b,double(Y(n+1)));