clear all;
clc;
global inputs;
%read input data and put them to the structure
inputs_processing;

%-----data used in the Juang system identification example 1-----
p=5; %number of different multiple-pulse inputs
forces=[1,1];
delta_t=0.3;
points=10; % number of time points for each record
alpha=5; %parameter to create a Hankel matrix in specific size
beta=6; %parameter to create a Hankel matrix in specific size
%Hankel matrix size is (alpha*m x beta*r)

%-----generation of outputs and Hankel matrices---------
% output must be generated only for fictive examples!!!!!

figure(1)
hold on
Hps=[];
for j=1:p
    Yp=zeros(points,inputs.r);
   
    %numerical integration of the system - generating of the outputs data
    for i=1:inputs.r
        u=zeros(inputs.r,1);
        u(i,1)=forces(i);
        Yp(:,i)=generate_output_data(points,delta_t,j*delta_t,u);
    end   
    %legend('first','second')
%--------generate Hankel matrix H1-------------
    if (j==1)
        Hp=generateHankelMatrix(Yp(:,:),alpha,beta);
    else
        Hp=[];
        for k=j+1:(alpha+j)
            Hp=[Hp;Yp(k,:)];            
        end
    end
    Hp
    Hps{j}=Hp;
    %Hps=[Hps,(Hp)];
end

hold off
%------------------------------first part----------------------------------

H1=Hps{1};
%svd decomposition
[U,S,V] = svd(H1);
 
 
n=rank(H1);
U1=U(1:(alpha*inputs.m),1:n);
S1=S(1:n,1:n);
V1=V(1:(beta*inputs.r),1:n);

C=U1(1:inputs.m,:);
S1V1T=S1*V1';
B1_dashed=S1V1T(:,1:inputs.r)
U1_up=U1(1:(alpha-1)*inputs.m,:);
U1_down=U1((inputs.m+1):alpha*inputs.m,:);
% 
% 
A=U1_up\U1_down;
Ac=logm(A)/delta_t;
% -----check if eigenvalues of inputs.Ac and Ac are the same-----
Ac_eig=eig(Ac);
original_Ac=eig(inputs.Ac);
 
 
%-----generation of transformation of matrix-----% 
Q_vawe=[C;C*Ac];
Q=[inputs.C;inputs.C*inputs.Ac];
phi=Q\Q_vawe;
 
 
 
 
%-----transformation of matrix Ac,C-----%
%-----normally in function!!!!!-----%
Ac_transformed=phi*Ac/phi
C_transformed=C/phi
 
 
%-----------------------------second part----------------------------------
 
Bps{1}=B1_dashed;

for j=2:p
    Bps{j}=U1\Hps{j}
end



for i=1:inputs.r
    Bp=Bps{1};
    Cm=[Bp(:,i)];


    for k=2:p
        Bpk=Bps{k};
        Bpk_1=Bps{k-1};
        Cm=[Cm,Bpk(:,i)-Bpk_1(:,i)];
    end
    Cms{i}=Cm;
end

for i=1:inputs.r
    Cm=Cms{i};
    Cm_left=Cm(:,1:(end-inputs.r));
    Cm_right=Cm(:,(inputs.r+1):(end));
    b_dashed=Cm(:,1:inputs.r);
    Nc=((logm(Cm_right/Cm_left)/(2*delta_t))-Ac)/forces(i); % preco 2?????
    Ncs{i}=Nc;
    phi*Nc/phi
    
end
















 
 
 
 
 
 

 

 
 
 
 
 
 
 
 
 
 
 
 
 
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