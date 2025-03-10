% data
time1 = [1, 2, 3, 4, 5];
pop1 = [2.882, 2.881, 2.990, 3.194, 3.104]; 

time2 = [1, 2, 3, 4, 5]; 
pop2 = [8.8, 7.7, 11.7, 8.7, 14.8]; 

% common time grid
common_time = linspace(min([time1, time2]), max([time1, time2]), 100);

% interpolate data onto the common time grid
pop1_interp = interp1(time1, pop1, common_time, 'spline');
pop2_interp = interp1(time2, pop2, common_time, 'spline');

% combine interpolated data
data_matrix = [pop1_interp(:), pop2_interp(:)];

% mean-center the data
mean_values = mean(data_matrix); % Compute mean of each column
data_centered = data_matrix - mean_values; % Subtract mean

% covariance matrix
cov_matrix = (data_centered' * data_centered) / (size(data_centered, 1) - 1);

% compute eigenvalues and eigenvectors of C
[eig_vectors, eig_values] = eig(cov_matrix); 

% eigenvalues
[eig_values_sorted, idx] = sort(diag(eig_values), 'descend');
eig_vectors_sorted = eig_vectors(:, idx);

eigenvalue_ratio = eig_values_sorted(1) / eig_values_sorted(2);

% results
disp('Eigenvalues:');
disp(eig_values_sorted);

disp('Principal Component Coefficients:');
disp(eig_vectors_sorted);

disp('Eigenvalue Ratio:')
disp(eigenvalue_ratio)

% plot
figure;
subplot(2,1,1);
plot(time1, pop1, 'ro', 'MarkerFaceColor', 'r'); hold on;
plot(time2, pop2, 'bo', 'MarkerFaceColor', 'b');
plot(common_time, pop1_interp, 'r-', 'LineWidth', 1.5);
plot(common_time, pop2_interp, 'b-', 'LineWidth', 1.5);
legend('Pop 1 Data', 'Pop 2 Data', 'Pop 1 Interpolated', 'Pop 2 Interpolated');
xlabel('Time'); ylabel('Population');
title('Original and Interpolated Data');

subplot(2,1,2);
scatter(pc_scores(:,1), pc_scores(:,2), 'k', 'filled');
xlabel('PC1'); ylabel('PC2');
title('Principal Component Analysis of Population Data');
grid on;
