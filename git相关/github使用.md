## git和github使用总结

### 安装git
>apt-get install git

### 在github上注册帐号

### 在linux上生成ssh key
使用命令 “ssh-keygen -t rsa -C "your_email@youremail.com"”，your_email是你的email

>ssh-keygen -t rsa -C "manu.tsingdao@gmail.com"

文件 /home/manu/.ssh/id_rsa.pub

### 回到github
进入Account Settings，左边选择SSH Keys，Add SSH Key,title随便填，粘贴key。key就是

>cat /home/manu/.ssh/id_rsa.pub的内容

### 测试ssh key是否成功

测试ssh key是否成功，使用命令“ssh -T git@github.com”，如果出现You’ve successfully authenticated, but GitHub does not provide shell access 。这就表示已成功连上github。

### 配置git username 和 email
git config --global user.name "your name" //配置用户名
git config --global user.email "your email" //配置email

#### 本地链接github
>git clone https://github.com/woylaski/notebook.git

git add XXX
git commit -m ""
git push

#### github 同步更新到本地

如果已经有了，那就这两个命令的其中选一个，但是要注意：fetch 命令只是将远端的数据拉到本地仓库，并不自动合并到当前工作分支，只有当你确实准备好了，才能手工合并，pull 命令自动抓取数据下来，然后将远端分支自动合并到本地仓库中当前分支

git fetch origin
git pull
推送到git服务器上用

git push origin master
