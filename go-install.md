## go语言开发环境安装

### go 安装手册地址
https://golang.org/doc/install

下载安装包，解压到/usr/local
tar -C /usr/local -xzf go1.5.3.linux-amd64.tar.gz

设置环境变量
export PATH=$PATH:/usr/local/go/bin

测试go开发环境
export GOPATH=$HOME/work

```
package main

import "fmt"

func main() {
    fmt.Printf("hello, world\n")
}
```

>go install github.com/user/hello

>$ $GOPATH/bin/hello
hello, world