1、coredump文件的存储位置
  core文件默认的存储位置与对应的可执行程序在同一目录下，文件名是core，大家可以通过下面的命令看到core文件的存在位置：
  >cat  /proc/sys/kernel/core_pattern
  
  缺省值是core

  通过下面的命令可以更改coredump文件的存储位置，若你希望把core文件生成到/data/coredump/core目录下：
  >echo “/data/coredump/core”> /proc/sys/kernel/core_pattern

  我们通过修改kernel的参数，可以指定内核所生成的coredump文件的文件名。例如，使用下面的命令使kernel生成名字为core.filename.pid格式的core dump文件：
  >echo “/data/coredump/core.%e.%p” >/proc/sys/kernel/core_pattern

  这样配置后，产生的core文件中将带有崩溃的程序名、以及它的进程ID。上面的%e和%p会被替换成程序文件名以及进程ID。
  如果在上述文件名中包含目录分隔符“/”，那么所生成的core文件将会被放到指定的目录中。 需要说明的是，在内核中还有一个与coredump相关的设置，就是/proc/sys/kernel/core_uses_pid。如果这个文件的内容被配置成1，那么即使core_pattern中没有设置%p，最后生成的core dump文件名仍会加上进程ID。

2、Core_pattern的格式
  可以在core_pattern模板中使用变量还很多，见下面的列表：
  %% 单个%字符
  %p 所dump进程的进程ID
  %u 所dump进程的实际用户ID
  %g 所dump进程的实际组ID
  %s 导致本次core dump的信号
  %t core dump的时间 (由1970年1月1日计起的秒数)
  %h 主机名
  %e 程序文件名

3、core文件产生的条件
  产生coredump的条件，首先需要确认当前会话的ulimit –c，若为0，则不会产生对应的coredump，需要进行修改和设置。
  >ulimit  -c unlimited  (可以产生coredump且不受大小限制