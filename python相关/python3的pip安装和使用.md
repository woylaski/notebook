## python3 pip安装使用

### pip安装
首先安装easy_install
下载地址: https://pypi.python.org/pypi/ez_setup
解压,安装.python ez_setup.py

安装好easy_install 之后 再安装pip
下载地址: https://pypi.python.org/pypi/pip
解压,安装.python setup.py install

### pip3升级
python3 -m pip install --upgrade pip

###使用pip 安装包
pip3 install XXX

pip3 remove XXX 


#####从源代码安装python3和pip3的方式
从原代码安装比较好控制，版本也是最新的
To install Python 3.4.3 from source on Debian:
>$ apt-get update 
$ sudo apt-get install libssl-dev openssl
$ cd opt
$ wget https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tgz
$ tar xzf Python-3.4.3.tgz
$ cd Python-3.4.3
$ ./configure --prefix=/usr
$ make
$ sudo make install

装好python3后，pip3也装好了，但是版本可能不是最新的
可以升级pip3

也可以在源码安装最新的pip3
pip is already installed if you're using Python 2 >=2.7.9 or Python 3 >=3.4 downloaded from python.org, but you'll need to upgrade pip.

Additionally, pip will already be installed if you're working in a Virtual Envionment created by virtualenv or pyvenv.

Installing with get-pip.py
To install pip, securely download get-pip.py（https://bootstrap.pypa.io/get-pip.py）

Then run the following:
>python3 get-pip.py

Upgrading pip On Linux or OS X:
>pip install -U pip

On Windows [5]:
>python3 -m pip install -U pip