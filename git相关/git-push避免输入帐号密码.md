## git push免除输入帐号密码

1、在~/下， touch创建文件 .git-credentials, 用vim编辑此文件，输入内容格式：

>touch .git-credentials
vim .git-credentials
https://{username}:{password}@github.com

2、在终端下执行  
>git config --global credential.helper store

3、可以看到~/.gitconfig文件，会多了一项：
>[credential]
    helper = store