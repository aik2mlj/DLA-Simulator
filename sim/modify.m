function df = modify(N, step, prob)
%% ����ģ�飨��ʼ����
d0=1; %���ӵ�ֱ����ճ����ࣨ��С��뾶Ϊ0.5��
nmin=0.4*N; %����������������
L=100;  %�����������С��L*L*L)
st=0; %�˶�����
Tuanchu_s=1;%�����Ŵ������������ı仯����
xyz=[unifrnd(0,100,N,3),(1:N)']; %���������ά���꣨���ȷֲ���
flag=(1:1:N)'; %���ɳ�ʼ�Ŵر��
num=ones(size(flag,1),1);
%���ĳ�ʼλ��
x0=mean(xyz(:,1));
y0=mean(xyz(:,2));
z0=mean(xyz(:,3));
r=sqrt((xyz(:,1)-x0).^2+(xyz(:,2)-y0).^2+(xyz(:,3)-z0).^2); %���ӵ����ĵľ���
Rm=max(r); %����ת�뾶��ʼ��
Ra=mean(r); %ƽ����ת�뾶
%��ת����ά��
xx=log(sort(r));
p1=polyfit(xx,log((1:N))',1);
D=p1(1);
X_rmn=30; %�������������ĸ��Ŵ��شӴ�С���ж��ٸ�����99��
%% ����ģ��
bh=unique(xyz(:,4));%�Ŵ���Ŀ��ʼ��
d=[];  %����ת�뾶��¼
gamma1=zeros(length(flag),1);
theta1=zeros(length(flag),1);
Bh=[]; %��¼�Ŵ���Ŀ����
xunzhaoRmn_R=[];
xunzhaoRan_R=[];
xuzhaoD_D=[];
Sr_avg_S=[];
xuzhaoD2_D=[];
Tuanchu_s_tongji=[];
xx1=[];
yy1=[];
Rmn=[]; %����ת�뾶����
Rnum_lizi=[]; %���Ŵ�����������
Ran=[];
D=[];
xxx1=[];
yyy1=[];
tongji_lizishumu=[];
while(length(bh)>=nmin)
    %num(i)=length(flag(flag==bh(i)));
    %�����˶�
    Rmn=[]; %����ת�뾶����
    Rnum_lizi=[]; %���Ŵ�����������
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
            x0=mean(tempxyz(:,1)); %���ļ���
            y0=mean(tempxyz(:,2)); %���ļ���
            z0=mean(tempxyz(:,3)); %���ļ���
            r=sqrt((tempxyz(:,1)-x0).^2+(tempxyz(:,2)-y0).^2+(tempxyz(:,3)-z0).^2); %���ӵ����ĵľ���
            Rm=max(r); %����ת�뾶��ʼ��
            Rmn=[Rmn;Rm];%����ת�뾶����
            Ra=mean(r); %ƽ����ת�뾶
            Ran=[Ran;Ra]; %ƽ����ת�뾶����
            num_lizi=size(tempxyz,1); %��������ʼ��
            Rnum_lizi=[Rnum_lizi;num_lizi]; %%���Ŵ�����������
            %��ʱ�̵Ļ�ת����ά������
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
    Bh=[Bh;size(bh,1)];%��¼�Ŵ���Ŀ����
    %��һ����ģ��
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
    %ƽ����ת����ά��
    tempD=[tongji_lizishumu D];
    xunzhaoD = sortrows(tempD,1);
    xuzhaoD1=mean(xunzhaoD(end-X_rmn+1:end,2));
    df = xuzhaoD1;
    xuzhaoD_D=[xuzhaoD_D;xuzhaoD1];
    
    st=st+1 %������1
end
end
%% ��ͼģ��
%%%%%��ת����ά��������ʱ��ı仯%%%%%%%%%%%%%%%��
% figure
% hold on
% cccccc=size(find(xuzhaoD_D>=1000 | xuzhaoD_D==0),1);
% plot(1:st-cccccc,xuzhaoD_D(cccccc+1:end,:));
% grid on
% xlabel('����ʱ��');
% ylabel('ƽ����ת����ά��');
% title('��ת����ά��������ʱ��ı仯');
% hold off