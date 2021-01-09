function df = modify(N, step, prob)
%% 输入模块（初始化）
d0=1; %粒子的直径及粘附间距（中小球半径为0.5）
nmin=0.4*N; %结束絮凝集团总数
L=100;  %设置立方体大小（L*L*L)
st=0; %运动次数
Tuanchu_s=1;%单个团簇所含粒子数的变化过程
xyz=[unifrnd(0,100,N,3),(1:N)']; %随机生成三维坐标（均匀分布）
flag=(1:1:N)'; %生成初始团簇编号
num=ones(size(flag,1),1);
%重心初始位置
x0=mean(xyz(:,1));
y0=mean(xyz(:,2));
z0=mean(xyz(:,3));
r=sqrt((xyz(:,1)-x0).^2+(xyz(:,2)-y0).^2+(xyz(:,3)-z0).^2); %粒子到中心的距离
Rm=max(r); %最大回转半径初始化
Ra=mean(r); %平均回转半径
%回转分形维数
xx=log(sort(r));
p1=polyfit(xx,log((1:N))',1);
D=p1(1);
X_rmn=30; %所含粒子数最多的个团簇重从大到小排列多少个，见99行
%% 运算模块
bh=unique(xyz(:,4));%团簇数目初始化
d=[];  %最大回转半径记录
gamma1=zeros(length(flag),1);
theta1=zeros(length(flag),1);
Bh=[]; %记录团簇数目变量
xunzhaoRmn_R=[];
xunzhaoRan_R=[];
xuzhaoD_D=[];
Sr_avg_S=[];
xuzhaoD2_D=[];
Tuanchu_s_tongji=[];
xx1=[];
yy1=[];
Rmn=[]; %最大回转半径序列
Rnum_lizi=[]; %各团簇粒子数序列
Ran=[];
D=[];
xxx1=[];
yyy1=[];
tongji_lizishumu=[];
while(length(bh)>=nmin)
    %num(i)=length(flag(flag==bh(i)));
    %布朗运动
    Rmn=[]; %最大回转半径序列
    Rnum_lizi=[]; %各团簇粒子数序列
    Ran=[];
    D=[];
    tongji_lizishumu=[];
    theta=2*pi*rand(length(flag),1);
    gamma=pi*rand(length(flag),1);
    for i=1:length(flag)
        xx1=[];
        yy1=[];
        tempxyz=xyz(flag==i,:);
        if(~isempty(tempxyz))
            x0=mean(tempxyz(:,1)); %重心计算
            y0=mean(tempxyz(:,2)); %重心计算
            z0=mean(tempxyz(:,3)); %重心计算
            r=sqrt((tempxyz(:,1)-x0).^2+(tempxyz(:,2)-y0).^2+(tempxyz(:,3)-z0).^2); %粒子到中心的距离
            Rm=max(r); %最大回转半径初始化
            Rmn=[Rmn;Rm];%最大回转半径序列
            Ra=mean(r); %平均回转半径
            Ran=[Ran;Ra]; %平均回转半径序列
            num_lizi=size(tempxyz,1); %粒子数初始化
            Rnum_lizi=[Rnum_lizi;num_lizi]; %%各团簇粒子数序列
            %该时刻的回转分型维数计算
            tongji_lizishumu=[tongji_lizishumu;size(tempxyz,1)];
            if(size(r,1)>2)
                xx=log(sort(r));
                p1=polyfit(xx,log(1:size(xx,1))',1);
                D1=p1(1);
                D=[D;D1];
            elseif(size(r,1)==2)
                xx=log(sort(r));
                yy=log(1:size(xx,1))';
                D1=(yy(2)-yy(1))/(xx(2)-xx(1));
                D=[D;D1];
            else
                D1=0;
                D=[D;D1];
            end
        end
        theta1(i)=theta(flag(i));
        gamma1(i)=gamma(flag(i));
    end
    xxx1=xx1;
    yyy1=yy1;
    bh=unique(xyz(:,4));
    Bh=[Bh;size(bh,1)];%记录团簇数目变量
    %单一粒子模拟
    Tuanchu_s_num=size(find(xyz(:,4)==Tuanchu_s),1);
    Tuanchu_s_tongji=[Tuanchu_s_tongji;Tuanchu_s_num];
    xyz(:,1)=xyz(:,1)+step.*sin(gamma1).*cos(theta1);
    xyz(:,2)=xyz(:,2)+step.*sin(gamma1).*sin(theta1);
    xyz(:,3)=xyz(:,3)+step.*cos(gamma1);
    for i=1:size(xyz,1)-1
        for j=i+1:size(xyz,1)
            if xyz(j,4)~=xyz(i,4)
                d=sqrt((xyz(i,1)-xyz(j,1)).^2+(xyz(i,2)-xyz(j,2)).^2+(xyz(i,3)-xyz(j,3)).^2);
                if d<=d0 && rand(1)<prob
                    xyz(j,4)=xyz(i,4);
                end
            end
        end
    end
    flag=xyz(:,4);
    %平均回转分形维度
    tempD=[tongji_lizishumu D];
    xunzhaoD = sortrows(tempD,1);
    xuzhaoD1=mean(xunzhaoD(end-X_rmn+1:end,2));
    df = xuzhaoD1;
    xuzhaoD_D=[xuzhaoD_D;xuzhaoD1];
    
    st=st+1 %步长加1
end
end
%% 制图模块
%%%%%回转分形维数随絮凝时间的变化%%%%%%%%%%%%%%%？
% figure
% hold on
% cccccc=size(find(xuzhaoD_D>=1000 | xuzhaoD_D==0),1);
% plot(1:st-cccccc,xuzhaoD_D(cccccc+1:end,:));
% grid on
% xlabel('絮凝时间');
% ylabel('平均回转分形维数');
% title('回转分形维数随絮凝时间的变化');
% hold off