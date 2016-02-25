// Qt5.4
// 先导入QtQuick模块，后导入QtQml.StateMachine模块
import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQml.StateMachine 1.0

Item {
    width: 400
    height: 200

    Row {
        anchors.centerIn: parent
        spacing: 10

        Button {
            id: startButton
            text: "start"
            onClicked: {
                // 启动状态机
                if (!stateMachine.running) {
                    stateMachine.running = true
                }
            }
        }
        Button {
            id: button
            // 状态机标识
            text: s11.active ? "s11" : s12.active ? "s12" : s13.active ? "s13" : "state"
        }
        Button {
            id: historyButton
            // 历史状态记录
            text: stateMachine.running ? s1.active ? "interrupt" : "resume" : "history"
        }
        Button {
            id: quitButton
            text: "quit"
        }
    }

    StateMachine {
        id: stateMachine
        initialState: s1 // 初始状态
        // running: true // running属性由button（startButton）设置

        State {
            id: s1
            initialState: s11 // 初始状态

            SignalTransition {
                targetState: s3 // 根据signal切换state
                signal: historyButton.clicked
            }
            SignalTransition {
                targetState: s2 // 根据signal切换state
                signal: quitButton.clicked
            }
            onEntered: console.log("s1 entered")
            onExited: console.log("s1 exited")

            State {
               id: s11
               SignalTransition {
                   targetState: s12 // 根据signal切换state
                   signal: button.clicked
               }
               onEntered: console.log("s11 entered")
               onExited: console.log("s11 exited")
            }
            State {
               id: s12
               SignalTransition { // 根据signal切换state
                   targetState: s13
                   signal: button.clicked
               }
               SignalTransition { // override父state的signal（quitButton.clicked）
                   signal: quitButton.clicked
                   onTriggered: console.log("override - quitButton clicked")
               }
               onEntered: console.log("s12 entered")
               onExited: console.log("s12 exited")
            }
            State {
                id: s13
                SignalTransition { // 根据signal切换state
                    targetState: s11
                    signal: button.clicked
                }
                TimeoutTransition { // 根据定时器切换state
                    targetState: s2
                    timeout: 2000
                }
                onEntered: console.log("s13 entered")
                onExited: console.log("s13 exited")
            }
            HistoryState { // 历史状态
                id: history
            }
        }

        State {
            id: s3
            SignalTransition { // 根据signal切换state
                targetState: history
                signal: historyButton.clicked
            }
            onEntered: console.log("s3 entered")
            onExited: console.log("s3 exited")
        }

        FinalState {
            id: s2
        }
        onFinished: console.log("state finished")
    }
}