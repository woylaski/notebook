# 4.5.0 https://github.com/cneben
- Update to FontAwesome 4.5.0 (manual)
- Use a QML singleton to simplify FA initialization and import

# 4.4.0 Benjamin Pannell / EMSSConsulting https://github.com/EMSSConsulting/font-awesome-qml
- Updated to FontAwesome 4.4.0
- Added a Node.js script to simplify updating to newer versions of FontAwesome
    You will need to copy the latest `fontawesome-webfont.ttf` file into `resource` and then run
    `node script/ConvertVariables.js /path/to/fontawesome/less/variables.less controls/Variables.qml`
    which will update the icon list. Finally, bump the version number in `main.cpp` to match the latest
    FontAwesome version number.

# Pre 4.4.0 Ricardo do Valle / https://github.com/QMLCommunity/font-awesome-qml
