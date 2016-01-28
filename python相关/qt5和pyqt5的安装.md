## 安装qt5和pyqt5

1、安装Python3.4

2、安装Qt5
 
3、到qt网站下载linux64的离线安装文件
 >qt-opensource-linux-x64-5.5.1.run
sudo chmod a+x qt-opensource-linux-x64-5.5.1.run
sudo ./qt-opensource-linux-x64-5.5.1.run

4、安装后设置环境变量
>export QTDIR=/home/manu/tools/qt5/5.5/gcc_64/
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${QTDIR}/lib
export PATH=${QTDIR}/bin:${PATH}

5、安装SIP
> http://www.riverbankcomputing.com/software/sip/download
 tar -zxvf sip-4.16.3.tar.gz   
cd sip-4.16.3  
python3 configure.py  
sudo make  
sudo make install  

6、安装PyQt5
>http://www.riverbankcomputing.com/software/pyqt/download5
tar -zxvf PyQt-gpl-5.3.2.tar.gz  
cd PyQt-gpl-5.3.2  
python3 configure.py  
sudo make
sudo make install

7、-lGL
出现的问题：

:cannot find -lgl

安装：

apt-get install libgl1-mesa-dev

8、Gtk-Message: Failed to load module "canberra-gtk-module"
 apt-get install libcanberra-gtk3-dev
