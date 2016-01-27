由于授权问题，在较新的Linux发行版本中都不再包含Oracle Java，取而代之的是OpenJDK，Ubuntu也是如此。OpenJDK能满足大部分的应用程序运行条件，但有些无法在OpenJDK条件下运行，因此需要安装Oracle公司的JDK。

## 安装JDK
在Ubuntu中安装JDK有不同方法，这里提供一种个人觉得最简单的方法，使用apt安装。因为版权问题，在Ubuntu的APT仓库中不提供Oracle Java下载，执行以下命令查看：
>$ apt-cache search oracle-java

>$ apt-cache search java7

只可以搜索到OpenJDK的相关包。

　因为授权问题，Oracle JDK不包含在官方的PPA列表中，但感谢那些自由软件的贡献者，他们制作了一个PPA可以从Oracle官方下载最新版JDK到本地，自动安装和升级。注意的是这个PPA是一个alpha版本，作者不承诺任何保障，使用者自己承担风险。(PPA：Personal Package Archive)

执行以下命令添加PPA，然后更新APT。
　　sudo add-apt-repository ppa:webupd8team/java
　　sudo apt-get update

更新完成后再搜索一下JDK包：
　　$ sudo apt-cache search oracle-java
　　oracle-jdk7-installer - Oracle JDK7 Installer meta package
　　oracle-java7-installer - Oracle Java(TM) Development Kit (JDK) 7
　　oracle-java6-installer - Oracle Java(TM) Development Kit (JDK) 6
　　oracle-java8-installer - Oracle Java(TM) Development Kit (JDK) 8
　　oracle-java7-set-default - Set Oracle JDK 7 as default Java
　　oracle-java6-set-default - Set Oracle JDK 6 as default Java
　　oracle-java8-set-default - Set Oracle JDK 8 as default Java

搜索到了最新的JDK，选择安装Java8，执行：
　　sudo apt-get install oracle-java8-installer
  安装都是自动完成的，中间会弹出提示要求接受Oracle的授权条款，全部同意就可以了。

如果需要设置环境变量可以执行：
　　sudo apt-get install oracle-java8-set-default

## 配置$JAVA_HOME 环境变量
sudo update-alternatives --config java

检查一下JAVA的路径。

编辑sudo nano /etc/environment文件，添加JAVA_HOME="/usr/lib/jvm/java-8-oracle" 一行。

载入文件测试启动source /etc/environment，然后再看看文件路径echo $JAVA_HOME