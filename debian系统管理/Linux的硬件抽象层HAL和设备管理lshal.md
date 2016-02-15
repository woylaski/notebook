## 关于HAL

>http://blog.csdn.net/colorant/article/details/2611559

HAL是Hardware Abstraction Layer即硬件抽象层的首字母缩写，以下来源于Hal Spec的框图很好的说明了它的组成部分：

![HAL](http://p.blog.csdn.net/images/p_blog_csdn_net/colorant/hal-arch.png  "HAL")

它是一个位于操作系统和驱动程序之上，运行在用户空间中的服务程序。
它的目的是对上层应用提供一个统一的简单的查询硬件设备的接口。它所谓的抽象，基本上也就仅限于这一功能，它通常并不提供对硬件的实际操作，对硬件的操作，还是由应用程序来完成。
细化来说，除了提供标准的硬件查询接口，它甚至并不考虑如何对硬件进行配置，这不是它要完成的工作，但它确实提供了存储硬件配置相关信息的空间。下面我们会说到，那被称为属性。
所以，简单的说，你可以把HAL理解为：一堆的硬件列表以及他们的相关属性的集合。
那么，这一堆硬件列表能有什么用呢？应该说，它简化了应用的查询逻辑，把这一部分的复杂性转移到了应用程序之外，由HAL统一处理，其次，按作者的期望，当一些库函数也开始使用HAL的时候，应用程序甚至可以把对不同硬件的实际操作的复杂性也交给库函数来自动处理。

###  HAL的组成框架
按照上面的框图，首先是HAL daemon，HAL的服务进程。其次是硬件信息文件，后缀fdi，再有是Callout和Addons，这些是HAL针对不同硬件进行额外的处理工作所需的一些可执行文件或脚本。
在Hal内部，每个硬件（具体的或抽象的）都是由一个Device Object设备对象来表示。
 
每个设备对象会包括以下几个概念的组成部分：
UDI: Unique Device Identifer 每个设备对象的唯一标识符，它是根据BUS信息得到的，它的目标是保证设备的唯一性，同时在一个可移除设备多次插入拔出过程中保持相同的值。
Property ：属性，是一个key/value pair。每个属性由一个键和一个键值组成，用来存储设备对象相关的各种信息。
Method ：方法是用来读取设置属性，或提供某些特定操作。
Interface ：这个更多的是DBUS的概念。属性和方法被分类到不同的Interface中。

###  HAL硬件信息的来源
HAL中设备对象的相关信息来源主要有以下几种：
 
Ø       通过Sysfs得到，有相当一部分的属性是通过这种方式得到的，比如UDI，设备的厂商，设备的父节点，设备的总线类型，硬盘的UUID啊等等。
 
Ø       通过Probe探测得到，有些设备，例如一个Camera设备，它支持哪些数据格式啊之类的信息，对应用层程序也是有意义的，但是只是通过Sysfs接口并不能得到，而通过Linux V4L2子系统所定义的的一些标准接口函数，通过IOCTL可以得到这些信息。通常这是由HAL服务进程调用相应的callout去probe得到。类似还有很多子系统都定义了自己标准的接口函数，这为HAL获取进一步的设备信息提供了可能性。次外，设备的当前状态啊，等信息，也可能由Addon通过某些接口得到。
 
Ø       通过fdi设备信息文件得到。还有些信息，可能是一些通用的设备信息（比如？要举个例子），或者是通过对硬件本身的探测也无法获得的信息，比如某些键盘上的某些特殊功能键的定义等等，还有可能是一些权限控制信息等，这些信息可以通过fdi文件添加到HAL的设备对象信息数据中。

### HAL的相关文件
首先是硬件信息文件fdi的路径会有：
/usr/share/hal/fdi 通常是由系统程序安装包提供的文件。
/etc/hal/fdi 这里是用户或者管理员修改fdi的位置。
这两个路径下各自存在information policy preprobe等3个目录，用来存放不同用途的fdi文件。后面再解释。
 
其次是HAL的一些Callout和Addon，他们位于 /usr/lib/hal/scripts 及 /usr/lib/hal/ 下面
 
再有一些与HAL本身相关的配置文件等：
/etc/init.d/hal hal的启动脚本
/etc/udev/rules.d/95-hal.rules  HAL在UDEV中的规则
/etc/dbus-1/system.d/hal.conf  HAL的一些常用的Interface在DBUS中的权限设置。
 
相关程序
/usr/bin/lshal
/usr/bin/hal-device
/usr/bin/hal-get-property
/usr/bin/hal-set-property
/usr/bin/hal-find-by-capability
/usr/bin/hal-find-by-property
/usr/bin/hal-disable-polling
/usr/bin/hal-is-caller-locked-out
/usr/bin/hal-lock
/usr/sbin
/usr/sbin/hald

### HAL设备检测流程
Hal通过udev发现一个新的设备。
首先，处理 fdi/preprobe 目录下所有匹配的文件。这个目录下的文件，典型的用途是通过设置info.ignore属性，禁止以后的其它操作，这么做的目的通常是为了绕过某些硬件bug或者忽略某些设备。但也不局限于此，凡是你希望在HAL对设备进行探测操作之前要处理的事情，都可以放在这里。
而后，HAL调用preprobe中可能指定的callout做一些额外的预处理工作。
HAL开始做实际的硬件探测工作
HAL处理fdi/information目录下的所有相关文件。这里的文件的典型应用是添加一些设备相关的信息。比如，根据bus和vendorID 等信息匹配USB接口的某个品牌的MP3，添加其所支持的音频格式信息（相当于以配置文件的形式，人为的告知系统这个MP3支持什么格式）
HAL处理fdi/policy目录下的所有相关文件。这里的文件的典型应用是关联设备对象可能对应需要的Addon和Callout，例如键盘设备可能会需要绑定一个名为hald-addon-keyboard的addon
HAL调用Callout ，通常来说Callout都是一些做Probe用途的程序，运行过就退出。
HAL调用Addon，Addon通常是用来监听设备状态的服务进程，生命周期和设备的生命周期一致。
HAL将设备对象暴露出来完成整个设备检测流程

### HAL如何监听设备变更情况
做为硬件抽象层，HAL也必须负责对设备的动态变化进行监测，实时更新设备对象的信息。这需要多方面的信息来源。
首先是UDEV：
在/etc/udev/rules.d/95-hal.rules 中，为HAL添加了下面一条规则，目的是让Udev把设备变更信息通过socket发送给HAL。
RUN+="socket:/org/freedesktop/hal/udev_event"
在HALD的启动过程中，hald会打开并监听这个socket。
 
其次是通过某些addon去监听硬件行为
由于不同的硬件，有着很不同的行为，HAL还会通过一些特定的Addon来监听设备的状态变更情况。例如针对input类设备，hald会启动一个 hald-addon-input 的Addon，它的其中一个功能就是监听键盘事件，如果其中有sw类的事件（如sw_lid 因该是表示笔记本盖的开合，好像电源管理会模拟这个事件）则会去修改设备对象对应的状态属性。其它Addon没有仔细研究。

## 使用HAL

### HAL相关的一些工具
要使用hal，从hal中获得硬件相关的信息，当然可以编程啦，其次，可以使用dbus-send工具来操作HAL的interface：
例如查询当前平台都有哪些设备：
dbus-send --system --print-reply --dest=org.freedesktop.Hal /org/freedesktop/Hal/Manager org.freedesktop.Hal.Manager.GetAllDevices
 
当然，通过Dbus接口可以完成很强大的功能，但是多数情况下，我们可能只需要完成一些简单的操作，那么我们可以使用例如：

### Lshal

直接使用Lshal可以列出当前平台上的设备对象及这些设备对象的所有属性。
Lshal –t 可以以树的形式列出所有设备对象及它们的层次关系。
Lshal –m 可以用来检测hal的服务进程所发出的设备变更的信息，例如我插入了一个USB接口的读卡器，得到下列输出：
17:31:39.068: usb_device_4cf_8819_000100000000 added
17:31:39.202: usb_device_4cf_8819_000100000000_if0 added
17:31:39.225: usb_device_4cf_8819_000100000000_usbraw added
17:31:44.130: usb_device_4cf_8819_000100000000_if0_scsi_host added
17:31:44.136: usb_device_4cf_8819_000100000000_if0_scsi_host_scsi_device_lun0 added
17:31:44.138: usb_device_4cf_8819_000100000000_if0_scsi_host_scsi_device_lun0_scsi_generic added
17:31:44.228: storage_serial_Myson_SD_MMC_MS_Reader_000100000000_0_0 added

### Hal-device
Hal-device也可以用来显示当前设备对象，此外还可以用-a / -r参数来添加,删除设备对象，例如：
 
/ # hal-device -a /org/freedesktop/Hal/devices/try // my input
tmp udi: /org/freedesktop/Hal/devices/tmpe0743
platform.id = 'hello' //my input
created: /org/freedesktop/Hal/devices/try
 
/ # hal-device /org/freedesktop/Hal/devices/try
udi = '/org/freedesktop/Hal/devices/try'
  platform.id = 'hello'  (string)
  info.udi = '/org/freedesktop/Hal/devices/try'  (string)

### 配置文件
当然Hal的最常见的用法，还是通过修改和创建HAL的fdi文件，借助基于HAL的一系列程序，完成个人所需的定制的功能。
例如，将你的USB接口的MP3在自动插入时，以指定的名字Mount到指定的位置等。
