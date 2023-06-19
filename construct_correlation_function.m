function [correlation_function] = construct_correlation_function(Lv, Lh, signal, type)
% Obs: of course it is possible to implement this function using meshgrids
% instead of for loops. However, for large dimension models, meshgrid uses
% too much RAM memory.
% Lv - Vertical correlation range
% Lh - Horizontal correlation range
% signal - It is just to define the size of the simulations (FFTMA works better if we define the filter with the same size of the white noise)
% type - Variogram/correlagram type, 1 for exponential, 2 for Gaussian and 3 for spherical


I = size(signal,1);
J= size(signal,2);
K = size(signal,3);

% Taper parameters (it avoinds artifacts when the variogram range are similar to the model size):
order = 4;
desvio = 1.0;

correlation_function = zeros(I,J,K);
for i=1:I
    for j=1:J
        for k=1:K
             
            if type==1
                value = exp( -sqrt((((i-round(I/2))^2)/Lv^2) + (((j-round(J/2))^2)/Lh^2) + (((k-round(K/2))^2)/Lh^2) ));                
            end
            if type==2
                value = exp( -((((i-round(I/2))^2)/Lv^2) + (((j-round(J/2))^2)/Lh^2) + (((k-round(K/2))^2)/Lh^2) )); 
            end
            if type==3
                r = sqrt( ((i-round(I/2))/(3*Lv))^2 + ((j-round(J/2))/(3*Lh))^2 + ((k-round(K/2))/(3*2*Lh))^2);
                if r<1
                    value = 1 - 1.5 * r + 0.5 * r^3;
                else
                    value=0;
                end
            end
            
            value_window = exp( -(abs((i-round(I/2))/(desvio*I))^order + abs((j-round(J/2))/(desvio*J))^order  + abs((k-round(K/2))/(desvio*K))^order));
            correlation_function(i,j,k) = value*value_window;
            %correlation_function(i,j,k) = value;
            
        end
    end
end
