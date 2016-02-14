
Qt5.5已经发布了，前两天PyQt也很快推出了一个5.5的对应版本。试验了一下（花了个周末啊！），真是越来越好用了。Qt5.5在Ubuntu15.04上有一些重要的改进，在虚拟机里运行的窗口覆盖问题也终于没有了。因为要装好几个软件，挺花功夫的。这里给出个脚本，可以快速安装。

首先安装Qt5.5。
#在线安装用这个.
wget http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run
chmod +x qt-unified-linux-x64-online.run
./qt-unified-linux-x64-online.run
#离线安装用这个.
wget http://download.qt.io/official_releases/qt/5.5/5.5.0/qt-opensource-linux-x64-5.5.0-2.run
chmod +x qt-opensource-linux-x64-5.5.0-2.run
./qt-opensource-linux-x64-5.5.0-2.run

然后，设置一下Qt的路径。
#Add Qt Path to /etc/profile.
sudo gedit /etc/profile
#add line:
export PATH=$PATH:/home/userXXX/Qt/Qt5.5/gcc_64/bin
一般新装的系统需要安装OpenGL的支持。
sudo apt-get install libgl1-mesa-dev
注意：目前的Qt5.5版本的开源版本中将“Open Source”标示为了“Builder Qt”，导致PyQt中判断错误，抛出许可不兼容的错误。将PyQt目录中的configure.py添加如下行（搜索Common checks，2590行处），重新编译即可。
# Common checks.
#change by openthings@163.com.
print("License:")
print(introspecting)
print(target_config.qt_licensee)
print(ltype)
target_config.qt_licensee = ‘Open Source‘
#end change.

下面是完整的脚本：
#!/bin/sh
#Author:openthings@163.com.
#Install Qt5.5.
#Get online installer.
#wget http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run
#chmod +x qt-unified-linux-x64-online.run
#Get offline installer.
#wget http://download.qt.io/official_releases/qt/5.5/5.5.0/qt-opensource-linux-x64-5.5.0-2.run
#chmod +x qt-opensource-linux-x64-5.5.0-2.run
#Add Qt Path to /etc/profile.
#sudo gedit /etc/profile
#add line: export PATH=$PATH:/home/userXXX/Qt/Qt5.5/gcc_64/bin
echo "Build PyQt.==============================================="
if [ ! -d "pyqt" ]; then
mkdir pyqt
fi
cd pyqt
echo "Add OpenGL lib...========================================="
sudo apt-get install libgl1-mesa-dev
echo "Install SIP-4.16.9========================================"
if [ ! -f "sip-4.16.9.tar.gz" ]; then
wget http://www.riverbankcomputing.com/static/Downloads/sip4/sip-4.16.9.tar.gz
fi
if [ ! -d "sip-4.16.9" ]; then
tar -vxf sip-4.16.9.tar.gz
fi
cd sip-4.16.9
python3 configure.py
make
sudo make install
cd ..
echo "Install PyQt-5.5=========================================="
if [ ! -f "PyQt-gpl-5.5.tar.gz" ]; then
wget http://www.riverbankcomputing.com/static/Downloads/PyQt5/PyQt-gpl-5.5.tar.gz
fi
if [ ! -d "PyQt-gpl-5.5" ]; then
tar -vxf PyQt-gpl-5.5.tar.gz
fi
cd PyQt-gpl-5.5
cp ../../configure.py ./configure.py
python3 configure.py
make
sudo make install
cd ..
echo =========================================
echo QT5 and PyQT 5.5/SIP 4.16.9 Installed.
echo =========================================

Qt＋Python已经开始成为很多系统级软件的标配了，Qt5.5的发布改掉了以前的很多小毛病，基本上可以放心地使用了。