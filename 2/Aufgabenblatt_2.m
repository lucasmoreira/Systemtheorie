clear; close all; 
%% Aufgabe (1)
%Parameter
a = [50.0 , 0.0];
b = [0.1 , 0.6];
c = [8.0 , 0.3];

%Differentialgleichungen
z_punkt = @(t,z) [(a(1) - b(1)*z(1) - c(1)*z(2)) * z(1);
                (a(2) - b(2)*z(2) + c(2)*z(1)) * z(2)];

%Anfangswerte
z0 = [20.0 ; 5.0];

%Zeitspanne
t_span = [0 2];

%Numerische Lösung
[t,z] = ode45(z_punkt,t_span,z0);

%Darstellung
plot(t,z);


%Titel und Achenbeschriftung
title('Räuber-Beute-Modell');
xlabel('time');
ylabel('population');

%Legende
legend('show','Beute Population','Räuber Population');

%% Aufgabe (2)
%Gleichgewichtspunkt Co-Existenz
z1 = (a(1)*b(2)-c(1)*a(2))/c(1)*c(2)+(b(1)*b(2));
z2 = (a(2)*b(1)+a(1)*c(2))/(c(1)*c(2)+b(1)*b(2));

%Linien
line([0 2], [z1 z1],'Color','c','LineStyle','--');
line([0 2], [z2 z2],'Color','m','LineStyle','--');

%% Aufgabe (3)
%Jacobi-Matrix im Gleichgewichtspunkt -> partielle Ableitungen
J = [a(1)-2*b(1)*z1-c(1)*z2 ,   -c(1)*z1 ; 
    c(2)*z2 ,                   a(2)-2*b(2)*z2+c(2)*z1];

%Eigenwerte der Jacobi-Matrix
e = eig(J);

%Periode der Schwingung
%Imaginärteile der Eigenwerte beschreiben die Schwingung um den
%Gleichgewichtspunkt

w = imag(e(1));
T = (2*pi)/w;

%% Aufgabe 4
%Phasendiagramm


for i=0:21
    z2_0 = [20.0,0.0+i*0.25]; %für 21 Lösungen in 20 Schritten (5.0 / 20 = 0.25)
    [t,z] = ode45(z_punkt, t_span, z2_0);
%Plotten des Phasendiagramms (Pos. und Winkelgeschw. in einer Ebene)
    figure (2)
    plot(z(:,1),z(:,2));
    hold on
end

%Titel und Achsenbeschriftung
title('Phasendiagramm');
axis([0 200 0 16]);
xlabel('Beute');
ylabel('Räuber');