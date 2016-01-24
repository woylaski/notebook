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
