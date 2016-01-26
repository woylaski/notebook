## debian下的浏览器
----

### iceweasel
----
iceweasel 是debian8 (gnome）安装后带的浏览器,是Mozilla Firefox浏览器的Debian再发布版。
根据firefox的协议（Mozilla Public License协议）在 除了用在原生的Mozilla Firefox代码编译版本之外，没有得到Mozilla的授权，任何组织不能使用firefox名字，logo， 因为Debian里面使用的 Firefox需要做修改使得它更适合debian需求（包括定制默认的搜索引擎，首页等 这都是钱啊亲~） 因此不能用firefox这个名字和火狐的logo

### 安装原版的firefox
-----
添加APT源地址,在/etc/apt/sources.list添加下面的源地址：
>deb http://downloads.sourceforge#net/project/ubuntuzilla/mozilla/apt all main
除了使用编辑器外我们还可以通过下面的命令操作来轻松完成：

导入密钥Key
sudo apt-key adv --recv-keys--keyserver keyserver#ubuntu.com C1289A29 

更新APT源列表
sudo apt-get update

安装软件
通过下面的命令可以分别安装FireFox、SeaMonkey以及ThunderBird：
安装FireFox
> sudo apt-get install firefox-mozilla-build

安装ThunderBird 
>sudo apt-get install thunderbird-mozilla-build

安装SeaMonkey
>sudo apt-get install seamonkey-mozilla-build

注意的是，安装后的firefox是英文版的

### 安装chrome
下载chrome的debian安装包
[chrome](https://www.google.com/chrome/browser/desktop/index.html) 
选择64bit 的deb

>~~aptitude install gconf-service libgconf-2-4 libnspr4 libnss3~~ 

使用dpkg安装deb包
>dpkg -i google-chrome-stable_current_amd64.deb
>apt-get -f install

