function SMF1(block)
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
L1=0.5;
B2_sm1=0.018;
Gm_sm1=0.0031;
T = 80;            % Span in time domain unit: ps
N = 2^10;          % Number of sample points
omega = (2*pi/T.*(-N/2:1:(N/2-1)))';
w=fftshift(omega);
[~,awz]=ode45('fiber11',[0 L1],block.InputPort(1).Data,[],w,B2_sm1,Gm_sm1);
block.OutputPort(1).Data=awz(end);