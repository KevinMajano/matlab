syms y t

disp('Método de Runge-Kutta de orden 4')

f=input('Ingrese la ecuación diferencial dy/dt:');
intervalo=input('Ingrese el intervalo [a,b]:');
y0=input('Ingrese el valor inicial:');
F=input('Ingrese la solución exacta de la ecuación diferencial:');
h=input('Ingrese le valor de h:');

a=intervalo(1);
b=intervalo(2);

T=[a:h:b];

n=length(T)-1;

Y(1)=y0;

fprintf(' ti\t\t\t\t || k1\t\t\t || k2\t\t\t || k3\t\t\t || k4\t\t\t || Yi\t\t\t\t || F(ti)\t\t\t || error\n');

fprintf('%.15f\t || %.9f\t || %.9f\t || %.9f\t || %.9f\t || %.15f\t || %.15f\t || %e\n', ...
    T(1),0,0,0,0,double(Y(1)),double(Y(1)),0);

for i=1:n

    k1=subs(f,{t,y},{T(i),Y(i)});

    k2=subs(f,{t,y},{T(i)+h/2,Y(i)+(h/2)*k1});

    k3=subs(f,{t,y},{T(i)+h/2,Y(i)+(h/2)*k2});

    k4=subs(f,{t,y},{T(i)+h,Y(i)+h*k3});

    Y(i+1)=Y(i)+(h/6)*(k1+2*k2+2*k3+k4);

    exacta=subs(F,T(i+1));

    error=abs(exacta-Y(i+1));

    fprintf('%.15f\t || %.9f\t || %.9f\t || %.9f\t || %.9f\t || %.15f\t || %.15f\t || %e\n', ...
        T(i+1),double(k1),double(k2),double(k3),double(k4),double(Y(i+1)),double(exacta),double(error));

end

fprintf('El valor aproximado Y(%.15f)=%.15f \n',b,double(Y(n+1)));

fprintf('El valor exacto F(%.15f)=%.15f \n',b,double(exacta));

fprintf('Error: %e \n',double(error));