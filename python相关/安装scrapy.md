1、安装
sudo pip install -U scrapy
sudo pip3 install -U scrapy

2、安装过程中遇到的问题
python 错误汇总1---解决 Python.h：没有那个文件或目录 错误的方法
解决方法是安装python-dev，这是Python的头文件和静态库包:
sudo apt-get install python-dev 
sudo apt-get install python3-dev

python 错误汇总2：致命错误： libxml/xmlversion.h：没有那个文件或目录
apt-get install libxml2-dev
sudo ln -s /usr/include/libxml2/libxml   /usr/include/libxml

python错误汇总3：libxslt/xsltconfig.h：没有那个文件或目录
apt-get install libxslt-dev