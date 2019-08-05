% read data from the user 

% TODO....

%inputs given from the user
global inputs;
inputs=struct;
inputs.n=2; %number of state variables - in the experiments assuming we do not know the order of the system
inputs.r=2; %number of inputs
inputs.m=1; %number of outputs
inputs.Ac=[-1,0;1,-2]; % state-variable matrix
inputs.Bc=[1,0;0,1]; % input matrix
inputs.C=[0,1]; % output matrix
inputs.Nc1=[0,0;1,1]; % u1*x matrix
inputs.Nc2=[1,1;0,0]; % u2*x matrix