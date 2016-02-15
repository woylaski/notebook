## debian jessie的音频驱动架构
我现在用的是debian jessie 8.2，用的音频驱动架构是alsa

音频设备载/dev/snd下
>manu@debian-manu:~/图片$ ls -l /dev/snd
总用量 0
drwxr-xr-x  2 root root       60 2月  14 08:46 by-path
crw-rw----+ 1 root audio 116,  2 2月  14 08:46 controlC0
crw-rw----+ 1 root audio 116,  7 2月  14 08:46 hwC0D0
crw-rw----+ 1 root audio 116,  8 2月  14 08:46 hwC0D3
crw-rw----+ 1 root audio 116,  4 2月  14 15:42 pcmC0D0c
crw-rw----+ 1 root audio 116,  3 2月  14 16:21 pcmC0D0p
crw-rw----+ 1 root audio 116,  5 2月  14 08:46 pcmC0D2c
crw-rw----+ 1 root audio 116,  6 2月  14 11:53 pcmC0D3p
crw-rw----+ 1 root audio 116,  1 2月  14 15:24 seq
crw-rw----+ 1 root audio 116, 33 2月  14 15:24 timer


### 声卡的管理和使用
安装alsa-lib alsa-utils

### 音频播放测试
测试aplay程序
aplay  test1.wav

###volumn设置声音大小

amixer cset numid=1 45 

### amixer 用法
amixer cset numid=N  value        //设置变量，numid对应contents的id
amixer cget numid=N               //获取amixer的某个设置
amixer contents

### 录音
arecord -d 1 -t wav -c2 -r 8000 -f  S16_LE test1.wav
arecord -d 60 -t wav -c2 -r 8000 -f S16_LE test1.wav

-d  录音时间，单位秒
-c 声道数
-r 采样频率
-f  采样格式， 16bit  小端

 录音1分钟， 另一个终端随机播放， 然后听录音后的文件，没有任何噪声，中断和异常
arecord -d 60 -t wav -c2 -r 8000 -f S16_LE test1.wav
aplay test1.wav