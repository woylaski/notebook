## 安装有道 openyoudao

openyoudao是开源的，代码托管在Github上面

添加ppa源(新建一个独立源文件)
>gedit /etc/apt/sources.list.d/openyoudao.list
deb http://ppa.launchpad.net/justzx2011/openyoudao-v0.4/ubuntu trusty main 
deb-src http://ppa.launchpad.net/justzx2011/openyoudao-v0.4/ubuntu trusty main

使用apt-get 安装
>sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys  14C9B91C3F9493B9
sudo apt-get update 
sudo apt-get install openyoudao