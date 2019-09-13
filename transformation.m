function [Ac_at,Bc_at,C_at,Ncs_at]=transformation(Ac_bt,Bc_bt,C_bt,Ncs_bt,n,sys_spec)
    
    %generate transformation matrix
    Q_vawe=[C_bt];
    Q=[sys_spec.C];
    for i=2:n
        Q_vawe=[Q_vawe;C_bt*Ac_bt^(n-1)];
        Q=[Q;sys_spec.C*sys_spec.Ac^(n-1)];
    end
    phi=Q\Q_vawe;
    
    %transformation of identified system
    Ac_at=(phi*Ac_bt)/phi; 
    Bc_at=phi*Bc_bt;
    C_at=C_bt/phi;
    Ncs_at=cell(1,sys_spec.r);
    for i=1:sys_spec.r
        Nci=Ncs_bt{i};
        Ncs_at{i}=(phi*Nci)/phi;        
        %Ncs(1:n,((i-1)*n+1):i*n)=(phi*Ncs_bt(1:n,((i-1)*n+1):i*n))/phi;
        %i=i+1;
    end
    
end