/*
PathAttribute
    PathAttribute 定义一些属性，它的声明语法类似下面：
    PathAttribute { name: "zOrder"; value: 0.2; }
    name 属性指定待定义属性的名字， real 类型的 value 属性的值为待定义的属性的值。
    PathAttribute 放在某个路径段的前面，指明这段路径起始时的属性值；路径段后面的 PathAttribute 指明路径段终止时的属性值；而在路径段上的属性值， Path 会根据起、止值自动插值计算。
    我们可以通过使用 PathAttribute 来定义一些属性，用于控制分布在路径上的 item 的外观。比如定义名为 "zOrder" 的属性，控制沿路径分布的 item 的 Z 序。
    下面是个简单的示例：
*/

    Path {
            startX: 10;
            startY: 100;
            PathAttribute { name: "zOrder"; value: 0 }
            PathAttribute { name: "itemAlpha"; value: 0.1 }
            PathAttribute { name: "itemScale"; value: 0.6 }
            PathLine {
                x: root.width/2 - 40;
                y: 100;
            }
            PathAttribute { name: "zOrder"; value: 10 }
            PathAttribute { name: "itemAlpha"; value: 0.8 }
            PathAttribute { name: "itemScale"; value: 1.2 }
            PathLine {
                relativeX: root.width/2 - 60;
                relativeY: 0;
            }
            PathAttribute { name: "zOrder"; value: 0 }
            PathAttribute { name: "itemAlpha"; value: 0.1 }
            PathAttribute { name: "itemScale"; value: 0.6 }
        }
/*
我把路径分成了两段，起点是 (10, 100) 。为路径定义了三个属性， zOrder 、 itemAlpha 、 itemScale ，
在 PathView 的 delegate 中会用到这些属性。以 zOrder 属性为例，起点处值为 0 ，中间值为 1 ，终点值为 0 ，其它的， 
Path 会自动根据两端的值来生成。
    PathAttribute 定义的属性，会导出为 delegate 的顶层 item 的附加属性，通过 PathView.${name} 的形式来访问。
    比如 zOrder 属性，在 delegate 中使用 PathView.zOrder 访问。
*/