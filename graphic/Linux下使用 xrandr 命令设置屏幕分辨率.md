最近在Linux下修改屏幕分辨率的时候，发现了一个非常有用的命令：xrandr

使用这个命令，可以方便的设置您显示器的的分辨率。尤其是当你使用了一些需要或者会自动改动您屏幕分辨率的程序以后。

您可以使用如下命令来将屏幕恢复到原来的分辨率：

[www.linuxidc.com @localhost ~]$ xrandr -s 0

其中的 -s 参数允许你指定屏幕的分辨率大小，参数 0 表示使用 xrandr 命令将屏幕设置为默认大小。或者你可以试试验其他的 1、2、3……看看您的显示器能显示多大的。如果您明确知道你的分辨率的话，你可以将这个参数直接写成你需求的分辨率，如下：

[www.linuxidc.com @localhost ~]$ xrandr -s 1024×768

你也可以使用 -q 参数来查看你的屏幕目前支持的分辨率的情况，或者什么参数也不加。

[www.linuxidc.com @localhost ~]$ xrandr -q

[www.linuxidc.com @localhost ~]$ xrandr

当然这个命令还有一些更复杂的用法，您可以用 info 命令来查看：

[www.linuxidc.com @localhost ~]$ info xrandr