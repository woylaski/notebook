Ubuntu Linux下怎样同时对麦克风及系统声音进行录音

花了一天时间来研究这个解决方案，和大家分享一下，原理是分别启动两个进程对设备进行录制，然后再合成：

First, install sox and get my scirpt brecord:

sudo apt-get install -y sox
sudo wget http://www.eguidedog.net/files/brecord -O /usr/bin/brecord
Then, run the script to record with CTRL+C to end recording:
brecord filename
Finally, play recording with:
play filename.wav
参考：How to Record both MIC and System Playback on Ubuntu Linux?