%%%%% Density function plot %%%%%%%%%%%%%%%%%%%%%

D=20;
h=D/2;
C=10/(7*pi*h^2);
GW=[];
K=[];
for k=0:.01:3
    if k>=0 && k<=1
        gradW=C*(-3*k+((9/4)*k^2));
        GW=[GW -gradW];
    end
    if k>1 && k<=2
        gradW=C*(-3/4)*((2-k)^2);
        GW=[GW -gradW];
    end
    if k>2
        gradW=0;
        GW=[GW -gradW];
    end
    K=[K k];
end
plot(K,GW)
xlabel('K');
ylabel('GW');