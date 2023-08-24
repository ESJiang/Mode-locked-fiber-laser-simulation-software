
%%%%% Optical fiber travel Propagation transmit %%%%%
function dawdz = fiber12(~,aw,~,w,Beta2,Gamma,Dw_g) 
at = fft(aw);
g = 0.62;   % constant
c=(0.5*1i)*Beta2.*(w.^2).*aw;
d=-(0.5*g./(Dw_g)^2).*(w.^2).*aw;
dawdz=c(end)+d(end)+g.*aw+ifft(+1i*Gamma*(abs(at)).^2.*at);
end