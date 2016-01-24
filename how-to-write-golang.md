## 学习写go语言
----------
### 1. go 语言工具

go是个操作go代码的工具，位于
> /usr/local/go/bin/go

用法
>go command [arguments]

支持的命令
>==build:==       compile packages and dependencies  
==clean:==       remove object files 
==doc:==         show documentation for package or symbol
==env:==         print Go environment information
==fix:==         run go tool fix on packages
==fmt:==         run gofmt on package sources
==generate:==    generate Go files by processing source
==get:==         download and install packages and dependencies
==install:==     compile and install packages and dependencies
==list:==        list packages
==run:==         compile and run Go program
==test:==        test packages
==tool:==        run specified go tool
==version:==     print Go version
==vet:==         run go tool vet on packages

可以使用"==go help [command]=="了解命令的使用方式

### go工作目录
------------------
- src : 源代码
- pkg : 包
- bin : 编译后的可执行目录

设置工作目录环境变量
>$ mkdir $HOME/work
$ export GOPATH=$HOME/work
$ export PATH=$PATH:$GOPATH/bin

### go常用用法

- go install
- go build
- go test