import datetime
import threading

import models.helpers
import models.messages
import models.network


@models.helpers.pyqtProperties(name=(str,))
class Tab(models.base.Object):
	def __init__(self, name, parent):
		super(Tab, self).__init__(parent)

		self._name = name


@models.helpers.pyqtProperties(server=(models.network.Server,), messages=(models.base.List,))
class ServerTab(Tab):
	def __init__(self, server, parent):
		super(ServerTab, self).__init__(server.network.name, parent)

		self._server = server
		self._messages = models.base.List(self)

		self.server.connecting.connect(self._onConnecting)

		self.server.nextMessage.connect(self._logMessages)

		self.server.disconnected.connect(lambda: self.server.connect())

	def _onConnecting(self):
		line = 'Connecting to {0}:{1}'.format(self.server.currentEndPoint.hostname, self.server.currentEndPoint.port)
		print('[{0}] {1} --- {2}'.format(datetime.datetime.now().strftime('%x %X'), self.server.network.name, line))

		self.server.nextMessage.connect(self._identify)
		self.server.nextMessage.connect(self._joinChannels)

	def _logMessages(self, message):
		print('[{0}] {1} {2} {3}'.format(datetime.datetime.now().strftime('%x %X'), self.server.network.name, '>>>' if isinstance(message, models.messages.ReceivedMessage) else '<<<', str(message)))
		self.messages.append(message)

	def _identify(self, message):
		self.server.nextMessage.disconnect(self._identify)

		self.server.send(models.messages.SentMessage(models.messages.SentMessageType.nick, self, nickname='heQchat'))
		self.server.send(models.messages.SentMessage(models.messages.SentMessageType.user, self, username='Arnavion3', realname='Arnavion Dash'))

	def _joinChannels(self, message):
		if message.messageType == models.messages.ReceivedMessageType.rpl_welcome:
			self.server.nextMessage.disconnect(self._joinChannels)

			for autoJoinChannel in self.server.network.autoJoinChannels:
				self.server.send(models.messages.SentMessage(models.messages.SentMessageType.join, self, channel=autoJoinChannel.name, key=autoJoinChannel.key))


@models.helpers.pyqtProperties(channel=(models.network.Channel,), messages=(models.base.List,), numOps=(int,))
class ChannelTab(Tab):
	def __init__(self, channel, parent):
		super(ChannelTab, self).__init__(channel.name, parent)

		self._channel = channel
		self._messages = models.base.List(self)

		self.channel.nextMessage.connect(self._logMessages)

	def numOps(self):
		result = 0

		for user in self.channel.users:
			for mode in user.modes:
				if mode.key == "+o":
					result += 1
					break

		return result

	def _logMessages(self, message):
		self.messages.append(message)
