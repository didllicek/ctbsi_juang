function c=test(dir,criterion)
    [Ac,Bc,C,D,Ncs,sys_spec]=bilinear_system_identification_juang(dir);
    Ac_diff_norm=norm(Ac-sys_spec.Ac,'fro');
    Bc_diff_norm=norm(Bc-sys_spec.Bc,'fro');
    C_diff_norm=norm(C-sys_spec.C,'fro');
    D_diff_norm=norm(D-sys_spec.D,'fro');    
    c=Ac_diff_norm+Bc_diff_norm+C_diff_norm+D_diff_norm;
    for i=1:sys_spec.r
        c=c+norm(Ncs{i}-sys_spec.Ncs{i},'fro');
    end   
    
    if(c<criterion)
        disp(strcat('Test-', dir ,' passed!'))
    else
        disp(strcat('Test-', dir ,' did NOT pass!'))
    end

end