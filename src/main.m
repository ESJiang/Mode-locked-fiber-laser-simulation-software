clear ; close all; clc;
parameters;
peak=100;
FWHM=2;
at_in=sqrt(peak/339)*sech(t/(FWHM*5));
aw = ifft(at_in);
for i=1:1:Cycles
%%%%%%%%%%%% fiber 1 %%%%%%%%%%%%
   [z1,awz]=ode45('fiber',[0 L1],aw,[],omega,t,B2_sm1,Gm_sm1,0,Es_g,Dw_g);
   aw=awz(end,1:N);
   if i==Cycles
      evaw = awz;
      evz = z1;
      moniw_01 = aw(1:length(t));
      monit_01 = fft(aw(1:length(t)));
   end
%%%%%%%%%%%% gain fiber %%%%%%%%%%%%
   [z2,awz]=ode45('fiber',[0 L_g],aw,[],omega,t,B2_g,Gm_g,G0,Es_g,Dw_g);
   aw = awz(end,1:N);
   if i==Cycles
      evaw =[evaw;awz];
      evz =[evz;z2+L1];
      moniw_02 = aw(1:length(t));
      monit_02 = fft(aw(1:length(t)));
   end
   %%%%%%%%%%%% fiber 2 %%%%%%%%%%%%
   [z3,awz]=ode45('fiber',[0 L2],aw,[],omega,t,B2_sm1,Gm_sm1,0,Es_g,Dw_g);
   aw = awz(end,1:N);
   if i==Cycles
      evaw =[evaw;awz];
      evz =[evz;z3+L1+L_g];
      moniw_03 = aw(1:length(t));
      monit_03 = fft(aw(1:length(t)));
      yw03 = abs(fftshift(moniw_03)).^2;
      yt03 = abs(monit_03).^2;
   end
%%%%%%%%%%%% saturable absorbtion %%%%%%%%%%%%%
%%%%%%%%%%%%%%%% output coupler %%%%%%%%%%%%%%%
   att = cc*fft(aw);
   output(1:N,i) = (1-cc)*fft(aw);
   at = att.*absorber(att,Md,Ps,A_ns);
   aw = ifft(at);
   if i==Cycles
      evaw =[evaw;aw];
      evz =[evz;L1+L_g+L2+0.005];
      moniw_04 = aw(1:length(t));
      monit_04 = fft(aw(1:length(t)));
      yw04 = abs(fftshift(moniw_04)).^2;
      yt04 = abs(monit_04).^2;
   end
%%%%%%%%%%%%% fiber 3 %%%%%%%%%%%%%%
   [z4,awz]=ode45('fiber',[0 L3],aw,[],omega,t,B2_sm1,Gm_sm1,0,Es_g,Dw_g);
   aw = awz(end,1:N);
   if i==Cycles
      evaw =[evaw;awz];
      evz =[evz;z4+L1+L_g+L2+0.005];
      moniw_05 = aw(1:length(t));
      monit_05 = fft(aw(1:length(t)));
      yw05 = abs(fftshift(moniw_05)).^2;
      yt05 = abs(monit_05).^2;
   end
%%%%%%%%%%%%%%%% filter %%%%%%%%%%%%%%%%%%%%
   aw = aw.*filter1(omega,Dw_f,Loss_f);
   if i==Cycles
      evaw =[evaw;aw];
      evz =[evz;L1+L_g+L2+L3+0.01];  % mark
      moniw_06 = aw(1:length(t));
      monit_06 = fft(aw(1:length(t)));
      yw06 = abs(fftshift(moniw_06)).^2;
      yt06 = abs(monit_06).^2;
   end
 %%%%%%%%%%%%%%%%% fiber 4 %%%%%%%%%%%%%%%%%
   [z5,awz]=ode45('fiber',[0 L4],aw,[],omega,t,B2_sm1,Gm_sm1,0,Es_g,Dw_g);
   aw = awz(end,1:N);
   if i==Cycles
      evaw =[evaw;awz];
      evz =[evz;z5+L1+L_g+L2+L3+0.01];
      moniw_07 = aw(1:length(t));
      monit_07 = fft(aw(1:length(t)));
   end
end
%%%%%%%%%%%%%%%%%%%% simulation %%%%%%%%%%%%%%
figure(1)
dis=1:1:Cycles;
waterfall(t,dis,(abs(output(:,dis))').^2)
set(gca,'FontSize',12,'FontName','Times New Roman','FontWeight','bold')
xlabel('Time(ps)'), ylabel('Rounds Trips'), zlabel('Intensity(W)')
figure(2)
plot(t,(abs(output(:,Cycles))').^2)
figure(3)
dis=1:1:Cycles;
pcolor(t,dis,(abs(output(:,dis))').^2)
shading interp
set(gca,'FontSize',14,'FontName','Times New Roman','FontWeight','bold')
xlabel('Time(ps)'),ylabel('Rounds Trips')
colorbar('FontSize',15)
set(gca,'tickdir','out')
m1=(abs(output(:,Cycles)))'.^2;
m2=max(m1);
m3=m2./2;
m4=find(abs(m1-m3)<10);
m5=m1(m4);
X=abs(m5-m3);
m6=find(X==min(X));
if m6<=size(m5,2)/2
m7=(512-m4(m6))*2*Dt;
else if m6>size(m5,2)/2
        m7=(m4(m6)-513)*2*Dt;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%