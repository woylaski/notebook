## Debian Multimedia镜像使用帮助

### 收录架构
i386
amd64
source

### 收录版本
stable
unstable
oldstable
testing
experimental

### 使用说明
以 Debian 8 “Jessie” 为例, 编辑/etc/apt/sources.list文件, 在文件最前面添加以下条目(操作前请做好相应备份)

>deb http://mirrors.ustc.edu.cn/debian-multimedia/ jessie main non-free
deb-src http://mirrors.ustc.edu.cn/debian-multimedia/ jessie main non-free
deb http://mirrors.ustc.edu.cn/debian-multimedia/ jessie-backports main
deb-src http://mirrors.ustc.edu.cn/debian-multimedia/ jessie-backports main


如果遇到 GPG error，你可能需要手动更新 deb-multimedia-keyring，以下摘自 debian multimedia 首页：

06/02/2015 :
Maybe I went too quickly to my new GPG key.
If apt-get don't find the new key, do that :
>wget https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2015.6.1_all.deb
sudo dpkg -i deb-multimedia-keyring_2015.6.1_all.deb
apt-get update


apt-get should be happy now.