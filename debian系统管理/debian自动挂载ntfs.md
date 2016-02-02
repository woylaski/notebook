默认情况下，Debian上的NTFS分区不会自动挂载，而且开机后想要手动挂载还需要root权限，不是特别方便，所以，我们需要让它能开机自动挂载。

首先我们需要ntfs-config这个工具

先安装：
sudo apt-get install ntfs-config

配置一下：
sudo ntfs-config
然后就会弹出来一个对话框，选择你需要挂载的分区，点应用，再选择“启用内部设备写支持”。

 
手动设置自动挂载分区：

编辑/etc/fstab文件 

$sudo nano /etc/fstab 在文件尾部添加如下内容：

/dev/分区 /media/挂载点 ntfs-3g defaults,locale=zh_CN.UTF-8 0 0

要挂载哪个分区可以自己fdsik -l看一下