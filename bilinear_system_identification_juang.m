function [Ac_trans,Bc_trans,C_trans,D,Ncs_trans,sys_spec]=bilinear_system_identification_juang(dir)
%read input data and put them to the structure
    [sys_spec,id_meth_params]=inputs_processing(dir);
    
    %generation of outputs and Hankel matrices
    %output must be generated only for fictive examples!!!!!
    [Hps,D] = markov_params_hankel_matrices_generation(sys_spec,id_meth_params);
    
    %first part
    H1=Hps{1};
    [Ac,C,n,B1_dashed,U1,failed] = first_part(H1,id_meth_params);
    if(failed)
        disp('identification failed!')
        return
    end
    
    %second part 
    [Ncs,Bc] = second_part(B1_dashed,Hps,Ac,U1,n,id_meth_params);
    %generation of transformation matrix and transformation
    % only if output is generated!
    [Ac_trans,Bc_trans,C_trans,Ncs_trans]=transformation(Ac,Bc,C,Ncs,n,sys_spec);
    Ac_trans;
    C_trans;
end































 
 
 
 
 
 

 

 
 
 
 
 
 
 
 
 
 
 
 


