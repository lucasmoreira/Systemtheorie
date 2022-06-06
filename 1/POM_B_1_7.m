clc; clear all;
%Aufgabe 4 + 5
z_0 = [0 50];
R = 4700; 
C = 220E-9; 
B = 3; 
t_span = [0 1];
%Create a function handle to an anonymous function: https://www.mathworks.com/help/matlab/matlab_prog/matlab-operators-and-special-characters.html


tiledlayout(2,1)

nexttile
B = 2.8;
R = 4700;
C=200E-9;
z1_handle = @(t,u) [((B-1)*u(1)-u(2))/(R*C);((2*B-1)*u(1)-2*u(2))/(R*C)];
[t,u] = ode45(z1_handle,t_span,z_0);
h1 = plot(t,u(:,1),'b', 'LineWidth',3, 'LineStyle','-')
hold on
h2 = plot(t,u(:,2),'c', 'LineWidth',3, 'LineStyle','-')
title('Plot B=2.8; R=4700 Ω; C=200 nF')
ylabel('Signalamplitude');
legend('U_1(t)','U_2(t)');


nexttile
B = 3.2
z1_handle = @(t,u) [((B-1)*u(1)-u(2))/(R*C);((2*B-1)*u(1)-2*u(2))/(R*C)];
[t,u] = ode45(z1_handle,t_span,z_0);
h1 = plot(t,u(:,1),'b', 'LineWidth',3, 'LineStyle','-')
hold on
h2 = plot(t,u(:,2),'c', 'LineWidth',3, 'LineStyle','-')
title('Plot B=3.2; R=4700 Ω; C=200 nF')
ylabel('Signalamplitude');
legend('U_1(t)','U_2(t)');
xlabel('Zeit');

