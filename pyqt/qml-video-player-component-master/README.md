# qml-video-player-component
The QML component for integrating a simple video player into your Sailfish application. It is licensed under the terms of the GNU General Public License v3.

This component is the part of [Kat project](https://github.com/osanwe/Kat).

**Usage**
```
Item {
    property string url
    property int duration

    VideoPlayer {}
}
```
where ```url``` is the full path to your video file, and ```duration``` is the length of the video.

