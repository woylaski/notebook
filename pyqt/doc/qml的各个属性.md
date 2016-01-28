```
Item {
    Rectangle {
        id : oneRect
        x : 120; y : 20
        width : 100;
        height : 100
        color : "green"
        Rectangle {
            id : twoRect
            anchors.left : oneRect.right
            width : 80;
            height : 80
            color : "red"
        }
    }
}
```
anchors.left描述的是一条垂直线，在上面程序中描述的就是oneRect的右边的那条线

```
Item {
    Rectangle {
        id : oneRect
        x : 120; y : 20
        width : 100;
        height : 100
        color : "green"
        Rectangle {
            id : twoRect
            anchors.left : oneRect.right
            width : 80;
            height : 80
            color : "red"
        }
    }
}
```

anchors.right描述的是一条垂直线，在上面程序中描述的就是oneRect的左边的那条线。注意如果anchors的属性是一条垂直线则不能将为水平线的属性设置给他，否则会报异常"Cannot anchor a horizontal edge to a vertical edge",同理anchors的属性是一条水平线则不能将为垂直线的属性设置给他。

```
Item {
    Rectangle {
        id : oneRect
        x : 120; y : 20
        width : 100;
        height : 100
        color : "green"
        Rectangle {
            id : twoRect
            anchors.horizontalCenter : oneRect.horizontalCenter
            width : 80;
            height : 80
            color : "red"
        }
    }
}
```

anchors.horizontalCenter描述的是一个点，这个点实际上就是anchors.top的中心点，注意如果将anchors.horizontalCenter和其他一些anchors属性一起使用可能引发一些未知的结果。比如我们在twoRect中加入anchors.right : oneRect.left，这样子会导致twoRect的宽度和oneRect的宽度一样，都是100，而不是设置的80。所以设置相对属性的时候，避免相对属性间冲突。
```
Item {
    Rectangle {
        id : oneRect
        x : 120; y : 20
        width : 100;
        height : 100
        color : "green"
        Rectangle {
            id : twoRect
            anchors.verticalCenter : oneRect.verticalCenter
            width : 80;
            height : 80
            color : "red"
        }
    }
}
```

anchors.verticalCenter属性也是描述的一个点，这个点实际上就是anchors.left的中心点。

```
Item {
    Rectangle {
        id : oneRect
        x : 120; y : 20
        width : 100;
        height : 100
        color : "green"
        Rectangle {
            id : twoRect
            anchors.centerIn : oneRect
            width : 80;
            height : 80
            color : "red"
        }
    }
}
```

anchors.centerIn描述的是一个区域，如上程序中就指的值twoRect元素位于oneRect元素的中心区域，他是基于oneRect元素中心点辐射的一个区域（可能大于oneRect的区域）。anchors.centerIn和anchors.fill属性有点类似，不过anchors.centerIn更加着重强调两个元素之间具有同一个中心点。而anchors.fill则更加着重强调相对元素对当前元素的包含关系，当前元素的大小是不会超过相对元素的区域大小的。