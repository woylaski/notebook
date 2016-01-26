### 安装pip和pip3

>apt-get install python-pip
>apt-get install python3-pip

>root@debian-manu:/home/manu# pip -V
pip 1.5.6 from /usr/lib/python2.7/dist-packages (python 2.7)
root@debian-manu:/home/manu# pip3 -V
pip 1.5.6 from /usr/lib/python3/dist-packages (python 3.4)

>root@debian-manu:/home/manu# which pip
/usr/bin/pip
root@debian-manu:/home/manu# which pip3
/usr/bin/pip3

### 同时安装pip和pip3怎么用

python2.7的用pip安装
python3.4的用pip3安装

###更新pip命令：
pip install --upgrade pip
安装后的在/usr/local/bin/下
包在
>manu@debian-manu:~$ pip -V
pip 8.0.2 from /usr/local/lib/python2.7/dist-packages (python 2.7)
manu@debian-manu:~$ pip3 -V
pip 8.0.2 from /usr/local/lib/python3.4/dist-packages (python 3.4)


删掉原来老的pip
> rm -rf /usr/bin/pip*

### pip3的使用
- 安装
 pip3 install dpkt

- 更新
 pip3 install --upgrade dpkt

- 删除
 pip3 uninstall dpkt


####下面来看一下pip的使用：
安装特定版本的package，通过使用==, >=, <=, >, <来指定一个版本号。
pip install 'Markdown<2.0'
pip install 'Markdown>2.0,<2.0.3'

升级包到当前最新的版本，可以使用-U 或者 --upgrade
pip install -U Markdown
卸载包
pip uninstall Markdown

查询包
pip search "multiprocessing"

列出安装的packages
$ pip freeze
>manu@debian-manu:~$ pip3 freeze
beautifulsoup4==4.3.2
Brlapi==0.6.2
chardet==2.3.0
colorama==0.3.2
dpkt==1.8.6.2
html5lib==0.999
louis==2.5.3
lxml==3.4.0
Mako==1.0.0
Markdown==2.5.1
MarkupSafe==0.23
Pygments==2.0.1
pygobject==3.14.0
python-apt==0.9.3.12
python-debian==0.1.27
pyxdg==0.25
PyYAML==3.11
remarkable==1.62
requests==2.4.3
six==1.8.0
unattended-upgrades==0.1
urllib3==1.9.1
wheel==0.24.0
