## 解决Debian找不到add-apt-repository的问题

网上查了一下资料，原来是需要
software-properties-common
于是 apt-get install software-properties-common

需要的依赖有以下几个：
python3-software-properties
然后就能用add-apt-repository了