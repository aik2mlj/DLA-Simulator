clc
clear
%% t
% df_t=diaSim(5000,2,1);
% figure
% hold on
% plot((1:size(df_t,1))',df_t);
% grid on
% xlabel('T');
% ylabel('df');
% title('df-时间关系图');
% hold off
%% n
n=(500:500:50000)';
df_n=zeros(size(n,1));
for i=1:length(n)
    df1=diaSim(n(i),2,1);
    df_n(i)=df1(size(df1,1));
end
figure
hold on
plot(n,df_n);
grid on
xlabel('n');
ylabel('df');
title('df-数密度关系图');
hold off
%% step
step=(1:0.1:3)';
df_st=zeros(size(step,1));
for i=1:length(step)
    df1=diaSim(5000,step(i),1);
    df_st(i)=df1(size(df1,1));
end
figure
hold on
plot(step,df_st);
grid on
xlabel('step');
ylabel('df');
title('df-步长关系图');
hold off
%%%% pr
prob=(0.2:0.1:1)';
df_pr=zeros(size(prob,1));
for i=1:length(prob)
    df1=diaSim(5000,2,prob(i));
    df_pr(i)=df1(size(df1,1));
end
figure
hold on
plot(step,df_st);
grid on
xlabel('prob(%)');
ylabel('df');
title('df-粘合概率关系图');
hold off