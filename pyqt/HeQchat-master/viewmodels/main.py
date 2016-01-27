import threading

import tornado.ioloop

import PyQt5.QtCore

import models.base
import models.helpers
import models.network

import viewmodels.tabs

@models.helpers.pyqtProperties(tabs=(models.base.List,))
class Main(models.base.Object):
	def __init__(self, parent):
		super(Main, self).__init__(parent)

		self._tabs = models.base.List(self)

		# If this is a local "app" instead of a member "self._app", PyQt is unable to quit with the message
		# "QObject::startTimer: Timers can only be used with threads started with QThread"
		self._app = PyQt5.QtCore.QCoreApplication.instance()

		self._app.aboutToQuit.connect(lambda: self._quit())

		self._ioLoop = None
		self._ioLoopStarted.connect(self._onIoLoopStarted)

		# Create Tornado IO loop and start it in the ioloop thread
		self._ioLoopThread = threading.Thread(target=self._startIOLoop)
		self._ioLoopThread.start()

	def _quit(self):
		if self._ioLoop is not None:
			self._ioLoop.add_callback(lambda: self._stopIoLoop())

		self._ioLoopThread.join()

	def _onJoinChannel(self, parent, start, end):
		channels = self.sender()

		for i in range(start, end + 1):
			self.tabs.append(viewmodels.tabs.ChannelTab(channels.get(i), self.tabs))

	def _onPartChannel(self, parent, start, end):
		server = self.sender()

		for i in range(start, end + 1):
			for j, tab in enumerate(self.tabs):
				if tab.channel == server.channels.get(i):
					self.tabs.removeAt(j)

	def _startIOLoop(self):
		ioLoop = tornado.ioloop.IOLoop.instance()
		ioLoop.add_callback(lambda: self._ioLoopStarted.emit())
		ioLoop.start()

	def _onIoLoopStarted(self):
		self._ioLoop = tornado.ioloop.IOLoop.instance()

		config = models.config.Config(self)

		for network in config.networks:
			if network.autoJoin:
				server = models.network.Server(network, self)

				self.tabs.append(viewmodels.tabs.ServerTab(server, self.tabs))

				server.channels.rowsInserted.connect(self._onJoinChannel)
				server.channels.rowsAboutToBeRemoved.connect(self._onPartChannel)

				server.connect()

	def _stopIoLoop(self):
		self._ioLoop.stop()

	_ioLoopStarted = PyQt5.QtCore.pyqtSignal()
