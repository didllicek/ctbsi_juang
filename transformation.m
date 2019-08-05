function [Ac,Bc,C,Ncs]=transformation(Ac_bt,Bc_bt,C_bt,Ncs_bt)
    global inputs
    n=length(C_bt);
    phi=[-0.8715,-3.6998;-0.9355,0.3497];
    %inv_phi=inv(phi);
    Ac=(phi*Ac_bt)/phi;  %/phi instead of *inv_phi
    Bc=phi*Bc_bt;
    C=C_bt/phi;
    i=1;
    Ncs=zeros(n,inputs.r*n);
    while(i<=n)
        %((i-1)*n+1)
        %i*n;
        %Nci=(phi*Ncs_bt(1:n,((i-1)*n+1):i*n))/phi;
        %Ncs=[Ncs,Nci];
        Ncs(1:n,((i-1)*n+1):i*n)=(phi*Ncs_bt(1:n,((i-1)*n+1):i*n))/phi;
        i=i+1;
    end
end