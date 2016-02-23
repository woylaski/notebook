/*
PathPercent 放在组成路径的元素后面，比如放在 PathLine 后面，指明它前面的那部分路径（通常由一个或多个 Path 元素组成）所放置的 item 数量占整个路径上所有 item 数量的比率。
    PathPercent 的 value 属性为 real 值，范围 0.0 至 1.0 。需要注意的是，在一个 Path 中使用 PathPercent ，PathPercent 元素的 value 值是递增的，某一段路径如果在两个 PathPercent 之间，那么这段路径上面放置的 item 数量占路径上总 item 数量的比率，是后面的 PathPercent 与 前面的 PathPercent 的 value 之差。
    下面是个简单的示例
*/

     Path {
            startX: 10;
            startY: 100;
            PathLine {
                x: root.width/2 - 40;
                y: 100;
            }
            PathPercent { value: 0.28; }
            PathLine {
                relativeX: root.width/2 - 60;
                relativeY: 0;
            }
        }