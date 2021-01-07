# DLCA

## 两种不同的模型

- **DLCA**：最基本的模型，一旦碰撞就一定停止运动
- **RLCA**：每次碰撞有概率停止运动

## 计算fractal dimension方法

单个粒子的质量设为1，因此，聚集体的质量等于n，即粒子数

计算一个矩阵：

<img src="https://pubs.rsc.org/image/article/2019/cp/c9cp00549h/c9cp00549h-t6_hi-res.gif" alt="https://pubs.rsc.org/image/article/2019/cp/c9cp00549h/c9cp00549h-t6_hi-res.gif" style="zoom: 33%;" />

算出$G$的三个特征根，求得**回转半径** (Radius of gyration)

<img src="https://pubs.rsc.org/image/article/2019/cp/c9cp00549h/c9cp00549h-t5_hi-res.gif" alt="https://pubs.rsc.org/image/article/2019/cp/c9cp00549h/c9cp00549h-t5_hi-res.gif" style="zoom:33%;" />

则粒子数$n$与$R_g$满足关系：

<img src="https://pubs.rsc.org/image/article/2019/cp/c9cp00549h/c9cp00549h-t7_hi-res.gif" alt="https://pubs.rsc.org/image/article/2019/cp/c9cp00549h/c9cp00549h-t7_hi-res.gif" style="zoom:33%;" />

拟合出来的$d_f$即为**回转分形维数**，拟合方法：
$$
log(n) = d_flog(R_g)+log(k)
$$
画出$log(n)$~$log(R_g)$线，求其斜率即为$d_f$.

拟合中，n取5~600

### matlab

求特征值：

```matlab
A = [1 2 3;4 5 6;7 8 9];
Z = eig(A) // 这样子
```



## 要得出什么（可增删）

### DLCA下，$f_d$随时间的变化

如题

### DLCA下，初始粒子体积密度与最终$f_d$的关系

如题，就是取几个不同的初始密度

### DLCA下，温度与最终$f_d$的关系

温度决定了布朗运动的剧烈程度（步长），但是我们这里有点难用真实的温度，只能得出温度和$f_d$的变化趋势

（理论上，温度与$f_d$是无关的）

### RLCA的概率对最终$f_d$的影响

其他参数相同的条件下，取不同的碰撞是否黏在一起的概率，看$f_d$的不同

