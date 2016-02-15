Libav 是一套跨平台的库和工具，用来处理多媒体文件、流及协议，它原生于 ffmpeg 项目。它包含的一些工具如下：

avplay ：视频、音频播放器；
avconv ：多媒体转换器，并可以对来自不同源的视频和音频进行录制；
avprobe ：连接多媒体流文件流，并返回多种有用信息及统计数据的工具；
Libavfilter ：为不同 Libav 工具提供的过滤器API。
本文将阐释如何使用 Debian 、 Ubuntu 或 Linux Mint 发行版中的 avconv 进行Linux桌面音视频捕捉录制。

1. 安装avconv工具

avconv 是 libav-tools 软件包的一部分，对于如Ubuntu和Mint等所有基于 Debain 的发行版，可从官方的资源库中获取并进行安装，命令如下：

$ sudo apt-get update
$ sudo apt-get install libav-tools
注意：从缺省资源库中安装的软件包，版本可能有些旧，因此，推荐从官方的 git 资源库中获取最新版本进行编译安装，命令如下：

$ sudo apt-get install yasm
$ git clone git://git.libav.org/libav.git
$ cd libav
$ ./configure
$ make
$ sudo make install
当然，可以运行 ./configure –help 命令，先列出所有的可选项，进行配置并安装需要的库。为了安装依赖项，可能有大量的工作要做。在使用从源代码编译安装时，要注意操作权限，可能要使用 sudo avconv 而不是 avconv 来运行。

2. 开始捕捉录制桌面视频

安装就绪后，可使用下面的命令捕捉录制桌面视频：

avconv -f x11grab -r 25 -s 1920x1080 -i :0.0 -vcodec libx264 -threads 4 $HOME/output.avi
简单地介绍下上面的命令：

avconv -f x11grab 是从 X 服务器捕捉视频的缺省命令；
-r 25 是所需的帧频，可以根据需要进行调整；
-s 1920×1080 是视频的分辨率，选定的值不应大于当前系统屏幕最大分辨率，否则可能会出现以下错误：

avconv version 9.18-6:9.18-0ubuntu0.14.04.1, Copyright (c) 2000-2014 the Libav developers
  built on Mar 16 2015 13:19:10 with gcc 4.8 (Ubuntu 4.8.2-19ubuntu1)
[x11grab @ 0x9de2c0] device: :0.0 -> display: :0.0 x: 0 y: 0 width: 1920 height: 1080
[x11grab @ 0x9de2c0] shared memory extension  found
X Error of failed request:  BadMatch (invalid parameter attributes)
  Major opcode of failed request:  130 (MIT-SHM)
  Minor opcode of failed request:  4 (X_ShmGetImage)
  Serial number of failed request:  11
  Current serial number in output stream:  11
-i :0.0 要捕捉录制的当前 X 服务器的桌面，一般无需改变此值；

-vcodec libx264 录制视频时所用的编码库；

-threads 4 ，录制时所用的线程数，根据需要调整合适的值；

$HOME/output ，文件保存的目标路径；

.avi ，视频的格式及文件的扩展名，支持的格式还有 .flv 、 .mp4 、 .wmv 、 .mov 和 .mkv 等。

在命令行终端中，回车执行该命令后，就自动开始录制，可以在该命令行终端窗口时使用 Ctrl + C 终止录制。

录制结束，可使用mplayer或者其他的多媒体播放器进行播放，或者可以使用此 Libav 包中自带 avplay 工具进行播放，命令如下：

$ avplay $HOME/output.avi
注意：切勿忘记修改文件保存的目标路径。

3. 捕捉录制桌面的音频

如果要捕捉录制音频，首先执行下面的命令来列出所有可用的音频输入源：

$ arecord -l
该命令可能的输出如下：

card 0: SB [HDA ATI SB], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 2: ALC892 Alt Analog [ALC892 Alt Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: Loopback [Loopback], device 0: Loopback PCM [Loopback PCM]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: Loopback [Loopback], device 1: Loopback PCM [Loopback PCM]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
就我当前的系统而言，有 card 0 和 card 2 两块卡作为音频输入源卡（尽管 card 2 是伪设备），依次执行下面的命令来捕捉录制桌面的音频：

avconv -f alsa -i hw:0 output.wav
如果录制成 mp3 格式，可采用下面的命令：

avconv -f alsa -i hw:0 -acodec libmp3lame output.mp3
或 avconv -f alsa -i hw:0 output.mp3

如果系统支持多线程，也可采用下面的命令：

avconv -f alsa -i hw:0 -acodec libmp3lame -threads 4 output.wav
对以上命令的简单解释：

-f alsa ，捕捉音频的设备源可选项，其他的还有 dv1394 、 jack 、 fbdev 、 oss 及 pulse 等；
-i hw:0 ，对应 alsa 设备的音频输入源，此选项中 0 与 arecord -l 命令输出中 card 0 对应。
但采用 alsa 时，录制成的音频可能比源音频来音量小，推荐采用下面的方式改进：

1) 先执行下面的路径，找到 pulse 的源设备：

    $ pactl list sources | grep analog-stereo.monitor

该命令的输出可能如下：

    Name: alsa_output.pci-0000_00_14.2.analog-stereo.monitor
    Name: alsa_output.2.analog-stereo.monitor
2) 接着，采用 -f pulse 可选项进行捕捉录制音频，命令如下：

    avconv -f pulse -i alsa_output.pci-0000_00_14.2.analog-stereo.monitor output.wav
按下 Ctrl + C ，终止录制。

4. 同时捕捉录制桌面的视频和音频

同时录制桌面的视频和音频命令如下：

$ avconv -f alsa -i hw:0 -f x11grab -r 25 -s 1920x1080 -i :0.0 -vcodec libx264 -threads 4 output-02.avi
为改进音频的音量大小，推荐使用下面的命令：

$ avconv -f pulse -i alsa_output.pci-0000_00_14.2.analog-stereo.monitor -f x11grab -r 25 -s 1920x1080 -i :0.0 -vcodec libx264 -threads 4 output-file2.avi
如果音频采用 mp3 进行压缩编码，可采用下面的命令：

$ avconv -f pulse -i alsa_output.pci-0000_00_14.2.analog-stereo.monitor -f x11grab -r 25 -s 1920x1080 -i :0.0 -acodec libmp3lame -vcodec libx264 -threads 4 output-file2.avi