function y = generate_output_data(points,delta_t,period,u1,sys_spec)

% doplnit ci sa data generuju alebo je input a output zadany =>
% netreba riesit sustavu ODE!
x0=zeros(sys_spec.n,1);
t=0:delta_t:(points*delta_t-delta_t);
y=zeros(sys_spec.m,points);
options=odeset('RelTol',1e-2,'MaxStep',0.1);
%options=odeset('AbsTol',1e-15,'MaxStep',0.005);
for i=1:(numel(t)-1) 
    if(t(i)<period)
        u =u1;
    else
        u=zeros(size(u1));
    end
    t_span=[t(i),t(i+1)];
    [tp,xp]=ode45(@(tp,xp)dynamic_system(tp,xp,u,sys_spec),t_span,x0,options);
    y(1:sys_spec.m,i)=(sys_spec.C)*x0+sys_spec.D*u;   %tu by mal byt uvazovany aj vplyv D!!!!!
    xp;
    x0=xp(end,:)';
    
    %tp
    %xp
end
y(1:sys_spec.m,points)=(sys_spec.C)*x0+sys_spec.D*u; %tu by mal byt uvazovany aj vplyv D!!!!!
length(t);
length(y);
plot(t,y);
y=reshape(y,[sys_spec.m*points,1]);


%[t,x]=ode45(@dynamic_system,0:20,x0);
end