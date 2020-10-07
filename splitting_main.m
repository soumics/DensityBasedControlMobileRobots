clc;
hi=5;
lo=-5;
nr=17;
x=lo+(hi-lo)*rand(1,nr);
y=lo+(hi-lo)*rand(1,nr);
plot(x,y,'o')
axis(16*[lo hi lo hi])
v=zeros(2,nr);

q0=[];
for jj=1:nr
    q0=[q0;x(jj);y(jj);v(:,jj)];
end

t0=0; tf=20;

% [t,x]=ode23(@splitting,[t0,tf],q0);
[t,x]=ode23(@splitting2,[t0,tf],q0);
[row col]=size(x);

mov(1:row) = struct('cdata', [],...
                        'colormap', []);
for cnt=1:length(t)
    p1=[];
    x1=x(cnt,:);
    for ii=1:4:(nr*4)
        p1=[p1 [x1(ii) x1(ii+1)]'];
    end
    plot(p1(1,:),p1(2,:),'o')
    axis(16*[lo hi lo hi])
    pause(.25)
%     mov(cnt) = getframe(gcf);
end
%movie2avi(mov, 'C:\Documents and Settings\Administrator\Desktop\movie.avi', 'compression', 'Indeo5');