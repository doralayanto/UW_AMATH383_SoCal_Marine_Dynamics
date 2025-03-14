% Clear workspace and figures
clear; clc; close all;

% 1) Define parameters
%a = 0.000000001;
%b = 0.00001;

%d_ = 0.0000000009;   
%e = 0.0000001;
%f = 8000;

%g = 0.095;
%h = 100;

a = 0.07;
b = 0.00004;

d_ = 0.025;   
e = 0.0001;
f = 0.000001;

g = 0.097;
h = 0.000001;

% parameters of oscillatory functions
alpha = 50;    
beta  = 0.2;    
phi   = 0;    
mu    = 0.1;    
delta = 139;    
c = 0.0007;

% Define the time domain
t_domain = linspace(0, 35, 1000);

% Set initial conditions: [U0, R0, S0]
init_conditions = [3; 1300; 3];

% X(1) = U, X(2) = R, X(3) = S
ode_RHS = @(t, X) [
    a * X(1) - b * X(1) * X(2) + c * (alpha * sin(beta*(t+phi)) .* exp(mu*t) + delta) * X(1);
    d_ * X(2) * (alpha * sin(beta*(t+phi)) .* exp(mu*t) + delta) + e * X(1) * X(2) - (f/(alpha * sin(beta*(t+phi)) .* exp(mu*t) + delta)) * X(3) * X(2);
    g * X(3) + h * (alpha * sin(beta*(t+phi)) .* exp(mu*t) + delta) * X(3) * X(2)
];

% Solve the system:
[t, sol] = ode45(ode_RHS, t_domain, init_conditions);

% Solutions
U_sol = sol(:,1);
R_sol = sol(:,2);
S_sol = sol(:,3);

% 6) Plot the trajectory in 3D phase space (U, R, S)
figure;
plot3(U_sol, R_sol, S_sol, 'LineWidth', 2);
grid on;
xlabel('U');
ylabel('R');
zlabel('S');
title('Phase Space Trajectory: (U, R, S)');