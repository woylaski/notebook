### Image Magick概述
http://elf8848.iteye.com/blog/382528
http://blog.sina.com.cn/s/blog_ba532aea0101bty5.html
http://blog.csdn.net/txgc0/article/details/14224325

 ImageMagick是一款命令行图像处理软件，某些在Photoshop之类的图像软件中要进行一系列步骤的繁琐操作，它只需要输入一行命令就可以解决，效率奇高。当然，命令行操作毕竟有着很大的局限性，只要把它作为一个辅助工具来看就可以。

 图像格式转换只需输入一行命令，还能完成裁剪、翻转、模糊、合并等操作

 ImageMagick是一个免费的创建、编辑、合成图片的软件。它可以读取、转换、写入多种格式的图片。图片切割、颜色替换、各种效果的应用，图片的旋转、组合，文本，直线，多边形，椭圆，曲线，附加到图片伸展旋转。其全部源码开放，可以自由使用，复制，修改，发布。它遵守GPL许可协议。它可以运行于大多数的操作系统。
 最为重要的是，ImageMagick的大多数功能的使用都来源于命令行工具。

### Image Magick的使用
 convert d:pic001.jpg d:pic001.png
　　convert是转换命令，后面的两个参数分别以空格隔开，前者是源图像的文件路径(JPG格式)，后者是转换后的文件(PNG格式)及它的保存路径，ImageMagick会根据给定文件的后缀名自动识别格式。按回车键，稍等片刻，在d:pic文件夹下果然多出了图像文件0001.png。

　转换同时缩小图像，输入：convert d:pic008.bmp -resize 50% d:pic001.jpg

　　这比上一行命令多出了-resize 50%，英文的意思是“调整大小”，50%表示将图像缩小一半。按回车键执行命令，完成后进入d:pic文件夹下查看，果然多出了一个0008.jpg图像文件。例如原来的BMP文件大小为9217KB，转换后的JPG文件则只有649KB，文件小了十几倍。

　　要获得特效字体，输入以下命令(在同一行上)：convert -size 320x85 xc:transparent -font Arial-Black -pointsize 72 -draw "text 25,60 'Magick'" -channel RGBA -gaussian 0x6 -fill darkred -stroke magenta -draw "text 20,55 'Magick'" d:picmagick.png
　　回车后将得到文字特效。-size为设置图像的大小，-font为设定字体，-pointsize为设定文字大小，-draw为写入文字内容等。

(1) 图片格式转换：比如把目录下所有的jpeg格式的图片转化为png的，就可以如下进行操作：
for pic in *.jpg
do
convert ${pic} `basename ${pic} .jpg`.png
done
(2) 压缩图片大小：一般来说，在web应用中，如果图片很多或者很大，就需要考虑对图片大小进行适当的压缩，常用的压缩办法有：减小图片尺寸（图片缩放），调节压缩比或者去除图片中的多余信息。这些操作使用ImageMagick就可以轻易的完成：
convert -resize 100x100 src.jpg des.jpg
把src.jpg的图片大小调整为100x100，convert命令在调整图片高度和宽度的过程中会进行等比压缩，也就是说图片des.jpg的高宽比将会和src.jpg一致。

convert -quality 75% src.jpg des.jpg
压缩比越低，图片的大小越小，一般来说75%是最佳的压缩比，在这种情况下肉眼是很难看出图片的失真。
convert -strip src.jpg dest.jpg
数码相机在拍照的时候会在生成的图片中留下一些额外的信息，这些信息往往是没用的，可以使用convert –strip命令去除。
以上三种操作可以合在一起进行：
convert -resize 100x100 –strip -quality 75% src.jpg dest.jpg
ImageMagick功能十分强大，上面只是抛砖引玉，有兴趣的同学可以去挖掘其更多的功能和用法。

