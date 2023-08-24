function YDF(block)
setup(block);

function setup(block)
block.NumInputPorts=1;
block.NumOutputPorts=1;
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;
block.InputPort(1).DirectFeedthrough=true;
block.SampleTimes=[-1 0];
block.SimStateCompliance='DefaultSimState';
block.SetAccelRunOnTLC(true);
block.RegBlockMethod('Outputs',@Output);

function Output(block) 
L_g=4;
B2_g=0.018;
Gm_g=0.0031;
T = 80;            % Span in time domain unit: ps
N = 2^10;          % Number of sample points
omega = (2*pi/T.*(-N/2:1:(N/2-1)))'; 
w=fftshift(omega);
Lambda0 = 1030e-9;%  unit: m
Dx_g = 50e-9;          % m
Dw_g = 2*pi*2.998e-4*Dx_g/Lambda0^2; 
[~,awz]=ode45('fiber12',[0 L_g],block.InputPort(1).Data,[],w,B2_g,Gm_g,Dw_g);
block.OutputPort(1).Data = awz(end);