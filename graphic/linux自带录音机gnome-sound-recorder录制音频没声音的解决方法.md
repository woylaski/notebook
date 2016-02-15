sudo apt-get install gnome-sound-recorder

gnome-sound-recorder是linux系统自带的一款录音机软件，可以录制各种格式的音频文件，安装方法请参考:http://www.myzhenai.com/thread-15453-1-1.html
刚才我尝试着录制一段声音，但突然发现gnome-sound-recorder录制的音频里除了沙沙声，并没有其他的声音，我觉得很奇怪，各种播放器均可以正常播放，为什么录制声音就不行了呢？声卡说明是安装和正常的

后来想一想，可以问题出在声卡模式上，于是在声音属性(gnome-sound-recorder\文件\打开音量控制)\硬件\所选设备的设置，更改配置文件为“Analog Stereo OutPut”.问题解决.当然，你也可以测试各个配置文件看看效果如何.

Tags: Analog, GNOME, linux, OutPut, recorder, sound, Stereo

