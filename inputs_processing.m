function [sys_spec,id_meth_params] = inputs_processing(dir)
    %inputs given from the user - specification of the system
    %not general!!!! should be read from user
    sys_spec=struct;  
    
    fid=fopen(strcat(dir,'/sys_spec.txt'),'r');    
    nrm=fscanf(fid,['%d']);  
    sys_spec.n=nrm(1);  %n number of state variables -order of the system - in the experiments assuming we do not know the order of the system
    sys_spec.r=nrm(2); %r number of inputs
    sys_spec.m=nrm(3); %m number of outputs    
    sys_spec.Ac=dlmread(strcat(dir,'/Ac.txt')); % state-variable matrix
    sys_spec.Bc=dlmread(strcat(dir,'/Bc.txt')); % input matrix
    sys_spec.C=dlmread(strcat(dir,'/C.txt')); % output matrix
    sys_spec.D=dlmread(strcat(dir,'/D.txt'));
    sys_spec.Ncs=cell(1,sys_spec.r);
    for i=1:sys_spec.r
        sys_spec.Ncs{i}=dlmread(strcat(dir,'/Nc',int2str(i),'.txt'));    
    end
    
    fclose(fid);    
    
    fid=fopen(strcat(dir,'/id_meth_params.txt'),'r');   
    PVRead=textscan(fid,'%s %f','delimiter','=','EmptyValue',nan);
    fclose(fid);
    id_meth_params=cell2struct(num2cell(PVRead{2}),PVRead{1},1);   
    id_meth_params.forces=dlmread(strcat(dir,'/forces.txt'));
    %p - number of different multiple-pulse inputs
    %forces - force of inputs - pozor vektor dlzky r!!!!!
    %delta_t - period
    %points - number of time points for each record
    %alpha - parameter to create a Hankel matrix in specific size
    %beta - parameter to create a Hankel matrix in specific size
    %r - number of inputs
    %m - number of outputs
end
