## 安装nvm

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | bash

使用下面指令验证是否安装成功
>source ～/.bashrc
>nvm --version

## 通过nvm安装nodejs

使用下面指令查看有哪些版本可以安装
>nvm ls-remote

所以执行下面的指令，就可以通过「nvm」安装「nodejs」了。(注意這個方式是安装「binary package」，而非下载「source package」，编译后安装
>nvm install v0.10.32
nvm install 0.10.32
nvm install v0.10
nvm install 0.10
nvm install stable

查看通过nvm安装了那些版本的nodejs
nvm ls

选择使用那个版本的nodejs（可能同时存在多个版本）
nvm use v5.5.0

选择默认版本
nvm alias default v5.5.0

再次执行
nvm ls
就能看到多了一个default

查看当前nodejs版本
node -v

nvm current

npm --version