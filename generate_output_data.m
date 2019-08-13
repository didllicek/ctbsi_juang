function y = generate_output_data(points,delta_t,period,u1)

global inputs
x0=[0;0];
t=0:delta_t:(points*delta_t-delta_t);
y=zeros(1,points);
for i=1:(numel(t)-1) 
    if(t(i)<period)
        u =u1;
    else
        u=zeros(size(u1));
    end
    t_span=[t(i),t(i+1)];
    [tp,xp]=ode45(@(tp,xp)dynamic_system(tp,xp,u),t_span,x0);
    y(1,i)=(inputs.C)*x0;
    xp;
    x0=xp(end,:)';
    
    %tp
    %xp
end
y(1,points)=(inputs.C)*x0;
length(t)
length(y)
plot(t,y)



%[t,x]=ode45(@dynamic_system,0:20,x0);




end