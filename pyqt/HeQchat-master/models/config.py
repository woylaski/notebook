import os

import PyQt5.QtCore

import models.base
import models.helpers


@models.helpers.pyqtProperties(name=(str,), endPoints=(models.base.List,), autoJoin=(bool,), autoJoinChannels=(models.base.List,))
class Network(models.base.Object):
	def __init__(self, name, autoJoin, parent):
		super(Network, self).__init__(parent)

		self._name = name

		self._endPoints = models.base.List(self)

		self._autoJoin = autoJoin

		self._autoJoinChannels = models.base.List(self)

	@staticmethod
	def clone(other, parent):
		network = Network(other.name, other.autoJoin, parent)

		for otherEndPoint in otherNetwork.endPoints:
			network.endPoints.append(EndPoint.clone(otherEndPoint, network.endPoints))

		for otherAutoJoinChannel in otherNetwork.autoJoinChannels:
			network.autoJoinChannels.append(AutoJoinChannel.clone(otherAutoJoinChannel, network.autoJoinChannels))

		return network

	@staticmethod
	def readSettings(networkGroup, networkSettings, parent):
		networkSettings.beginGroup(networkGroup)

		try:
			network = Network(networkGroup, networkSettings.value('AutoJoin') == 'true', parent)

			networkSettings.beginGroup('EndPoints')

			try:
				for endPointGroup in networkSettings.childGroups():
					try:
						endPoint = EndPoint.readSettings(endPointGroup, networkSettings, network.endPoints)

					except:
						pass

					else:
						network.endPoints.append(endPoint)

			finally:
				networkSettings.endGroup()

			networkSettings.beginGroup('AutoJoinChannels')

			try:
				for autoJoinChannelGroup in networkSettings.childGroups():
					try:
						autoJoinChannel = AutoJoinChannel.readSettings(autoJoinChannelGroup, networkSettings, network.autoJoinChannels)

					except:
						pass

					else:
						network.autoJoinChannels.append(autoJoinChannel)

			finally:
				networkSettings.endGroup()

			return network

		finally:
			networkSettings.endGroup()

	def writeSettings(self, networkSettings):
		networkSettings.beginGroup(self.name)

		try:
			networkSettings.setValue('AutoJoin', self.autoJoin)

			networkSettings.beginGroup('EndPoints')

			try:
				for index, endPoint in enumerate(self.endPoints):
					endPoint.writeSettings(str(index), networkSettings)

			finally:
				networkSettings.endGroup()

			networkSettings.beginGroup('AutoJoinChannels')

			try:
				for index, autoJoinChannel in enumerate(self.autoJoinChannels):
					networkSettings.beginGroup(str(index))
					networkSettings.setValue('Name', autoJoinChannel.name)
					networkSettings.setValue('Key', autoJoinChannel.key)
					networkSettings.endGroup()

			finally:
				networkSettings.endGroup()

		finally:
			networkSettings.endGroup()


@models.helpers.pyqtProperties(hostname=(str,), portStart=(int,), portEnd=(int,), useSsl=(bool,), encoding=(str,))
class EndPoint(models.base.Object):
	def __init__(self, hostname, portStart, portEnd, useSsl, encoding, parent):
		super(EndPoint, self).__init__(parent)

		self._hostname = hostname
		self._portStart = portStart
		self._portEnd = portEnd
		self._useSsl = useSsl
		self._encoding = encoding

	@staticmethod
	def clone(otherEndPoint, parent):
		return EndPoint(otherEndPoint.hostname, otherEndPoint.portStart, otherEndPoint.portEnd, otherEndPoint.useSsl, otherEndPoint.encoding, parent)

	@staticmethod
	def readSettings(endPointGroup, networkSettings, parent):
		networkSettings.beginGroup(endPointGroup)

		try:
			endPoint = EndPoint(networkSettings.value('HostName'), int(networkSettings.value('PortStart')), int(networkSettings.value('PortEnd')), networkSettings.value('UseSsl') == 'true', networkSettings.value('Encoding'), parent)
			return endPoint

		finally:
			networkSettings.endGroup()

	def writeSettings(self, endPointGroup, networkSettings):
		networkSettings.beginGroup(endPointGroup)

		try:
			networkSettings.setValue('Hostname', self.hostname)
			networkSettings.setValue('PortStart', self.portStart)
			networkSettings.setValue('PortEnd', self.portEnd)
			networkSettings.setValue('UseSsl', self.useSsl)
			networkSettings.setValue('Encoding', self.encoding)

		finally:
			networkSettings.endGroup()


@models.helpers.pyqtProperties(name=(str,), key=(str,))
class AutoJoinChannel(models.base.Object):
	def __init__(self, name, key, parent):
		super(AutoJoinChannel, self).__init__(parent)

		self._name = name

		self._key = key

	@staticmethod
	def clone(otherAutoJoinChannel, parent):
		return AutoJoinChannel(otherAutoJoinChannel.name, otherAutoJoinChannel.key, parent)

	@staticmethod
	def readSettings(autoJoinChannelGroup, networkSettings, parent):
		networkSettings.beginGroup(autoJoinChannelGroup)

		try:
			autoJoinChannel = AutoJoinChannel(networkSettings.value('Name'), networkSettings.value('Key'), parent)
			return autoJoinChannel

		finally:
			networkSettings.endGroup()

	def writeSettings(self, autoJoinChannelGroup, networkSettings):
		networkSettings.beginGroup(autoJoinChannelGroup)

		try:
			networkSettings.setValue('Name', self.name)
			networkSettings.setValue('Key', self.key)

		finally:
			networkSettings.endGroup()


@models.helpers.pyqtProperties(networks=(models.base.List,))
class Config(models.base.Object):
	def __init__(self, parent):
		super(Config, self).__init__(parent)

		self._networks = models.base.List(self)

		self._loadNetworksConfig()

		self._save()

	def _loadNetworksConfig(self):
		self._networkSettings = PyQt5.QtCore.QSettings(PyQt5.QtCore.QSettings.IniFormat, PyQt5.QtCore.QSettings.UserScope, 'HeQchat', 'networks')

		self._networkSettings.setIniCodec('UTF-8')
		self._networkSettings.setFallbacksEnabled(False)

		if os.path.isfile(self._networkSettings.fileName()):
			for networkGroup in self._networkSettings.childGroups():
				try:
					network = Network.readSettings(networkGroup, self._networkSettings, self.networks)
				except:
					pass
				else:
					self.networks.append(network)

		else:
			for defaultNetwork in _defaultConfig.networks:
				self.networks.append(Network.clone(defaultNetwork, self.networks))

	def _save(self):
		self._networkSettings.clear()

		for network in self.networks:
			network.writeSettings(self._networkSettings)

		self._networkSettings.sync()

def _initializeDefaultConfig():
	defaultConfig = Config(None)

	network = Network('FreeNode', False, defaultConfig.networks)
	defaultConfig.networks.append(network)

	network.endPoints.append(EndPoint('chat.freenode.net', 6697, 6697, True, 'utf-8', network.endPoints))
	network.endPoints.append(EndPoint('chat.freenode.net', 7000, 7000, True, 'utf-8', network.endPoints))
	network.endPoints.append(EndPoint('chat.freenode.net', 7070, 7070, True, 'utf-8', network.endPoints))
	network.endPoints.append(EndPoint('chat.freenode.net', 6666, 6667, False, 'utf-8', network.endPoints))
	network.endPoints.append(EndPoint('chat.freenode.net', 8000, 8002, False, 'utf-8', network.endPoints))

	network.autoJoinChannels.append(AutoJoinChannel('#hexchat', '', network.autoJoinChannels))

	network = Network('Rizon', True, defaultConfig.networks)
	defaultConfig.networks.append(network)

	network.endPoints.append(EndPoint('irc.rizon.net', 6697, 6697, True, 'utf-8', network.endPoints))
	network.endPoints.append(EndPoint('irc.rizon.net', 9999, 9999, True, 'utf-8', network.endPoints))
	network.endPoints.append(EndPoint('irc.rizon.net', 6660, 6670, False, 'utf-8', network.endPoints))
	network.endPoints.append(EndPoint('irc.rizon.net', 7000, 7000, False, 'utf-8', network.endPoints))

	network.autoJoinChannels.append(AutoJoinChannel('#arnavion-heqchat', 'himitsu', network.autoJoinChannels))

	return defaultConfig

_defaultConfig = _initializeDefaultConfig()
