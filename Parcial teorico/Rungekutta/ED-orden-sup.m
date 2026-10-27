% Third-order ODE solved as a system of 3 first-order ODEs with RK4 (course script)
% Change of variables: u1 = y, u2 = y', u3 = y''
%   du1 = u2
%   du2 = u3
%   du3 = y''' solved from the original equation, written with t, u1, u2, u3
syms t u1 u2 u3
disp('ECUACIONES DIFERENCIALES DE ORDEN SUPERIOR')
fu1=input('Ingrese du1:');
fu2=input('Ingrese du2:');
fu3=input('Ingrese du3:');
intervalo=input('Ingrese el intervalo [a,b]:');
u10=input('Ingrese el valor inicial u1:');
u20=input('Ingrese el valor inicial u2:');
u30=input('Ingrese el valor inicial u3:');
h=input('Ingrese le valor de h:');
a=intervalo(1);
b=intervalo(2);
% Changed from T=[a:h:b]: this form cannot lose the last point to rounding
n=round((b-a)/h);
T=a+(0:n)*h;
U1=zeros(1,n+1);
U2=zeros(1,n+1);
U3=zeros(1,n+1);
U1(1)=u10;
U2(1)=u20;
U3(1)=u30;
for i=1:n
    fprintf('PARA i=%2.0f\n',i)
    fprintf('t=%.15f\n',T(i+1))
    % k1: slopes at the start of the step
    k11=double(subs(fu1,{t,u1,u2,u3},{T(i),U1(i),U2(i),U3(i)}));
    k12=double(subs(fu2,{t,u1,u2,u3},{T(i),U1(i),U2(i),U3(i)}));
    k13=double(subs(fu3,{t,u1,u2,u3},{T(i),U1(i),U2(i),U3(i)}));
    % k2: slopes at the midpoint using k1
    k21=double(subs(fu1,{t,u1,u2,u3},{T(i)+h/2,U1(i)+(h/2)*k11,U2(i)+(h/2)*k12,U3(i)+(h/2)*k13}));
    k22=double(subs(fu2,{t,u1,u2,u3},{T(i)+h/2,U1(i)+(h/2)*k11,U2(i)+(h/2)*k12,U3(i)+(h/2)*k13}));
    k23=double(subs(fu3,{t,u1,u2,u3},{T(i)+h/2,U1(i)+(h/2)*k11,U2(i)+(h/2)*k12,U3(i)+(h/2)*k13}));
    % k3: slopes at the midpoint using k2
    k31=double(subs(fu1,{t,u1,u2,u3},{T(i)+h/2,U1(i)+(h/2)*k21,U2(i)+(h/2)*k22,U3(i)+(h/2)*k23}));
    k32=double(subs(fu2,{t,u1,u2,u3},{T(i)+h/2,U1(i)+(h/2)*k21,U2(i)+(h/2)*k22,U3(i)+(h/2)*k23}));
    k33=double(subs(fu3,{t,u1,u2,u3},{T(i)+h/2,U1(i)+(h/2)*k21,U2(i)+(h/2)*k22,U3(i)+(h/2)*k23}));
    % k4: slopes at the end of the step using k3
    k41=double(subs(fu1,{t,u1,u2,u3},{T(i)+h,U1(i)+h*k31,U2(i)+h*k32,U3(i)+h*k33}));
    k42=double(subs(fu2,{t,u1,u2,u3},{T(i)+h,U1(i)+h*k31,U2(i)+h*k32,U3(i)+h*k33}));
    k43=double(subs(fu3,{t,u1,u2,u3},{T(i)+h,U1(i)+h*k31,U2(i)+h*k32,U3(i)+h*k33}));
    % RK4 update for each variable
    U1(i+1)=double(U1(i)+(h/6)*(k11+2*k21+2*k31+k41));
    U2(i+1)=double(U2(i)+(h/6)*(k12+2*k22+2*k32+k42));
    U3(i+1)=double(U3(i)+(h/6)*(k13+2*k23+2*k33+k43));
    fprintf('u1(t)=y(t)=%0.15f\n',U1(i+1))
    fprintf('u2(t)=Dy(t)=%0.15f\n',U2(i+1))
    fprintf('u3(t)=D2y(t)=%0.15f\n',U3(i+1))
    fprintf('--------------------------------\n')
end