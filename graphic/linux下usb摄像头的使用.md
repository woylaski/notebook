## 首先查看硬件信息

是否已经识别并加载了usb camera

### 使用dmesg查看内核信息

dmesg | grep USB
>[14927.713931] usb usb3-port4: unable to enumerate USB device
[14935.624531] usb 3-3: new high-speed USB device number 9 using xhci_hcd
[14935.836056] usb 3-3: New USB device found, idVendor=058f, idProduct=3880
[14935.836060] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[14935.836063] usb 3-3: Product: USB 2.0 PC Camera
[14935.837767] uvcvideo: Found UVC 1.00 device USB 2.0 PC Camera (058f:3880)
[14935.841193] input: USB 2.0 PC Camera as /devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3:1.0/input/input18
[14950.722530] usb 3-3: USB disconnect, device number 9
[14953.615886] usb 3-4: new high-speed USB device number 10 using xhci_hcd
[14953.827364] usb 3-4: New USB device found, idVendor=058f, idProduct=3880
[14953.827369] usb 3-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[14953.827372] usb 3-4: Product: USB 2.0 PC Camera
[14953.829039] uvcvideo: Found UVC 1.00 device USB 2.0 PC Camera (058f:3880)
[14953.832488] input: USB 2.0 PC Camera as /devices/pci0000:00/0000:00:14.0/usb3/3-4/3-4:1.0/input/input19
[15275.557693] usb 1-1.5: new high-speed USB device number 4 using ehci-pci
[15275.661777] usb 1-1.5: New USB device found, idVendor=05e3, idProduct=0510
[15275.661780] usb 1-1.5: New USB device strings: Mfr=2, Product=3, SerialNumber=0
[15275.661781] usb 1-1.5: Product: USB2.0 UVC PC Camera
[15275.691713] uvcvideo: Found UVC 1.00 device USB2.0 UVC PC Camera (05e3:0510)
[15275.722219] input: USB2.0 UVC PC Camera as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.5/1-1.5:1.0/input/input20

通过上面能大概看出来有两个usb摄像头，而且是支持uvc的usb 2.0摄像头

### lsmod 看看usb相关驱动
lsmod | grep usb
>usbhid                 44460  0 
hid                   102264  2 hid_generic,usbhid
usbcore               195427  5 uvcvideo,ehci_hcd,ehci_pci,usbhid,xhci_hcd
usb_common             12440  1 usbcore

看到有uvcvideo这个驱动

### 使用lsusb查看设备

lsusb
>Bus 002 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 003: ID 04d9:1702 Holtek Semiconductor, Inc. 
Bus 001 Device 004: ID 05e3:0510 Genesys Logic, Inc. 
Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 010: ID 058f:3880 Alcor Micro Corp. 
Bus 003 Device 002: ID 093a:2510 Pixart Imaging, Inc. Optical Mouse
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

### /dev/下查看是否有video设备文件
ls /dev/ | grep video

>video0
video1

### 使用lshal查看摄像头信息
先看看摄像头的相关信息：

lshal | grep Cam
> info.product = 'USB2.0 UVC PC Camera'  (string)
  usb_device.product = 'USB2.0 UVC PC Camera'  (string)
  usb.interface.description = 'USB2.0 UVC PC Camera'  (string)
  info.product = 'USB2.0 UVC PC Camera'  (string)
  info.product = 'USB2.0 UVC PC Camera'  (string)
  input.product = 'USB2.0 UVC PC Camera'  (string)
  info.product = 'USB 2.0 PC Camera'  (string)
  usb_device.product = 'USB 2.0 PC Camera'  (string)
  usb.interface.description = 'PC Camera'  (string)
  usb.interface.description = 'PC Camera'  (string)
  info.product = 'USB 2.0 PC Camera'  (string)
  info.product = 'USB 2.0 PC Camera'  (string)
  input.product = 'USB 2.0 PC Camera'  (string)
  info.product = 'USB 2.0 PC Camera'  (string)
  input.product = 'USB 2.0 PC Camera'  (string)

### 安装guvcview来使用usb摄像头
sudo apt-get install libguvcview-dev
sudo apt-get install guvcview 