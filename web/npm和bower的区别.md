
要讲出问题本质。npm install jquery 和 bower install jquery 到底区别在哪里？难道 npm install 出来的 jquery.js 就不能被浏览器加载了吗？

关键在于npm的依赖管理是奇特的倒向树结构（不同于linux越底层依赖越小）。一个普通的前端包的依赖树非常冗长，甚至可能触及windows下256字符的路径长度限制。同时和其它安装包不能共享依赖代码。导致文件非常多，不适合前端代码部署。而bower让模块开发者定义了简洁的输出文件。

不过下一代 npm3 会从根本上改善这一问题，所有依赖包会水平处理共享。随着CommonJS普及，前后端今后统一使用npm是大势所趋。

---------
npm是node js的包管理器，用来下载安装node js的第三方工具包，也可以用来发布你自己开发的工具包。bower是一个前端库管理的工具，管理一些js库，比如说jQuery，bootstrap等。通过bower，你就不用自己去找jQuery文件了，通过配置文件就可以自动完成了。通过npm可以安装bower，命令如下：
npm install -g bower

------------
bower 安装必须安装npm ，npm 会将开发环境一起下载下来，bower 只会下载 编译后的前度模块。 功能上是一样的。

-----------
[https://segmentfault.com/img/bVqRMN](https://segmentfault.com/img/bVqRMN)

具体请参考如下：
http://stackoverflow.com/questions/18641899/what-is-the-difference-between-bower-and-npm
