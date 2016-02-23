import QtQuick 2.5
import QtQuick.Window 2.2

/*
PropertyChange指定了属性的变化，一般是指定当前的Item的某个属性的变化，例如
PropertyChanges{target:main;scale:1.0}
通过这句话指定main对象的scale（比例）为1.0，通过target来绑定需要更改的对象，然后后面直接用<属性：属性值>这种方式就可以完成属性的更改。

为了方便起见,State元素都有一个when属性，可以绑定表达式来改变状态，当绑定的表达式评估为true。
当表达式评估为false，状态会退回到default state

状态变化会引起值的突然变化。Transition属性允许这变化在状态变化期间会更平滑。
在transitions中,动画和插值行为是可定义的。Animation and Transitions文章中有更详细的信息关于创建状态动画
*/

Rectangle{
	id: rec
	width: 640
	height: 480
	visible: true

	state: "normal"

	states: [
		State{
			name: "normal"
			PropertyChanges {
				target: rec; 
				color:"white"
			}
		},

		State{
			name: "circle"
			PropertyChanges {
				target: rec; 
				color:"red"
			}

			PropertyChanges {
				target: rec; 
				width:300
			}
		}
	]

	MouseArea {
		anchors.fill: parent

		onClicked: {
			console.log("clicked")
			if(rec.state=="normal")
				rec.state="circle"
			else
				rec.state="normal"
		}
	}
}