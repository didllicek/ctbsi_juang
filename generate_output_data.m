function y = generate_output_data(p,u1)

global inputs

%initial values of state variables
    period=p;

    x0=[0;0];
    t=0:19;
    y=zeros(1,20);
    for i=1:(numel(t)-1)  
        if(t(i)<period)
            u =u1;
        else
            u=[0;0];
        end
    t_span=[t(i),t(i+1)];
    [tp,xp]=ode45(@(tp,xp)dynamic_system(tp,xp,u),t_span,x0);
     y(1,i)=(inputs.C)*x0;
    xp;
    x0=xp(end,:)';
    
    %tp
    %xp
    end
    y(1,20)=(inputs.C)*x0;
    y;

    length(t);
    length(y);
    plot(t,y)



%[t,x]=ode45(@dynamic_system,0:20,x0);




end