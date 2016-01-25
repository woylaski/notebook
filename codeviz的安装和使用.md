## codeviz的安装和使用

1、先安装graphviz
	>apt-get install graphviz

2、下载codeviz
   下载最新的codeviz，解压
   >./configure

3、 下载编译codeviz的gcc
  >make
  
  make时会下载gcc-4.6.2,然后打补丁，编译
  但是我在运行时出现ftp 下载gcc 错误
  修改compilers/install_gcc-4.6.2.sh，使用wget去下载
  > wget ftp://ftp.gnu.org/pub/gnu/gcc/gcc-4.6.2/gcc-4.6.2.tar.gz

  然后继续运行make，因为我的系统比较新debian8的gcc-4.9.2的
  出现很多错误，后来使用debian7 gcc-4.7.2总算是编译通过了

  但是在编译过程还是遇到了一些问题
  - 安装gmp mpc等
    >apt-get install libgmp-dev
    >apt-get install libmpc-dev
  - 安装multilib
    >apt-get install gcc-multilib
  - 安装 libc-dev
    >apt-get install libc6-dev
    >ln -s /usr/lib/x86_64-linux-gnu /usr/lib64

  编译后安装
	>make install
  安装在/usr/local/gccgraph

4、使用
  Patched gcc is installed to /usr/local/gccgraph. To compile a project
  for use with CodeViz, genearlly the following will work
  >make CC=/usr/local/gccgraph/bin/gcc or g++

  To generate a full.graph file for C, use
  调用genful会在当前目录生成一个full.graph文件，该脚本可以生成项目的完整调用图信息文件，记录了所有函数在源码中的位置和它们之间的调用关系。 因此调用图信息文件可能很大很复杂,，缺省使用 cdepn 文件来创建调用图信息文件
  >genfull

  For C++, make sure you use the cppdepn method with
  >genfull -g cppdepn

  使用gengraph可以对给定一组函数生成一个小的调用图，显示函数调用关系。
  即为：$ gengraph
  >gengraph -f main

5、进一步使用codeviz
  >genfull --help
  >gengraph --help

  目前只关注下面几个选项就够了，即：
-  -f：指定顶级函数，即入口函数，如main等（当然不限定是main了）；
-  -o：指定输出的postfile文件名，不指定的话就是函数名了，如上面的main；
-  --output-type：指定输出类型，例如png、gif、html和ps，缺省是ps，如上面的main.ps；
-  -d：指定最大调用层数；
-  -s：仅仅显示指定的函数，而不对其调用进行展开；
-  -i：忽略指定的函数
-  -t：忽略Linux特有的内核函数集；
-  -k：保留由-s忽略的内部细节形成的中间文件，为sub.graph

使用gengraph时的选项参数值要使用""括起来，例如：
>gengraph --output-type "png" -f main

**命名冲突问题**
在一个复杂的项目中，full.graph并不十分完美。例如，kernel中的模块有许多同名函数，这时genfull不能区分它们，有两种方法可以解决，其中第一种方法太复杂易错不推荐使用，这里就介绍下第二种方法，即使用genfull的-s选项，-s指定了检测哪些子目录。例如kernel中在mm目录和drivers/char/drm目录下都定义了alloc_pages函数，那么可以以下列方式调用genfull：
>genfull -s "mm include/linux drivers/block arch/i386"

实际的使用中，-s非常方便，请大家记住这个选项。

6、演示
以分析《嵌入式实时操作系统 uC/OS-II (第二版)》中的第一个范例程序为例，是什么程序不要紧，这里主要看的是如何使用及使用后的效果

首先分析main()：
1. gengraph --output-type gif -f main
分析main()的call graph，得到的图如下，看不出要领：

2. gengraph --output-type gif -f main -s OSInit
暂时不关心OSInit()的内部实现细节(参数 -s)，让它显示为一个节点。得到的图如下，有点乱，不过好多了：

3. gengraph --output-type gif -f main -s OSInit -i "OSCPUSaveSR;OSCPURestoreSR"
基本上每个函数都会有进入/退出临界区的代码，忽略之(参数 -i)。得到的图如下，基本清楚了：

4. gengraph --output-type gif -f main -s "OSInit;OSSemCreate" -i "OSCPUSaveSR;OSCPURestoreSR" -k
OSSemCreate()的内部细节似乎也不用关心，不过保留中间文件sub.graph(参数 -k)，得到的图如下，

5. dot -Tgif -o main.gif sub.graph
修改sub.graph，使图形符合函数调用顺序，最后得到的图如下，有了这个都不用看代码了:)

接着分析OSTimeDly()的被调用关系：
gengraph --output-type gif -r -f OSTimeDly

最后看看Task()直接调用了哪些函数：
gengraph --output-type gif -d 1 -f Task
只看从Task出发的第一层调用（参数 -d 1）：