Python科学计算环境推荐——Anaconda

python 科学计算发行包

到www.continuum.io下载最新的anaconda，双击安装，这里有一个问题，如果你已经安装了python，最好卸载掉，避免版本冲突（当然你也可以让anaconda的python不添加到系统路径，相当于两个python，不过每次运行anaconda的python命令要指定路径，很麻烦），然后在安装anaconda时勾上添加到系统路径（这样可以直接在命令行下运行python的命令）。

安装完成后代开命令行：

>pip list 
可以看到已经安装好了很多第三方的库，直接启动notebook：

>ipython notebook
是不是成功了？新建一个笔记本，运行一点命令吧：

In [1]:from IPython.display import Latex
            Latex(r"$\sqrt{x^2+y^2}$")
 
在win8下的ipython notebook安装和入门

--------------
Anaconda是一个和Canopy类似的科学计算环境，但用起来更加方便。自带的包管理器conda也很强大。
首先是下载安装。Anaconda提供了Python2.7和Python3.4两个版本，同时如果需要其他版本，还可以通过conda来创建。安装完成后可以看到，Anaconda提供了Spyder，IPython和一个命令行。下面来看一下conda。
输入 conda list 来看一下所有安装时自带的Python扩展。粗略看了一下，其中包括了常用的 Numpy , Scipy ， matplotlib 和 networkx 等，以及 beautiful-soup ， requests ， flask ， tornado 等网络相关的扩展。
奇怪的是，里边竟然没有 sklearn ，所以首先装一下它。
conda install scikit-learn
如果需要指定版本，也可以直接用 [package-name]=x.x 来指定。
conda的repo中的扩展不算太新，如果想要更新的，可能要用PyPI或者自己下载源码。而conda和pip关联的很好。使用pip安装的东西可以使用conda来管理，这点要比Canopy好。下图是我用pip安装的 nltk ， jieba 和 gensim 。