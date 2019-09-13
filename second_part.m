function [Ncs,Bc] = second_part(B1_dashed,Hps,Ac,U1,n,id_meth_params)
    Bps{1}=B1_dashed;

    for j=2:id_meth_params.p
        Bps{j}=U1\Hps{j};
    end
    
    %generation of controlability like matrices
    for i=1:id_meth_params.r
        Bp=Bps{1};
        Cm=[Bp(:,i)];
        for k=2:id_meth_params.p
            Bpk=Bps{k};
            Bpk_1=Bps{k-1};
            Cm=[Cm,Bpk(:,i)-Bpk_1(:,i)];
        end
        Cms{i}=Cm;
    end

    Bc=[];

    for i=1:id_meth_params.r
        Cm=Cms{i};
        Cm_left=Cm(:,1:(end-id_meth_params.r));
        Cm_right=Cm(:,(id_meth_params.r+1):(end));
        %b_dashed=Cm(:,1:sys_spec.r);
        %Nc=((logm(Cm_right/Cm_left)/(2*delta_t))-Ac)/forces(i); % preco 2?????
        Nc=((logm(Cm_right/Cm_left)/2/id_meth_params.delta_t)-Ac)/id_meth_params.forces(i);
        Ncs{i}=Nc;
    
        bi_dashed=B1_dashed(:,i);
        coef=eye(n)*(id_meth_params.delta_t);
        for j=2:20               % how to set end of cycle, why 20?
            coef=coef+((Ac+id_meth_params.forces(i)*Nc)^(j-1)*(id_meth_params.delta_t)^j)/factorial(j);
        end
        bci=(coef\bi_dashed)/id_meth_params.forces(i);
        Bc=[Bc,bci];
    
        %coef=eye(n)*(delta_t);
        %for j=2:20
        %    coef=coef+((Ac+forces(i)*Nc)^(j-1)*(delta_t)^j)/factorial(j);
        %end
        %bci=(coef\b_dashed)/forces(i);
        %Bc=[Bc,bci]; 
    
    end


end