data = readtable('hotdays_processed.csv');
years = data.Year;
hot_days = data.Hot_Days;

oscillation_model = @(b, x) b(1) * sin(b(2) * x + b(3)) .* exp(b(4) * x) + b(5);

b0 = [50, 0.2, 0, 0.01, mean(hot_days)];

fit_func = @(b) sum((oscillation_model(b, years) - hot_days).^2);
b_est = fminsearch(fit_func, b0);

disp('parameters:');
disp(b_est);

fitted_values = oscillation_model(b_est, years);

figure;
plot(years, hot_days, 'bo', 'markerfacecolor', 'b'); hold on;
plot(years, fitted_values, 'r-', 'linewidth', 2);
xlabel('year');
ylabel('num hot days');
title('oscillatory fit with diverging trend');
legend('data', 'best fit', 'location', 'NW');
grid on;

% equation form:  b_1 * sin(b_2 * x + b_3) * e^{b_4 * x} + b_5
% coefficients: 1.7266   0.2749   0.0047   0.0019   131.1604
