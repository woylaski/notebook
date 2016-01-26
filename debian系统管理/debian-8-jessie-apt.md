## debian 8(jessie)配置apt源
------


### apt配置文件位置 
 > /etc/apt/sources.list

### apt 配置文件格式
>deb http://site.example.com/debian distribution component1 component2 component3

>deb-src http://site.example.com/debian distribution component1 component2 component3

==deb/deb-src==表示包的类型, deb表示包是二进制的，已经提前编译好了，可以正常使用. deb-src表示源码包，里面有源码以及diff修改信息等. 

==distribution==表示发行版本或别名如(wheezy/jessie)或版本级别如（oldstable/stable/testing/unstable

==component== 有三种分别是 main/contrib/non-free
==如果想使用contrib、non-free的包要加上contrib、non-free

### 源的几个例子
- CDROM
 > deb cdrom:[Debian GNU/Linux 8.2.0 _Jessie_ - Official amd64 CD Binary-1 20150906-11:13]/ jessie main

- 国内163的源
> deb http://mirrors.163.com/debian/ jessie main contrib non-free
deb-src http://mirrors.163.com/debian/ jessie main contrib non-free

- debian 官方的源
> deb http://security.debian.org/ jessie/updates main contrib non-free
deb-src http://security.debian.org/ jessie/updates main contrib non-free

- 更新的源
>  # jessie-updates, previously known as 'volatile'
deb http://mirrors.163.com/debian/ jessie-updates main contrib non-free
deb-src http://mirrors.163.com/debian/ jessie-updates main contrib non-free

### 使用apt-get 安装包
更新包信息 apt-get update
安装包 apt-get install -y XXX

有时候因为包的以来问题安装失败，可以使用下面的命令来自动安装依赖的包
apt-get -f install

### apt密钥导入
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com XXXXX

### Debian "There is no public key available for the following key IDs"问题解决

>apt-get install debian-keyring debian-archive-keyring
apt-key update