import itertools
import random
import re
import socket

import tornado.gen
import tornado.iostream

import PyQt5.QtCore

import models.base
import models.config
import models.helpers
import models.messages


@models.helpers.pyqtProperties(hostname=(str,), port=(int,), useSsl=(bool,), encoding=(str,))
class EndPoint(models.base.Object):
	def __init__(self, endPointConfig, parent):
		super(EndPoint, self).__init__(parent)

		self._hostname = endPointConfig.hostname
		self._port = random.randint(endPointConfig.portStart, endPointConfig.portEnd)
		self._useSsl = endPointConfig.useSsl
		self._encoding = endPointConfig.encoding


@models.helpers.pyqtProperties(network=(models.config.Network,), currentEndPoint=(EndPoint, {'writeable': True, 'constant': True}), channels=(models.base.List,), currentNickname=(str, {'writeable': True}), lag=(float, {'writeable': True}))
class Server(models.base.Object):
	def __init__(self, network, parent):
		super(Server, self).__init__(parent)

		self._network = network

		self._currentEndPoint = None

		self.network.endPointsChanged.connect(self._listenForEndPointsChanges)
		self._listenForEndPointsChanges()

		self._channels = models.base.List(self)
		self._channels.registerLookupFunction('name', lambda channel: channel.name)

		self._currentNickname = None

		self._lag = 0.2

		self._stream = None

		self._receivedLine.connect(self._onReceivedLine)

	def connect(self):
		if self._stream is not None:
			self._stream.close()

		nextEndPoint = next(self._availableEndPoints)
		self.currentEndPoint = EndPoint(nextEndPoint, self)

		s = socket.socket()

		if self.currentEndPoint.useSsl:
			self._stream = tornado.iostream.SSLIOStream(s)
		else:
			self._stream = tornado.iostream.IOStream(s)

		tornado.ioloop.IOLoop.instance().add_callback(self._connect)

	@tornado.gen.coroutine
	def _connect(self):
		self.connecting.emit()
		yield tornado.gen.Task(self._stream.connect, (self.currentEndPoint.hostname, self.currentEndPoint.port))

		while True:
			try:
				data = yield tornado.gen.Task(self._stream.read_until, Server._newLineBytes)
			except tornado.iostream.StreamClosedError:
				self.disconnected.emit()
				break
			else:
				line = data[:-2].decode(encoding=self.currentEndPoint.encoding)
				self._receivedLine.emit(line)

	_newLineBytes = bytes('\r\n', 'ascii')

	def send(self, message):
		tornado.ioloop.IOLoop.instance().add_callback(self._send, message)
		self.nextMessage.emit(message)

	@tornado.gen.coroutine
	def _send(self, message):
		line = message.construct()

		if line[-2:] != '\r\n':
			line += '\r\n'

		try:
			yield tornado.gen.Task(self._stream.write, line.encode(encoding=self.currentEndPoint.encoding))
		except:
			self.disconnected.emit()

	def _listenForEndPointsChanges(self):
		self._availableEndPoints = itertools.cycle(self._network.endPoints)

	def _onReceivedLine(self, line):
		message = models.messages.ReceivedMessage.parse(line, self)
		self.nextMessage.emit(message)

		if message.messageType == models.messages.ReceivedMessageType.privmsg:
			if message['recipient'] == self.currentNickname:
				target = message.prefix
			else:
				target = message['recipient']

			channel, _ = self.channels.lookup('name', target)
			if channel is not None:
				channel.nextMessage.emit(message)

		elif message.messageType == models.messages.ReceivedMessageType.join:
			joiner = User(message.prefix, self)
			if joiner.nickname == self.currentNickname:
				self.channels.append(Channel(message['channel'], self, self))
				self.send(models.messages.SentMessage(models.messages.SentMessageType.who, self, channel=message['channel']))
			else:
				channel, _ = self.channels.lookup('name', message['channel'])
				channel.users.append(User(message.prefix, channel.users))

		elif message.messageType == models.messages.ReceivedMessageType.part:
			channel, _ = self.channels.lookup('name', message['channel'])
			if message.prefix == self.currentNickname:
				self.channels.remove(channel)
			else:
				_, parterIndex = channel.users.lookup('nickname', User(message.prefix, self).nickname)
				channel.users.removeAt(parterIndex)

		elif message.messageType == models.messages.ReceivedMessageType.ping:
			self.send(models.messages.SentMessage(models.messages.SentMessageType.pong, self, identifier=message['identifier']))

		elif message.messageType == models.messages.ReceivedMessageType.rpl_welcome:
			self.currentNickname = message['nickname']

		elif message.messageType == models.messages.ReceivedMessageType.rpl_topic:
			channel, _ = self.channels.lookup('name', message['channel'])
			channel.topic = message['topic']

		elif message.messageType == models.messages.ReceivedMessageType.rpl_namreply:
			channel, _ = self.channels.lookup('name', message['channel'])
			users = message['users'].split(' ')
			for user in users:
				channel.users.append(User(user, channel.users))

		elif message.messageType == models.messages.ReceivedMessageType.rpl_whoreply or message.messageType == models.messages.ReceivedMessageType.rpl_whospcrpl:
			channel, _ = self.channels.lookup('name', message['channel'])
			user, _ = channel.users.lookup('nickname', message['nickname'])
			user.username = message['username']
			user.hostname = message['hostname']
			user.realname = message['realname']

		return None

	connecting = PyQt5.QtCore.pyqtSignal()
	nextMessage = PyQt5.QtCore.pyqtSignal(models.messages.Message)
	disconnected = PyQt5.QtCore.pyqtSignal()

	_receivedLine = PyQt5.QtCore.pyqtSignal(str)


@models.helpers.pyqtProperties(name=(str, {'constant': True}), server=(Server, {'constant': True}), topic=(str, {'writeable': True}), users=(models.base.List,), modes=(models.base.List,))
class Channel(models.base.Object):
	def __init__(self, name, server, parent):
		super(Channel, self).__init__(parent)

		self._name = name
		self._server = server
		self._topic = ''
		self._users = models.base.List(self, sortFunction=lambda user: user.sortOrder())
		self._users.registerLookupFunction('nickname', lambda user: user.nickname)
		self._modes = models.base.List(self)

	nextMessage = PyQt5.QtCore.pyqtSignal(models.messages.Message)


@models.helpers.pyqtProperties(key=(str,), value=(str,))
class Mode(models.base.Object):
	def __init__(self, key, value, parent):
		super(Mode, self).__init__(parent)

		self._key = key
		self._value = value

@models.helpers.pyqtProperties(nickname=(str,), symbol=(str,), username=(str, {'writeable': True}), hostname=(str, {'writeable': True}), realname=(str, {'writeable': True}), modes=(models.base.List,))
class User(models.base.Object):
	def __init__(self, identifier, parent):
		super(User, self).__init__(parent)

		match = re.match(r'([~&@%\+]?)([^!]+)(?:!([^@]+)@(.+))?$', identifier)

		self._nickname = match.group(2)
		self._symbol = match.group(1)
		self._modes = models.base.List(self)

		self._username = match.group(3) or ''
		self._hostname = match.group(4) or ''
		self._realname = ''

	def sortOrder(self):
		return (('~', '&', '@', '%', '+', '').index(self.symbol), self.nickname)
