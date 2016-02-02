我在我机器上安装了一个matlab,但在软件搜索里找不到matlab.

我发现是matlab没有对应的.desktop文件.

顺便我将matlab的图标也修改下.步骤如下:

1.准备一个icon图像文件

如我这里的文件名为matlab.png,将该文件拷贝到/usr/share/icons/hicolor/scalable/apps/下

aborn@aborn-pc ~/tmp % sudo cp matlab.png /usr/share/icons/hicolor/scalable/apps/

2. 根据你应用安装情况编辑一个.desktop文件,

这里我新建一个matlab.desktop文件,内容如下:

[Desktop Entry]
Version=7.12.0.635 (R2011a)
Name=Matlab
GenericName=Matlab 
Comment=Matlab R2011a Version
Exec=/usr/matlab/bin/matlab -desktop %F
TryExec=matlab
Icon=/usr/share/icons/hicolor/scalable/apps/matlab.png
Type=Application
Terminal=false

其中的Exec为执行命令,而Icon为对应的图标图像文件路经

3. 将.desktop文件拷贝到 /usr/share/applications/下

aborn@aborn-pc ~/tmp % sudo cp matlab.desktop /usr/share/applications/

4. 然后在软件搜索里就能找到了. 