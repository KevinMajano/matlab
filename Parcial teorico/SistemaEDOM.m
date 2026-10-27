% RK4 for a higher-order ODE written as a system of 3 first-order ODEs
% Change of variables: u1 = y, u2 = y', u3 = y''
%   du1 = u2
%   du2 = u3
%   du3 = y''' solved from the original equation, written with t, u1, u2, u3
syms u1 u2 u3 t
disp('EDO de orden superior (RK4)')
f1=input('Ingrese du1:');
f2=input('Ingrese du2:');
f3=input('Ingrese du3:');
intervalo=input('Ingrese el intervalo [a,b]:');
u10=input('Ingrese el valor inicial u1 = y(a):');
u20=input('Ingrese el valor inicial u2 = y''(a):');
u30=input('Ingrese el valor inicial u3 = y''''(a):');
h=input('Ingrese le valor de h:');
a=intervalo(1);
b=intervalo(2);
n=round((b-a)/h);   % Number of steps, safe against rounding
T=a+(0:n)*h;        % Nodes from a to b
U1(1)=u10;
U2(1)=u20;
U3(1)=u30;

for i=1:n
    % k1: slopes at the start of the step (all variables)
    k11=subs(f1,{t,u1,u2,u3},{T(i),U1(i),U2(i),U3(i)});
    k12=subs(f2,{t,u1,u2,u3},{T(i),U1(i),U2(i),U3(i)});
    k13=subs(f3,{t,u1,u2,u3},{T(i),U1(i),U2(i),U3(i)});
    % k2: slopes at the midpoint using k1 (all variables)
    k21=subs(f1,{t,u1,u2,u3},{T(i)+h/2,U1(i)+(h/2)*k11,U2(i)+(h/2)*k12,U3(i)+(h/2)*k13});
    k22=subs(f2,{t,u1,u2,u3},{T(i)+h/2,U1(i)+(h/2)*k11,U2(i)+(h/2)*k12,U3(i)+(h/2)*k13});
    k23=subs(f3,{t,u1,u2,u3},{T(i)+h/2,U1(i)+(h/2)*k11,U2(i)+(h/2)*k12,U3(i)+(h/2)*k13});
    % k3: slopes at the midpoint using k2 (all variables)
    k31=subs(f1,{t,u1,u2,u3},{T(i)+h/2,U1(i)+(h/2)*k21,U2(i)+(h/2)*k22,U3(i)+(h/2)*k23});
    k32=subs(f2,{t,u1,u2,u3},{T(i)+h/2,U1(i)+(h/2)*k21,U2(i)+(h/2)*k22,U3(i)+(h/2)*k23});
    k33=subs(f3,{t,u1,u2,u3},{T(i)+h/2,U1(i)+(h/2)*k21,U2(i)+(h/2)*k22,U3(i)+(h/2)*k23});
    % k4: slopes at the end of the step using k3 (all variables)
    k41=subs(f1,{t,u1,u2,u3},{T(i)+h,U1(i)+h*k31,U2(i)+h*k32,U3(i)+h*k33});
    k42=subs(f2,{t,u1,u2,u3},{T(i)+h,U1(i)+h*k31,U2(i)+h*k32,U3(i)+h*k33});
    k43=subs(f3,{t,u1,u2,u3},{T(i)+h,U1(i)+h*k31,U2(i)+h*k32,U3(i)+h*k33});
    % RK4 update for each variable
    U1(i+1)=double(U1(i)+(h/6)*(k11+2*k21+2*k31+k41));
    U2(i+1)=double(U2(i)+(h/6)*(k12+2*k22+2*k32+k42));
    U3(i+1)=double(U3(i)+(h/6)*(k13+2*k23+2*k33+k43));
    % Print one line per variable: its four k values and its new value
    fprintf('i=%d   t=%.15f\n',i,T(i+1));
    fprintf('  u1=y   : k1=%.9f  k2=%.9f  k3=%.9f  k4=%.9f  ->  %.15f\n',double(k11),double(k21),double(k31),double(k41),U1(i+1));
    fprintf('  u2=y''  : k1=%.9f  k2=%.9f  k3=%.9f  k4=%.9f  ->  %.15f\n',double(k12),double(k22),double(k32),double(k42),U2(i+1));
    fprintf('  u3=y'''' : k1=%.9f  k2=%.9f  k3=%.9f  k4=%.9f  ->  %.15f\n',double(k13),double(k23),double(k33),double(k43),U3(i+1));
    fprintf('--------------------------------------------------------------------------------\n');
end
fprintf('El valor aproximado y(%.15f)=%.15f \n',b,U1(n+1));