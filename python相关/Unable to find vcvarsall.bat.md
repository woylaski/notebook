在网上搜了好多，说需要安装 vs2008，但是我安装了vs2008专业版，依然还是这个问题“Unable to find vcvarsall.bat ”
再然后，我又照网上说的下载安装MinGW了，并且修改了环境变量等一系列东西，最后错误又变成了“TypeError: unorderable types: NoneType() >= str()”
请问这个到底该怎么解决？

著作权归作者所有。
商业转载请联系作者获得授权，非商业转载请注明出处。
作者：徐潇
链接：http://www.zhihu.com/question/26857761/answer/34382260
来源：知乎

C:/Python31/Lib/distutils目录下，发现“unable to find vcvarsall.bat”这句话在msvc9compiler.py中问题出在构建python的版本和你计算机上安装的版本可能不一样。具体修改代码如下：msvc9compiler.py中修改MSVCCompiler函数：vc_env = query_vcvarsall(VERSION, plat_spec)为：如果安装的是VS2014，则VERSION为13.0；如果安装的是VS2013，则VERSION为12.0；如果安装的是VS2012，则VERSION为11.0；如果安装的是VS2010，则VERSION为10.0；如果安装的是VS2008，则VERSION为9.0。像我的安装的是VS2013，则vc_env = query_vcvarsall(12.0, plat_spec)在我的电脑上，我查过它查找的VERSION为10.0，也就是VS2010，所以要人工干预下，而且修改此处对整个程序没有影响，除非你换了VS版本至于题主为啥2008版的没用，因为Python3.4默认2010版，你也可以直接下2010的，这就不用改了

>vc_env = query_vcvarsall(VERSION, plat_spec)
vc_env = query_vcvarsall(12.0, plat_spec)


系统环境是win7(64bit)+python3.4(64bit)+numpy1.82+vs2012

1.如果用sourceforge上编译好的32bit的exe安装，会提示‘python version ** required,which was not found in the registry’.

原因是安装的python是64bit的吧(不确定)，但是注册表里确实没有，

2.自己手动编译numpy安装，在numpy目录下cmd里‘python setup.py build'会提示'unable to find vcvarsall.bat',

原因是python默认使用的是vs2008版本，打开‘<python安装目录>\lib\distutils\msvc9compiler.py’发现默认的搜索目录下

的确没有vcvarsall这个文件。如果把vcvarsall移动到这个目录，就会出现第三个问题。一般的解决方法是使用mingw。

最好的解决方法直接在msvc9compiler.py文件中找到下面这一行：

vc_env = query_vcvarsall(VERSION, plat_spec)
修改为：

vc_env = query_vcvarsall(11.0, plat_spec)
我的是vs2012 对应的version就是11.0

具体为什么这样改，参考http://blog.csdn.net/ren911/article/details/6448696

但这样更改后会出现第4个问题。

3.C:\Python33\lib\distutils\msvc9compiler.py", line 287, in query_vcvarsall

raise ValueError(str(list(result.keys())))

ValueError: ['lib', 'include', 'path']

这个问题没找到有效的解决方法 可以通过2种改version的方法避开这个问题

4.RuntimeError: Broken toolchain: cannot link a simple C program

在msvc9compiler.py中，把minfo的赋值语句更改为minfo=None，即可

5.因为安装的是64bit-python，看网上大家安装nltk各种问题，官网也不建议使用64bit python，

所以查了不少的安装教程，但是出乎意料build和install没出现任何问题。