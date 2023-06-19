


%% Variogram types

% Model size:
I = 100;
J = 100;

noise = randn(I,J);

[correlation_function_exp] = construct_correlation_function(10, 10, noise, 1);
[ simulation_exp ] = FFT_MA_3D( correlation_function_exp, noise );

[correlation_function_gau] = construct_correlation_function(10, 10, noise, 2);
[ simulation_gau ] = FFT_MA_3D( correlation_function_gau, noise );

[correlation_function_sph] = construct_correlation_function(10, 10, noise, 3);
[ simulation_sph ] = FFT_MA_3D( correlation_function_sph, noise );

figure
subplot(131)
imagesc(simulation_exp)
subplot(132)
imagesc(simulation_gau)
subplot(133)
imagesc(simulation_sph)

%% Local variable mean and std

% load data defining the mean and std:
% (for conditioned simulation, this data is replaced by kriring mean and std)
load('ElevationData.mat')

I = size(mean_model,1);
J = size(mean_model,2);

noise = randn(I,J);
[correlation_function_sph] = construct_correlation_function(10, 10, noise, 3);
[ simulation_sph ] = FFT_MA_3D( correlation_function_sph, noise );


elevation_simulation = mean_model + simulation_sph.*std_model;

figure
imagesc(elevation_simulation)
