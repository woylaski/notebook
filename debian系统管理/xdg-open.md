xdg-open

在GNU/Linux下，当需要打开其他格式文件时，咱们通常做法是进入到文件所在的目录，双击打开，很影响效率。事实上，可以通过命令xdg-open打开这些格式文件，甚至是网页，像打开文件一样简单。  

    在GNU/Linux下，通常用命令行打开文本文件，比如用命令gedit、more、cat、vim、less。但当需要打开其他格式文件时，比如pdf、jpg、mp3格式文件，咱们通常做法是进入到文件所在的目录，双击打开，很影响效率。事实上，可以通过命令xdg-open(opens a file or URL in the user's preferred application)打开这些格式文件。

xdg-open: 功能是把要打开的文件使用用户首选的应用程序进行打开，如要打开了个jpeg的文件，则可以使用xdg-open fuckgfw.jpeg 即会使用首选的(也可理解为默认的)应用程序来进行打开这个jpeg文件；

更多用法可以在GNU/Linux发行版本中安装此命令行后，进行man xdg-open 进行获得更详细的帮助说明；


关于更多xdg-系列的命令行可参考：
http://portland.freedesktop.org/xdg-utils-1.0/