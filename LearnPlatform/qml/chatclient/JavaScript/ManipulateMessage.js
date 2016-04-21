//枚举消息类型
var MessageType = {
	NewParticipant: "0",        //新用户上线
	Reply: "1",                 //回复新用户
	NewMessage: "2",            //消息
	FileName: "3",              //传送文件名
	Refuse: "4",                //拒绝接收文件
	ParticipantLeft: "5"        //用户下线
}

//处理接收的消息[类型 + ip + userName + chatContent]
function processMessage(message) {
	//接收消息
	var type = message[0]
	var userIp = message[1]
	var userName = message[2]
	var chatContent = message[3]
	var time = message[4]

	//分类处理消息
	switch (type) {
	case MessageType.NewParticipant:                                //新上线用户
		id_userList.addUserToOnlineList(userName, userIp)           //将新上线用户添加到 ListView 列表
		onlineNotifyP2P(1, "", userIp)                              //并给新用户一个回馈
		break
	case MessageType.Reply:
		id_userList.addUserToOnlineList(userName, userIp)
		break
	case MessageType.NewMessage:
		id_containerLeft.showMessage(userName, chatContent, time)   //聊天消息（群聊）
		break
	case MessageType.FileName:
																	//传送文件
		break
	case MessageType.Refuse:
																	//拒绝接收
		break
	case MessageType.ParticipantLeft:
		id_userList.userLeft(userIp, userName)                      //下线
		break
	default:
		break
	}
}