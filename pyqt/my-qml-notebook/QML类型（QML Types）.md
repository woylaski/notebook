可视类型 (visual types)
Item — QML 基本的试图类型，其他可视类型都是从Item继承来的
Rectangle — 矩形区域
Image — 图片
BorderImage — 边框背景
AnimatedImage — 播放一张GIF图片
AnimatedSprite — 播放一系列帧动画 2
SpriteSequence — 播放一系列帧动画中的部分帧 2
Text — 显示文本
Window — 显示一个顶层窗口 2
可视的实用功能项 (Visual Item Utility)
Accessible — 提供Component的获取性 2
Gradient — 渐变
GradientStop — 渐变阈值
SystemPalette — 系统调色板
Screen — 获取设备的屏幕宽高横向参数 2
Sprite — 显示特定的Sprite动画 2
FontLoader — 字体加载器
可视项的生成器 (Visual Item Generation)
Repeater — 能够根据model生成多个可视化的项
Loader — QML component动态加载器
可视项的变换 (Visual Item Transformations)
Transform — 变形 2
Scale — 缩放
Rotation — 旋转
Translate — 平移
获取用户输入 (User Input)
MouseArea — 鼠标区域
Keys — 按键
KeyNavigation — 导航键 2
FocusScope — 焦点区域
Flickable — 橡皮筋区域
PinchArea — 捏拽区域
MultiPointTouchArea — 多点触控区域 2
Drag –拖动区域 2
DropArea — 掉落区域 2
TextInput — 文本输入区域
TextEdit — 文本编辑区域
文本输入的实用工具项 (Text Input Utility)
IntValidator — 整数校验器
DoubleValidator — 双精度浮点校验器
RegExpValidator — 正则表达式校验器
用户输入事件 (User input events)
TouchPoint — 触摸点击事件 2
PinchEvent — 捏拽事件
WheelEvent — 鼠标滚轮事件 2
MouseEvent — 鼠标点击事件
KeyEvent — 按键事件
DragEvent — 拖动事件 2
位置 (Positioning)
Positioner — Item在scene中的位置信息（附带属性） 2
Column — 子对象竖直方向排列
Row — 子对象水平方向排列
Grid — 子对象按照网格形式排列
Flow — 流动
LayoutMirroring — 布局镜像（附带属性） 2
状态 (States)
State — 状态
PropertyChanges — 属性变更
StateGroup — 状态组
StateChangeScript — 状态变更脚本
ParentChange — 父对象变更
AnchorChanges — 锚点变更
转变和动画 (Transitions and Animations)
Transition — 转变动画
ViewTransition — 视图转变 2
SequentialAnimation — 串行动画序列
ParallelAnimation — 并行动画序列
Behavior — 特定属性变化时的行为
PropertyAction — 在动画序列中执行属性变更动作
SmoothedAnimation — 属性值平滑变化动画
SpringAnimation — 弹力动画
ScriptAction — 在动画序列中执行脚本（主要用于动画中执行脚本）
与类型相关的动画 (Type-specific Animations)
PropertyAnimation — 属性动画
NumberAniamtion — 数值动画
Vector3dAnimation — Vector3d属性的动画
ColorAnimation — color属性的动画
RotationAnimation — rotation属性的动画
ParentAnimation — parent属性动画
AnchorAnimation — anchor属性动画
PathAnimation — path动画 2
底层动画 (Lower-level Animation Types)
PathInterpolator — path修改器 2
AnimationController — 动画控制器 2
路径动画 (Animation paths)
Path — 路径
PathLine — 路径为直线
PathQuad — 路径为二次方程式贝尔曲线
PathCubic — 路径为三次方程式贝尔曲线
PathArc — 路径为弧线 2
PathCurve — 路径为曲线 2
PathSvg — SVG 路径 2
PathAttribute — 在path中设置属性
PathPercent — 修改path中item的间距
数据模型 (Model and Model Data)
ListModel
ListElement
VisualItemModel
VisualDataModel
VisualDataGroup
XmlListModel
XmlRole
视图 (Views)
ListView
GridView
PathView
Pack age
数据存储 (Data Storage)
QtQuick.LocalStorage 2 — 本地存储模块 2
图形效果 (Graphical Effects)
Flipable
ShaderEffect 2
ShaderEffectSource
GridMesh 2
QtQuick.Particles 2 2
实用方便的类型 (Convenience Types)
Connections
Binding — 绑定器
Timer — 定时器
WorkScript
画布 (Canvas)
Canvas 2
Context2D 2
CanvasGradient 2
CanvasPixelArray 2
CanvasImageData 2
TextMetrics 2