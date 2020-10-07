function xdot=splitting2(t,x)
numofrobo=17;
D=12;
h=D/2;
C=10/(7*pi*h^2);
r=15;

K=200;
gamma=7;
rho0=0.06;
% if t<10
%     rho0=0.6;
% else
%     rho0=0.2;
% end

Krepel=7;
k=1;
zi=1;

q=[]; v=[];

for i=1:4:4*numofrobo
    q=[q [x(i);x(i+1)]];
    v=[v [x(i+2);x(i+3)]];
end

qc=[t;0];

xdot=[];
for i=1:numofrobo
    qi=q(:,i);
    
    gradW=[0;0];
    GW=[0;0];
    frepel=[0;0];
%     fsph=[0;0];
%     fshape=[0;0];
    W=0;
    rho=0;
    for j=1:numofrobo
        if i~=j
            qj=q(:,j);
            qij=qi-qj;
            nqij=sqrt((qi(1,1)-qj(1,1))^2+(qi(2,1)-qj(2,1))^2);
            
            if nqij<D
                frepel=frepel+((1/nqij)*(qij/nqij));
            
             end
                k=nqij/h;
                if k>=0 && k<=1
                    W=C*(1-(3/2)*k^2+(3/4)*k^3);
                    gradW=C*(1/h^2)*(-3+(9/4)*k)*(qi-qj);
                end
                if k>1 && k<=2
                    W=C*((1/4)*(2-k)^2);
                    gradW=C*(-3/4)*(2-k)^2*(1/(k*h^2))*(qi-qj);
                end
%                 if k>2
%                     W=0;
%                     gradW=[0;0];
%                 end
            
                rho=rho+W;
                GW=GW+gradW;
           
        else
            rho=rho+0;
            GW=GW+[0;0];
        end
    end
    
    frepel=Krepel*frepel;

    P=K*rho*((rho/rho0)^gamma-1);
    fsph=-(P/rho^2)*GW;
    rho
    qic=qi-qc;
    fg=qic(1,1)^2+qic(2,1)^2-r^2;
    delf=2*qic;
    fshape=k*max(0,fg)*delf;

    u=fshape+fsph+frepel-zi*v(:,i);
    qdot=v(:,i);
    vdot=u;
    xdot=[xdot;qdot;vdot];
    
end
