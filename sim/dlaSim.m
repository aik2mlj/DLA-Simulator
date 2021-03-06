function df = dlaSim(N, step, prob)
    %% init
    d0=1;
    nmin=0.4*N;
    L=100;
    t=0;
    pos=[unifrnd(0,L,N,3),(1:N)'];
    num=(1:1:N)';
    sz=ones(N,1);
    %% calc
    rev=unique(pos(:,4));
    dat=[];
    
    dat_=[];
    while(length(rev)>=nmin)
        theta1=2*pi*rand(length(num),1);
        gamma1=pi*rand(length(num),1);
        theta=zeros(size(rev,1),1);
        gamma=zeros(size(rev,1),1);
        rg=zeros(length(num),1);

        rg_=zeros(length(num),1);
        for i=1:length(num)
            pos1=pos(num==i,:);
            if(~isempty(pos1))
                x0=mean(pos1(:,1));
                y0=mean(pos1(:,2));
                z0=mean(pos1(:,3));
                g=[mean((pos1(:,1)-x0).^2),mean((pos1(:,1)-x0).*(pos1(:,2)-y0)),mean((pos1(:,1)-x0).*(pos1(:,3)-z0));
                    mean((pos1(:,2)-y0).*(pos1(:,1)-x0)),mean((pos1(:,2)-y0).^2),mean((pos1(:,2)-y0).*(pos1(:,3)-z0));
                    mean((pos1(:,3)-z0).*(pos1(:,1)-x0)),mean((pos1(:,3)-z0).*(pos1(:,2)-y0)),mean((pos1(:,3)-z0).^2)];
                rg(i)=sqrt(sum(eig(g).^2));
                if (rg(i)~=0)
                    dat=[dat;rg(i),sz(i)];
                end
                
                r_=sqrt((pos1(:,1)-x0).^2+(pos1(:,2)-y0).^2+(pos1(:,3)-z0).^2);
                rg_(i) = max(r_);
                if(rg_(i)~=0)
                    dat_ = [dat_; rg_(i), sz(i)];
                end
            end
            theta(i)=theta1(num(i));
            gamma(i)=gamma1(num(i));
        end
        rev=unique(pos(:,4));
        pos(:,1)=pos(:,1)+step.*sin(gamma).*cos(theta);
        pos(:,2)=pos(:,2)+step.*sin(gamma).*sin(theta);
        pos(:,3)=pos(:,3)+step.*cos(gamma);
        for i=1:size(pos,1)-1
            for j=i+1:size(pos,1)
                if pos(j,4)~=pos(i,4)
                    d=sqrt((pos(i,1)-pos(j,1)).^2+(pos(i,2)-pos(j,2)).^2+(pos(i,3)-pos(j,3)).^2);
                    if d<=d0 && rand(1)<prob
                        pos(j,4)=pos(i,4);
                        sz(i)=sz(i)+1;
                        sz(j)=sz(j)-1;
                    end
                end
            end
        end
        num=pos(:,4);
        t=t+1;
    end
    p1=polyfit(log(dat(:,1)),log(dat(:,2)),1);
    df=p1(1);
    
    p_ = polyfit(log(dat_(:,1)),log(dat_(:,2)),1);
    df_ = p_(1);
end