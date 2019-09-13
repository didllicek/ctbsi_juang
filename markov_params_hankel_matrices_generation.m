function [Hps,D] = markov_params_hankel_matrices_generation(sys_spec,id_meth_params)

figure(1)
hold on
Hps=[];
for j=1:id_meth_params.p
    Yp=zeros(id_meth_params.points*id_meth_params.m,id_meth_params.r);
   
    %numerical integration of the system - generating of the outputs data
    %idx=1;
    for i=1:id_meth_params.r
        u=zeros(id_meth_params.r,1);
        u(i,1)=id_meth_params.forces(i);
        Yp(:,i)=generate_output_data(id_meth_params.points,id_meth_params.delta_t,j*id_meth_params.delta_t,u,sys_spec)';
        %idx=idx+id_meth_params.m;
        %idx:(idx+id_meth_params.m-1)
        %generate_output_data(id_meth_params.points,id_meth_params.delta_t,j*id_meth_params.delta_t,u,sys_spec)'
       
    end   
    
    %generate Hankel matrix H1
    if (j==1)
        %Hankel matrix H1 size is (alpha*m x beta*r) 
        Hp=generateHankelMatrix(Yp(:,:),id_meth_params.alpha,id_meth_params.beta,id_meth_params.m,id_meth_params.r);
    else
        Hp=[];
        %generate next Hankel matrices
        for k=j*id_meth_params.m+1:(id_meth_params.alpha*id_meth_params.m+j*id_meth_params.m)
            Hp=[Hp;Yp(k,:)];            
        end
    end
    Yp;
    Hp;
    Hps{j}=Hp;
end

%identification of matrix D
D=Yp(1:id_meth_params.m,:)*diag(id_meth_params.forces);
hold off
end