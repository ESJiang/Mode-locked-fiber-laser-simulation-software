
%%%%% Optical fiber travel Propagation transmit %%%%%
function dawdz = fiber11(~,aw,~,w,Beta2,Gamma) 
at = fft(aw);
m=(0.5*1i)*Beta2.*(w.^2).*aw;
dawdz=m(end)+ifft(+1i*Gamma*(abs(at)).^2.*at);
end