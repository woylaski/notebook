## 使用ppa安装sublime-text-2

安装sublime-text-2 需要添加WebUpd8team的PPA。关于这个ppa team，链接是https://launchpad.net/~webupd8team/+archive/ubuntu/sublime-text-2）

>sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo apt-get update
sudo apt-get install sublime-text

==注意，当你在进行更新的时候会发现，Debian系统会出现一个错误：
W: Failed to fetch http://ppa.launchpad.net/webupd8team/sublime-text-2/ubuntu/dists/stretch/main/binary-amd64/Packages  404  Not Found
为什么呢？是因为这个安装程序在写入list文件的时候估计默认为当前的系统是Ubuntu系统。所以使用的是“/ubuntu/dists/stretch/”，这肯定无法找到对应的安装包！==

下面是webupd8team-sublime-text-2-stretch.list(在/etc/apt/sources.list.d中)的内容：
>$ cat /etc/apt/sources.list.d/webupd8team-sublime-text-2-jessie.list 
deb http://ppa.launchpad.net/webupd8team/sublime-text-2/ubuntu jessie main
deb-src http://ppa.launchpad.net/webupd8team/sublime-text-2/ubuntu jessie main

其中，==“jessie”是我Debian系统的名字！==

==解决的方法很简单，将“jessie”改成“vivid”,这个是Ubuntu的名字Ubuntu 15.04 LTS (Vivid Vervet)==

这样sublime2就装好了

==~~安装sublime3~~==
>~~apt-get install sublime-text-installer~~ 