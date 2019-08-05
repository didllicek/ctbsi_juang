clear all;
clc;
%close all;
%hold off;
global inputs;
%read input data and put them to the structure
inputs_processing;

%data specifically used in the Juang system identification example 1
p=5; %number of different multiple-pulse inputs
delta_t=1; %s - time period
force=1; % force of the pulse
points=20; % number of time points for each record
alpha=5; %parameter to create a Hankel matrix in specific size
beta=6; %parameter to create a Hankel matrix in specific size
%Hankel matrix size is (alpha*m x beta*r)

%numerical integration of the system - generating of the outputs data used 
%for identification of the system and creating Hankel Matrix
Y1=zeros(points,2);
figure(1)
hold on
Y1(:,1)=generate_output_data(1,[0;1]);
Y1(:,2)=generate_output_data(1,[1;0]);
Y=[]
for i=2:20
    Y=[Y,Y1(i,:)]
end
%[Result]=ERA(Y,1,12,5,2,2,3,0)
%[sys1,sys2,sys3]=h2ss(Y1,2,1e-5)
legend('first','second')
hold off


% size(Y1')
% [a,b,c,d,totbnd,hsv] = imp2ss(Y1')
% ac=log(a)

% 
%generate Hankel matrix
 H1=generateHankelMatrix(Y1,alpha,beta)
 H2=generateHankelMatrix(Y1(2:end,:),alpha,beta)
 
 H1up=generateHankelMatrix(Y1(2:end,:),alpha,beta);
 
 %svd decomposition
 [U,S,V] = svd(H1);
 %U 
 
 n=rank(H1);
 U1=U(1:(alpha*inputs.m),1:n)
 S1=S(1:n,1:n);
 V1=V(1:(beta*inputs.r),1:n);
 S1^-.5*U1(:,1:n)'*H2*V(:,1:n)*S1^-.5
% 
% C=U1(1:inputs.m,:);
% S1V1T=S1*transpose(V1);
% b1_dashed=S1V1T(1,1:inputs.r);
% U1_up=U1(1:(alpha-1)*inputs.m,:);
% U1_down=U1((inputs.m+1):alpha*inputs.m,:);
% 
% 
% Ac=log(U1_up\U1_down)/delta_t
% eig(Ac)
% Q_vawe=[C;C*Ac]
% Q=[inputs.C;inputs.C*inputs.Ac]
% phi=Q\Q_vawe
% phi*Ac/phi
% C/phi
% 
% 
% 
% %transformation back to original coordinate system
% Ac_bt=[-1.0629,3.9782;0.0148,-1.9371];
% eig(Ac_bt);
% Bc_bt=[-0.0929,-0.9824;-0.2482,0.2314];
% C_bt=[-0.9355,0.3497];
% Nc1_bt=[1.7752,3.2911;-0.4182,-0.7752];
% Nc2_bt=[0.1678,0.3111;0.4489,0.8322];
% Ncs_bt=[Nc1_bt,Nc2_bt];
% 
% [Ac_t,Bc_t,C_t,Ncs_t]=transformation(Ac_bt,Bc_bt,C_bt,Ncs_bt);
% eig(Ac_t);