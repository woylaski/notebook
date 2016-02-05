## 关于nodejs
JavaScript是一种运行在浏览器的脚本，它简单，轻巧，易于编辑，这种脚本通常用于浏览器的前端编程，但是一位开发者Ryan有一天发现这种前端式的脚本语言可以运行在服务器上的时候，一场席卷全球的风暴就开始了。

Node.js是一个基于Chrome JavaScript运行时建立的平台， 用于方便地搭建响应速度快、易于扩展的网络应用。Node.js 使用事件驱动， 非阻塞I/O 模型而得以轻量和高效，非常适合在分布式设备上运行的数据密集型的实时应用。

Node是一个Javascript运行环境(runtime)。实际上它是对Google V8引擎进行了封装。V8引 擎执行Javascript的速度非常快，性能非常好。Node对一些特殊用例进行了优化，提供了替代的API，使得V8在非浏览器环境下运行得更好。

## 关于nvm
nvm是node的版本管理工具, 我们可以同时安装多个不同版本的nodejs/npm, 我们使用nvm来安装、管理选择使用哪个版本的nodejs

### 安装 nvm
>curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash

安装完成后请重新打开终端环境，Mac 下推荐使用 oh-my-zsh 代替默认的 bash shell。

### 安装切换各版本 node/npm
>nvm install stable #安装最新稳定版 node，现在是 5.0.0
nvm install 4.2.2 #安装 4.2.2 版本
nvm install 0.12.7 #安装 0.12.7 版本

> 特别说明：以下模块安装仅供演示说明，并非必须安装模块
nvm use 0 #切换至 0.12.7 版本
npm install -g mz-fis #安装 mz-fis 模块至全局目录，安装完成的路径是 /Users/<你的用户名>/.nvm/versions/node/v0.12.7/lib/mz-fis
nvm use 4 #切换至 4.2.2 版本
npm install -g react-native-cli #安装 react-native-cli 模块至全局目录，安装完成的路径是 /Users/<你的用户名>/.nvm/versions/node/v4.2.2/lib/react-native-cli

nvm alias default 0.12.7 #设置默认 node 版本为 0.12.7

### 使用 .nvmrc 文件配置项目所使用的 node 版本
如果你的默认 node 版本（通过 nvm alias 命令设置的）与项目所需的版本不同，则可在项目根目录或其任意父级目录中创建 .nvmrc 文件，在文件中指定使用的 node 版本号，例如：
>cd <项目根目录>  #进入项目根目录
echo 4 > .nvmrc #添加 .nvmrc 文件
nvm use #无需指定版本号，会自动使用 .nvmrc 文件中配置的版本
node -v #查看 node 是否切换为对应版本


## 关于npm
NPM的全称是Node Package Manager[1]  ，是一个NodeJS包管理和分发工具，已经成为了非官方的发布Node模块（包）的标准。

npm使用来安装、管理nodejs模块的包管理工具
npm是一个node包管理和分发工具，已经成为了非官方的发布node模块（包）的标准。有了npm，可以很快的找到特定服务要使用的包，进行下载、安装以及管理已经安装的包


