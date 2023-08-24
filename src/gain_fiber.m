function gain_fiber(block)
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
run('parameters');
[~,awz]=ode45('fiber12',[0 L_g],block.InputPort(1).Data,[],w,B2_g,Gm_g,Dw_g);
block.OutputPort(1).Data = awz(end);