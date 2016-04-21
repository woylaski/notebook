//ö����Ϣ����
var MessageType = {
	NewParticipant: "0",        //���û�����
	Reply: "1",                 //�ظ����û�
	NewMessage: "2",            //��Ϣ
	FileName: "3",              //�����ļ���
	Refuse: "4",                //�ܾ������ļ�
	ParticipantLeft: "5"        //�û�����
}

//������յ���Ϣ[���� + ip + userName + chatContent]
function processMessage(message) {
	//������Ϣ
	var type = message[0]
	var userIp = message[1]
	var userName = message[2]
	var chatContent = message[3]
	var time = message[4]

	//���ദ����Ϣ
	switch (type) {
	case MessageType.NewParticipant:                                //�������û�
		id_userList.addUserToOnlineList(userName, userIp)           //���������û���ӵ� ListView �б�
		onlineNotifyP2P(1, "", userIp)                              //�������û�һ������
		break
	case MessageType.Reply:
		id_userList.addUserToOnlineList(userName, userIp)
		break
	case MessageType.NewMessage:
		id_containerLeft.showMessage(userName, chatContent, time)   //������Ϣ��Ⱥ�ģ�
		break
	case MessageType.FileName:
																	//�����ļ�
		break
	case MessageType.Refuse:
																	//�ܾ�����
		break
	case MessageType.ParticipantLeft:
		id_userList.userLeft(userIp, userName)                      //����
		break
	default:
		break
	}
}