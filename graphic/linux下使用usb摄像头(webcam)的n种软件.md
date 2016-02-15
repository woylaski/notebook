## cheese（茄子）
[cheese](https://www.archlinux.org/packages/?name=cheese) 

cheese可以拍照、连拍、录像，直接载终端执行cheese即可，
照片存在~./图片目录，录像存放在~./视频目录

而且cheese还可以设置效果如功夫、万花筒、加边等

## qtcam

使用qml+qt5

## fswebcam

## GTK+ UVC Viewer (guvcview)

## VLC

VLC can also be used to view and record your webcam. In VLC's file menu, open the 'Capture Device...' dialog and enter the video and audio device files. Or from the command line, do:

>vlc v4l:// :v4l-vdev="/dev/video0" :v4l-adev="/dev/audio2"
This will make VLC mirror your webcam. To take stills, simply choose 

'Snapshot' in the 'Video' menu. To record the stream, you add a --sout argument, e.g.
> vlc v4l:// :v4l-vdev="/dev/video0" :v4l-adev="/dev/audio2" \ 
  --sout "#transcode

{vcodec=mp1v,vb=1024,scale=1,acodec=mpga,ab=192,channels=2}:duplicate{dst=std{access=file,mux=mpeg1,dst=/tmp/test.mpg}}"
(Obviously a bit overkill with regard to the bit rates but it is fine for testing purposes.) Notice that this will not produce a mirror on the display - in order to see what you are recording, you would need to add the display as a destination to the argument:
... :duplicate{dst=display,dst=std{access= ....
(Though this can tax older hardware somewhat...)

## MPlayer
To use MPlayer to take snapshots from your webcam run this command from the terminal:
> mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -fps 15 -vf screenshot

From here you have to press s to take the snapshot. The snapshot will be saved in your current folder as shotXXXX.png. If you want to record continuous video:
> mencoder tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0:forceaudio:adevice=/dev/dsp -ovc lavc -oac mp3lame -lameopts cbr:br=64:mode=3 -o filename.avi

## FFmpeg


