function dxdt=dynamic_system(t,x,u,sys_spec)

%ODE
u;
x;
sys_spec.Ac*x;
sys_spec.Bc*u;
dxdt=sys_spec.Ac*x+sys_spec.Bc*u;
for i=1:sys_spec.r
    dxdt=dxdt+sys_spec.Ncs{i}*x*u(i);
end
end