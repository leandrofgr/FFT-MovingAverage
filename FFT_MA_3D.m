function [ simulation ] = FFT_MA_3D( correlation_function, noise )
% As simples as that:
% correlation_function - Correlation/variogram model, output of the function "construct_correlation_function".
% noise - White random noise that will be filtered.

	filter = correlation_function;
    simulation = ifftn(sqrt(abs(fftn(filter,size(noise)))) .* fftn(noise,size(noise)));
    simulation = real(simulation);
    
end