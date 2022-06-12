clear; close all; clc;

%% TEIL 1: Lösen der Systemgleichungen

%Parameter
k21 = 2.268; ku2 = 2.680; %Wärmeleitwerte in [W/K*cm]
c1 = 0.921; c2 = 0.465; %spezifische Wärmekapazitäten in [J/g*K]
p1 = 2.7; p2 = 7.87; %spezifische Dichten in [g/cm^3]
d1 = 3; d2 = 5; %Dicken in [cm]
F = 314.0; %Übergangsflächen in [cm²]

%Eingangsgröße - konstanter Wärmestrom
u = @(t) 200000;

%Matrizen
A = [-(k21/(c1*p1*d1)) k21/(c1*p1*d1);
    k21/(c2*p2*d2) -((ku2+k21)/(c2*p2*d2)) ]; %Systemmatrix
B = [1/(c1*p1*d1*F);0]; %Inputmatrix
C = [0 1]; %Outputmatrix

%Zustandsraummodell/DGL-System
z_dot = @(t,z) A*z + B*u(t);

%Zeitspanne und Anfangswerte
t_span = [0 80]; z0 = [0; 0];
%Numerische Lösung
[t,z] = ode45(z_dot,t_span,z0);

tiledlayout(3,1)
nexttile
%Darstellung
figure(1)
plot(t,z, 'LineWidth',3, 'LineStyle','-');
%Titel
title('Teil 1','FontSize',20);
%Legende
legend('show','Werkstück','Werkstückhalter');
xlabel('Zeit [s]');
ylabel('Temperatur [°C]');

Endtemperatur = max(z(:,2)); %maxtemp von Werkstückhalter

%Endtemperatur: 237.5015 °C (siehe Diagramm)

%% TEIL 2: Gram’sche Steuerbarkeitsmatrix
%Endzeit
te = 15;
t_span = [0 te];
%Endzustand
ze = [300; 100];

%K21 == 0, damit kann jeder Endzustand angesteuert werden.
%Slide 102
Co = ctrb(A,B);
Co(2,1);

%Gram'sche Steuerbarkeitsmatrix
%https://de.mathworks.com/help/control/ref/ss.gram.html
%https://de.mathworks.com/help/control/ref/ss.html
%Slide 98
sys = ss(A,B,C,0);
opt = gramOptions('FreqIntervals',t_span);
Ws = gram(sys,'c',opt);

%Eingangssignal
% Slide 97
u2 = @(t2) -B'*(expm(A'*(te-t2)))*(Ws^(-1)*(expm(A*te)*z0-ze ));

%Zustandsraummodell/DGL-System
z_dot2 = @(t2,z2) A*z2 + B*u2(t2);
%Numerische Lösung
[t2,z2] = ode45(z_dot2,t_span,z0);

nexttile
%Darstellung
plot(t2,z2, 'LineWidth',3, 'LineStyle','-');
%Titel & Legende
title('Teil 2','FontSize',20);
legend('show','Temperatur T1(t)-Tu','Temperatur T2(t)-Tu');
xlabel('Zeit [s]');
ylabel('Temperatur [°C]');

nexttile 
%Darstellung
fplot(u2, [0, 15],'Linewidth',2); warning('off');
%Legende
legend('show','Heizleistung');
xlabel('Zeit [s]');
ylabel('Leistung [W]');

%Energie fur den Aufwarmvorgang
integral( u2, 0, 15, 'ArrayValued', true); % = 1.6441e+06 

%Leistung in t = 15 ; Werkstucktemperatur zu halten
u2(15); % = 2.2573e+05 W



