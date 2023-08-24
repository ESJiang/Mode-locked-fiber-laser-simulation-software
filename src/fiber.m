
%%%%% Optical fiber travel Propagation transmit %%%%%

function fib = fiber(~,aw,~,omega,t,Beta2,Gamma,G0,Es_g,Dw_g) 
w = fftshift(omega); 
at = fft(aw);
g = G0./(1+trapz(t,abs(at).^2)/Es_g);   % constant
fib=(0.5*1i)*Beta2.*(w.^2).*aw-(0.5*g./(Dw_g)^2).*(w.^2).*aw+g.*aw+...
ifft(+1i*Gamma*(abs(at)).^2.*at);
end