安装

QT5.5

ubuntu
下载离线安装包qt-opensource-linux-x64-5.5.1.run, 更改执行权限:
sudo chmod u+x qt-opensource-linux-x64-5.5.1.run运行该文件, 根据向导进行安装, 需要注意的是最好勾选source component模块, 这样安装完后, 包含qt的源代码.
样例的使用

如果选择了默认安装文件夹/opt/Qt5.5.1, 则该文件夹默认只有root有写权限, 需要将/opt/Qt5.5.1/Examples目录
修改写权限:
sudo chown -R zhangjinjie:zhangjinjie /opt/Qt5.5.1/Examples.
使用copy projects的方法行不通, 因为很多样例还依赖其它样例. copy的话只是拷贝当前样例, 根本无法运行.

troubleshooting
运行样例时, 提示cannot find -lgl时, 需要安装libgl1-mesa-dev安装包

windows
下载离线安装包qt-opensource-windows-x86-msvc2010-5.5.1.exe, 运行安装即可。

mac OS X EI Caption
使用qt-opensource-mac-x64-clang-5.5.1.dmg安装包安装即可, 4.8.7版本已经在EI Caption上不能用了.

PyQt5.5

ubuntu
从riverbank下载PyQt-gpl-5.5.1.tar.gz, 解压首先运行:
python configure.py --qmake=/opt/Qt5.5.1/5.5/gcc_64/bin/qmake
如果提示qgeolocation.h not found, 这个问题是Qt5.5安装包的问题, 我们需要手动拷贝:
cd /opt/Qt5.5.1/5.5/gcc_64/include/QtPositioning
sudo cp /opt/Qt5.5.1/5.5/Src/qtlocation/src/positioning/qgeolocation.h .
sudo cp /opt/Qt5.5.1/5.5/Src/qtlocation/src/positioning/qgeolocation_p.h 5.5.1/QtPositioning/private/
sudo cp /opt/Qt5.5.1/5.5/Src/qtlocation/include/QtPositioning/QGeoLocation .
或者 
python configure.py --disable=QtPositioning

然后执行:

make
sudo make install
注意
执行上述命令后PyQt5已经装完, 但是想运行简单的程序还需配置QT_QPA_PLATFORM_PLUGIN_PATH环境变量,否则会提示cannot find or load qt platform plugin 'xcb'
有2种方法, 第一种使用shell配置环境变量:
QT_QPA_PLATFORM_PLUGIN_PATH=/opt/Qt5.5.1/5.5/gcc_64/plugins/platforms/ ./my_qt_app
或将变量配置在.bashrc或.zshrc文件中

或者使用代码写入:

import os
os.putenv('QT_QPA_PLATFORM_PLUGIN_PATH', '/opt/Qt5.5.1/5.5/gcc_64/plugins/platforms/')
windows
先决条件：
电脑安装有visual studio 2010，并且安装有visual c++模块。
安装有python2.7， 并配置好环境变量，即在命令行下便可以执行python命令。
首先从riverbank下载sip-4.17.zip安装包，解压后，使用visual studio提供的Visual Studio Command Prompt进入windows命令行，执行以下命令：
python configure.py
nmake
nmake install

然后从riverbank下载PyQt-gpl-5.5.1.zip安装包，解压后，使用visual studio提供的Visual Studio Command Prompt进入windows命令行，执行以下命令：
python configure.py
nmake
nmake install

troubleshooting
如果执行python configure.py时，提示cl.exe ... return code '0xc0000135', 请确认你的visual studio正确安装了visual c++模块。

如果nmake过程中出现:Qt5Nfc.lib(Qt5Nfc.dll) : error LNK2005: "public: __thiscall QList<class QNdefRecord>::~QList<class QNdefRecord>(void)" (??1?$QList@VQNdefRecord@@@@QAE@XZ) already defined in sipQtNfcQList0100QNdefRecord.obj, 这个问题临时解决办法是去掉QtNfc模块, 执行配置时增加disable选项:
python configure.py --disable=QtNfc

mac
在mac安装也会提示找不到qgeolocation.h文件, 需要拷贝到的目录为$QT_INSTALL_PATH/5.5/clang_64/lib/QtPositioning.framework/Versions/Headers
