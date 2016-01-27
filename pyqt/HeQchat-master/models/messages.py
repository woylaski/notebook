import re

import PyQt5.QtCore

import models.helpers


@models.helpers.pyqtProperties(prefix=(str, {'constant': True}), parameters=(dict, {'constant': True}))
class Message(models.base.Object):
	def __init__(self, prefix, parent):
		super(Message, self).__init__(parent)

		self._prefix = prefix
		self._parameters = {}

	def __getitem__(self, key):
		return self.parameters.get(key)

	def __setitem__(self, key, value):
		self.parameters[key] = value


class UnhandledMessageTypeException(Exception):
	def __init__(self, messageType):
		super().__init__(self, 'Message type {0} was recognized but not handled.'.format(messageType))


@models.helpers.enum
class ReceivedMessageType:
	unknown = None
	notice = None
	error = None
	privmsg = None
	join = None
	part = None
	quit = None
	mode = None
	ping = None
	rpl_welcome = '001'
	rpl_yourhost = '002'
	rpl_created = '003'
	rpl_myinfo = '004'
	rpl_luserclient = '251'
	rpl_luserop = '252'
	rpl_luserunknown = '253'
	rpl_luserchannels = '254'
	rpl_luserme = '255'
	rpl_topic = '332'
	rpl_whoreply = '352'
	rpl_namreply = '353'
	rpl_whospcrpl = '354'
	rpl_endofnames = '366'
	rpl_motd = '372'
	rpl_motdstart = '375'
	rpl_endofmotd = '376'
	cap = None
	authenticate = None


@models.helpers.pyqtProperties(messageType=(str, {'constant': True}))
class ReceivedMessage(Message):
	def __init__(self, messageType, prefix, parent):
		super(ReceivedMessage, self).__init__(prefix, parent)

		self._messageType = messageType

	def __repr__(self):
		return '{0} => <{1}> {2}'.format(self._messageType, self.prefix, ', '.join(('{0}: {1}'.format(key, value) for key, value in self.parameters.items())))

	@staticmethod
	def parse(line, parent):
		prefix, command, parameters = ReceivedMessage._tokenize(line)

		try:
			messageType = ReceivedMessageType(command)
		except KeyError:
			messageType = ReceivedMessageType.unknown

		receivedMessage = ReceivedMessage(messageType, prefix, parent)

		if messageType == ReceivedMessageType.unknown:
			receivedMessage['content'] = ', '.join(('[{0}]'.format(parameter) for parameter in parameters))

		elif messageType == ReceivedMessageType.notice:
			receivedMessage['parameter'] = parameters[0]
			receivedMessage['content'] = parameters[1]

		elif messageType == ReceivedMessageType.error:
			receivedMessage['message'] = parameters[0]

		elif messageType == ReceivedMessageType.privmsg:
			receivedMessage['recipient'] = parameters[0]
			receivedMessage['message'] = parameters[1]

		elif messageType == ReceivedMessageType.join:
			receivedMessage['channel'] = parameters[0]

		elif messageType == ReceivedMessageType.part:
			receivedMessage['channel'] = parameters[0]
			receivedMessage['message'] = parameters[1] if len(parameters) > 1 else ''

		elif messageType == ReceivedMessageType.quit:
			receivedMessage['message'] = parameters[0]

		elif messageType == ReceivedMessageType.mode:
			receivedMessage['user'] = parameters[0]
			receivedMessage['mode'] = parameters[1]

		elif messageType == ReceivedMessageType.ping:
			receivedMessage['server'] = parameters[0]
			receivedMessage['identifier'] = parameters[1] if len(parameters) > 1 else ''

		elif messageType == ReceivedMessageType.rpl_welcome:
			receivedMessage['nickname'] = parameters[0]
			match = re.match(r'Welcome to the ([\w\s]*?) {0}$'.format(parameters[0]), parameters[1])
			receivedMessage['serverName'] = match.group(1)

		elif messageType == ReceivedMessageType.rpl_yourhost:
			match = re.match(r'Your host is ([^\]]*)(?:\[([^\]]*)\])?, running version (.*)$', parameters[1])
			receivedMessage['serverName'] = match.group(1)
			receivedMessage['serverPort'] = match.group(2) or ''
			receivedMessage['serverSoftware'] = match.group(3)

		elif messageType == ReceivedMessageType.rpl_created:
			match = re.match(r'This server was created (.*)$', parameters[1])
			receivedMessage['created'] = match.group(1)

		elif messageType == ReceivedMessageType.rpl_myinfo:
			receivedMessage['serverName'] = parameters[1]
			receivedMessage['serverSoftware'] = parameters[2]

		elif messageType == ReceivedMessageType.rpl_luserclient:
			match = re.match(r'There are (\d*) users and (\d*) invisible on (\d*) servers$', parameters[1])
			receivedMessage['users'] = match.group(1)
			receivedMessage['invisible'] = match.group(2)
			receivedMessage['servers'] = match.group(3)

		elif messageType == ReceivedMessageType.rpl_luserop:
			receivedMessage['numberOfOperators'] = parameters[1]

		elif messageType == ReceivedMessageType.rpl_luserunknown:
			receivedMessage['unknownConnections'] = parameters[1]

		elif messageType == ReceivedMessageType.rpl_luserchannels:
			receivedMessage['numberOfChannels'] = parameters[1]

		elif messageType == ReceivedMessageType.rpl_luserme:
			match = re.match(r'I have (\d*) clients and (\d*) servers$', parameters[1])
			receivedMessage['numberOfClients'] = match.group(1)
			receivedMessage['numberOfServers'] = match.group(2)

		elif messageType == ReceivedMessageType.rpl_topic:
			receivedMessage['channel'] = parameters[1]
			receivedMessage['topic'] = parameters[2]

		elif messageType == ReceivedMessageType.rpl_whoreply:
			receivedMessage['channel'] = parameters[1]
			receivedMessage['nickname'] = parameters[5]
			receivedMessage['username'] = parameters[2]
			receivedMessage['hostname'] = parameters[3]
			receivedMessage['realname'] = parameters[7][parameters[7].index(' ') + 1:]

		elif messageType == ReceivedMessageType.rpl_namreply:
			receivedMessage['channel'] = parameters[2]
			receivedMessage['users'] = parameters[3]

		elif messageType == ReceivedMessageType.rpl_whospcrpl:
			receivedMessage['channel'] = parameters[1]
			receivedMessage['nickname'] = parameters[5]
			receivedMessage['username'] = parameters[2]
			receivedMessage['hostname'] = parameters[3]
			receivedMessage['server'] = parameters[4]
			receivedMessage['realname'] = parameters[8]

		elif messageType == ReceivedMessageType.rpl_endofnames:
			pass

		elif messageType == ReceivedMessageType.rpl_motd:
			receivedMessage['message'] = parameters[1]

		elif messageType == ReceivedMessageType.rpl_motdstart:
			pass

		elif messageType == ReceivedMessageType.rpl_endofmotd:
			pass

		elif messageType == ReceivedMessageType.cap:
			if parameters[1] == 'LS':
				receivedMessage['operation'] = "LS"
				receivedMessage['capabilities'] = parameters[2]
			elif parameters[1] == 'ACK':
				receivedMessage['operation'] = "ACK"
				receivedMessage['capabilities'] = parameters[2]

		elif messageType == ReceivedMessageType.authenticate:
			pass

		else:
			raise UnhandledMessageTypeException(messageType)

		return receivedMessage

	@staticmethod
	def _tokenize(line):
		currentPos = 0
		length = len(line)

		def readWord():
			nonlocal currentPos

			if currentPos >= length:
				return None

			readTill = line.find(' ', currentPos)
			if readTill == -1:
				readTill = length
			result = line[currentPos:readTill]
			currentPos = readTill + 1
			return result

		def readToEnd():
			nonlocal currentPos

			if currentPos >= length:
				return None

			result = line[currentPos:]
			currentPos = length
			return result

		prefix = None
		if line[0:1] == ':':
			prefix = readWord()[1:]

		command = readWord()

		parameters = []
		while currentPos < length:
			if line[currentPos] == ':':
				parameters.append(readToEnd()[1:])
			else:
				parameters.append(readWord())

		return (prefix, command, parameters)


@models.helpers.enum
class SentMessageType:
	nick = None
	user = None
	join = None
	quit = None
	pong = None
	privmsg = None
	notice = None
	cap = None
	authenticate = None
	identify = None
	who = None


@models.helpers.pyqtProperties(messageType=(str, {'constant': True}))
class SentMessage(Message):
	def __init__(self, messageType, parent, **parameters):
		super(SentMessage, self).__init__('', parent)

		self._messageType = messageType

		if parameters is not None:
			for key, value in parameters.items():
				self.parameters[key] = value

	def __repr__(self):
		return '{0} => {1}'.format(self._messageType, ', '.join(('{0}: {1}'.format(key, value) for key, value in self.parameters.items())))

	def construct(self):
		if self.messageType == SentMessageType.nick:
			return 'NICK {0}'.format(self['nickname'])

		elif self.messageType == SentMessageType.user:
			return 'USER {0} host server :{1}'.format(self['username'], self['realname'])

		elif self.messageType == SentMessageType.join:
			if self['key'] == '':
				return 'JOIN {0}'.format(self['channel'])
			else:
				return 'JOIN {0} {1}'.format(self['channel'], self['key'])

		elif self.messageType == SentMessageType.quit:
			return 'QUIT :{0}'.format(self['message'])

		elif self.messageType == SentMessageType.pong:
			if self['identifier'] == '':
				return 'PONG {0}'.format(self['server'])
			else:
				return 'PONG {0} :{1}'.format(self['server'], self['identifier'])

		elif self.messageType == SentMessageType.privmsg:
			return 'PRIVMSG {0} :{1}'.format(self['recipient'], self['message'])

		elif self.messageType == SentMessageType.notice:
			return 'NOTICE {0} :{1}'.format(self['recipient'], self['message'])

		elif self.messageType == SentMessageType.cap:
			return 'CAP {0}'.format(self['parameters'])

		elif self.messageType == SentMessageType.authenticate:
			return 'AUTHENTICATE {0}'.format(self['parameters'])

		elif self.messageType == SentMessageType.identify:
			return 'NICKSERV IDENTIFY {0}'.format(self['password'])

		elif self.messageType == SentMessageType.who:
			return 'WHO {0}'.format(self['channel'])
			# return 'WHO {0} %chtsunfra,152'.format(self['channel'])

		else:
			raise UnhandledMessageTypeException(self.messageType)
