function trs = filter1(omega,Dw_f,Loss_f)                                         % transmission or transmittance
omega = omega';
omega =fftshift(omega);
m = 1;                                   % gausssian parameter
trs = sqrt(1-Loss_f)*exp(-0.5*(4^m)*log(2).*(omega./Dw_f).^(2*m));  
end 