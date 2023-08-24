function filter12(block)
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
T = 80;            % Span in time domain unit: ps
N = 2^10;          % Number of sample points
omega = (2*pi/T.*(-N/2:1:(N/2-1)))';  % Circular frequency sequence unit
Dx_f=20e-9;
Lambda0 = 1030e-9;%  unit: m
Dw_f = 2*pi*2.998e-4*Dx_f/Lambda0.^2;
Loss_f=0.01;
c=block.InputPort(1).Data.*filter1(omega,Dw_f,Loss_f);
block.OutputPort(1).Data=c(end);
