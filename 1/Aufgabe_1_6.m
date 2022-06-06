clear; close all;

R=4700;
C=200E-9;
B=3; 

%Anfangswerte
z_0=[0; 50];


%Werte für Matrix A
A=[(B-1)/(R*C), -1/(R*C); (2*B-1)/(R*C), -2/(R*C)];


T=linspace(0,0.02,2001);
Y=[]; 

for t=T
    Y=[Y,expm(A*t)*z_0];

end

plot(T,Y);