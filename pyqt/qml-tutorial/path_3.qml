/*
PathArc 路径元素定义一条弧线，它的起点为上一个路径元素的终点（或者路径的起点），终点由 x 、 y 或 relativeX 、 relativeY 定义。弧线的半径由 radiusX 、 radiusY 定义。
    direction 属性定义绘制弧线的方向，默认取值 PathArc.Clockwise ，顺时针绘制弧线；要想逆时针绘制弧线，设置 direction 的值为 PathArc.Counterclockwise 。
    当你制定了弧线的起点、终点、半径、绘制方向后，还是可能存在两条弧线都能满足给定的参数，此时 useLargeArc 属性就可以派上用场了，其默认值为 false ，取较小的弧线，设置为 true 后，取较大的弧线。下图是存在两条弧线的一种情形示例

*/

Path{
	StartX: 0
	StartY: 100
	PathArc{
		x: 100
		y: 200
		radiusX: 100
		radiusY: 100
		direction: PathArc.Clockwise
	}

}