$ mkdir build; cd build
$ cmake .. # Add any additional args here as necessary for your platform
$ make
$ ctest -V # Optional, make sure everything is working correctly
$ sudo make install

Material最后安装到目录
/usr/local/lib/x86_64-linux-gnu/qml/

把安装目录下的
```
manu@debian-manu:~/tools/qt5/5.5/gcc_64/qml$ cp -a /usr/local/lib/x86_64-linux-gnu/qml/QtQuick/Controls/Styles/Material/ QtQuick/Controls/Styles/
Base/    Desktop/ Flat/    qmldir   
manu@debian-manu:~/tools/qt5/5.5/gcc_64/qml$ cp -a /usr/local/lib/x86_64-linux-gnu/qml/QtQuick/Controls/Styles/Material/ QtQuick/Controls/Styles/

```

拷贝到qt5的实际安装目录下