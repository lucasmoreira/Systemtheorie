clear; clc;

ct_group = [1.2801 23.99 0.52];
cn_group = [0.857 33.822 0.347];
cv_group = [0.1946 94.129 0.0646];

groups = [ct_group ; cn_group ; cv_group]';
z0 = [0,0];

for teil = 1:2 %Teil 1 oder 2
    figure
    state = 0; %trocken nass vereist. 
    if teil == 1; tiledlayout(3,3); else; tiledlayout(1,3); end
for i = groups % t;n;v
    state = state + 1;
    c1 = i(1); c2 = i(2); c3 = i(3);
    if teil ==1
        t_span = [0,0.2];
        for j = 1:3 % M(t) = 10000; 11000;12000;
            z_dot = calculator(c1,c2,c3,j,teil);
            [t,vw] = ode45(z_dot,t_span, z0);
            nexttile; Darstellung (t,vw,teil,j,state);
        end
    else
        z_dot = calculator(c1,c2,c3,j,teil);
        t_span = [0,4];
        [t,vw] = ode45(z_dot,t_span, z0);
        nexttile; Darstellung (t,vw,teil,j,state);
    end
end
end

function z_dot = calculator(c1,c2,c3,j,teil)
g = 9.81; r = 0.25; m = 1200; J = 1.5;
lambda = @(v,w) max(min((r*w-v)/(r*w),1),0);
u = @(lambda) c1*(1-exp(-c2*lambda))-c3*lambda;
if teil ==1
    M = @(t) (10000/m)+(j-1)*1000;
    z_dot = @(t,z)[g*u(lambda(z(1),z(2)));
    ((m*r)/J)*(-g*u(lambda(z(1),z(2)))+M(t))];
else 
    M = @(t) (10000/m)-sinpi(t*2)*4;
    z_dot = @(t,z)[g*u(lambda(z(1),z(2)));
    ((m*r)/J)*(-g*u(lambda(z(1),z(2)))+M(t))];
end
end

function Darstellung(t,z,teil,M_g,state)
if state == 1; state = "trocken"; elseif state == 2; state = "nass"; else; state = "vereist";end
plot(t,z, 'LineWidth',3, 'LineStyle','-');
if teil == 1
    title('Teil='+string(teil) + " M=" + string(1+(M_g-1)/10)+" kN*m " + string(state));
else
    title('Teil='+string(teil)+ string(state));
end
xlabel('time');
ylabel('Speed');
legend('show','Geschwindigkeit v(t)','Winkelgeschwindigkeit \omega(t)');
end



