% Clear workspace and figures
clear; clc; close all;

% 1) Define parameters
a = 0.07;
b = 0.00004;

d_ = 0.025;   
e = 0.0001;
f = 0.000001;

g = 0.097;
h = 0.000001;

% Define the time domain
t_domain = linspace(1985, 2020, 100);

% Set initial conditions: [U0, R0, S0]
init_conditions = [3; 1300; 3];

% X(1) = U, X(2) = R, X(3) = S
ode_RHS = @(t, X) [
    a * X(1) - b * X(1) * X(2);
    d_ * X(2) + e * X(1) * X(2) - f * X(3) * X(2);
    g * X(3) + h * X(3) * X(2)
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