#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys
import copy
import json
import re
import time
import traceback
from PyQt5.QtCore import (QObject, pyqtSignal, pyqtSlot, pyqtProperty,
                          QThreadPool, QRunnable, QTimer)
from PyQt5.QtGui import QImage
import requests
from log import logger
from .utils import registerContext, contexts
from dwidgets import dthread, LevelJsonDict
from collections import OrderedDict
from config.constants import LevevDBPath
from dwidgets import DListModel, ModelMetaclass
from dwidgets.mediatag.song import Song as SongDict
from .signalmanager import signalManager
from .onlinemuscimanageworker import OnlineMusicManageWorker
from dwidgets import dthread


class DownloadSongObject(QObject):

    __metaclass__ = ModelMetaclass

    __Fields__ = (
        ('url', 'QString'), ('ext', 'QString'), ('bitrate', 'QString'),
        ('hdDesc', 'QString'), ('size', int, 0), ('songId', int),
        ('name', 'QString'), ('singerName', 'QString'), ('singerId', int),
        ('albumId', int), ('albumName', 'QString'),
        ('originalServiceEngName', 'QString'), ('serviceEngName', 'QString'),
        ('serviceName', 'QString'), ('downloadUrl', 'QString'),
        ('progress', int), ('downloading', bool, False))

    downloadFinished = pyqtSignal(bool)
    downloadStoped = pyqtSignal(int)
    progressUpdated = pyqtSignal(float)
    sizeUpdated = pyqtSignal(int)

    deleteSelf = pyqtSignal(int)
    updateDBPoperty = pyqtSignal(int, 'QString', 'QVariant')
    addSongToDB = pyqtSignal('QString')

    fieldsUpdated = pyqtSignal(dict)

    def initialize(self, *agrs, **kwargs):
        self.setDict(kwargs)
        self.start_size = 0
        self.stopDownloaded = False
        self.isFinished = False
        self.isConnected = False
        self.filename = DownloadSongWorker.getSongPath(self.singerName,
                                                       self.name, self.ext)
        self.temp_filename = '%s.tmp' % self.filename

        self.speedTimer = QTimer()
        self.speedTimer.setInterval(100)
        self.speedTimer.timeout.connect(self.calSpeed)
        self.initConnect()

    def initConnect(self):
        self.sizeUpdated.connect(self.updateSize)
        self.progressUpdated.connect(self.updatePorgress)
        self.downloadFinished.connect(self.setFinished)
        self.fieldsUpdated.connect(self.updateFields)

    def updateSize(self, size):
        self.size = size
        self.updateDBPoperty.emit(self.songId, 'size', size)

    def updatePorgress(self, progress):
        self.progress = progress
        if progress >= self.progress:
            self.updateDBPoperty.emit(self.songId, 'progress', progress)

    def setFinished(self, finished):
        self.isFinished = finished
        if os.path.exists(self.temp_filename):
            os.rename(self.temp_filename, self.filename)
            self.saveTags()
        self.deleteSelf.emit(self.songId)

    def updateFields(self, result):
        self.singerId = result['singerId']
        self.albumId = result['albumId']
        self.albumName = result['albumName']
        if self.isFinished:
            if os.path.exists(self.temp_filename):
                os.rename(self.temp_filename, self.filename)
                self.saveTags()

    def saveTags(self):
        if not self.stopDownloaded:
            song = SongDict(self.filename)
            song.artist = self.singerName
            song.title = self.name
            song.album = self.albumName
            song.size = os.path.getsize(self.filename)
            song.saveTags()
            self.addSongToDB.emit(self.filename)
            # signalManager.switchOnlinetoLocal.emit(
            #     Web360ApiWorker.getUrlByID(self.songId), self.filename)

    def startDownLoad(self):
        if os.path.exists(self.filename):
            with open(self.filename, 'r') as f:
                self.start_size = self.getCurrentSize()
        self.getMusicInfo(self.songId)
        d = DownLoadRunnable(self)
        DownloadSongWorker.threadPool.start(d)
        self.downloading = True
        self.updateDBPoperty.emit(self.songId, 'downloading', True)

    def stopDownload(self):
        self.stopDownloaded = True
        self.downloading = False
        self.updateDBPoperty.emit(self.songId, 'downloading', False)

    def calSpeed(self):
        if self.isFinished:
            self.speedTimer.stop()
        currentSize = self.getCurrentSize()
        if currentSize is not None and self.start_size is not None:
            if currentSize > self.start_size:
                speed = (currentSize - self.start_size) / 1024
                self.start_size = currentSize
                print '', currentSize, self.start_size, '%s KB/s' % speed

    def getCurrentSize(self):
        if os.path.exists(self.filename):
            with open(self.filename, 'r') as f:
                size = len(f.read())
            return size
        else:
            return None

    @dthread
    def getMusicInfo(self, musicId):
        print(musicId)


class DownloadSongListModel(DListModel):

    __contextName__ = 'DownloadSongListModel'

    @registerContext
    def __init__(self, dataTye):
        super(DownloadSongListModel, self).__init__(dataTye)


class DownLoadRunnable(QRunnable):
    def __init__(self, songObj):
        super(DownLoadRunnable, self).__init__()
        self.block = 1024
        self.total = 0
        self.size = 0
        self.songObj = songObj
        self.filename = songObj.filename
        self.url = songObj.downloadUrl

        self.tryCount = 0

    def run(self):
        self.download(self.url, self.filename)

    def touch(self, filename):
        with open(filename, 'w') as fin:
            pass

    def remove_nonchars(self, name):
        (name, _) = re.subn(ur'[\\\/\:\*\?\"\<\>\|]', '', name)
        return name

    def support_continue(self, url):
        '''
            check support continue download or not
        '''
        headers = {'Range': 'bytes=0-4'}
        try:
            r = requests.head(url, headers=headers)
            if 'content-range' in r.headers:
                crange = r.headers['content-range']
                self.total = int(re.match(ur'^bytes 0-4/(\d+)$', crange).group(1))
                self.songObj.sizeUpdated.emit(self.total)
                return True
            else:
                self.total = 0
                return False
        except:
            logger.error(traceback.print_exc())
        try:
            self.total = int(r.headers['content-length'])
            self.songObj.sizeUpdated.emit(self.total)
        except:
            logger.error(traceback.print_exc())
            self.total = 0
        return False

    def download(self, url, filename, headers={}):
        self.tryCount += 1
        self.songObj.isFinished = False
        block = self.block
        temp_filename = self.songObj.temp_filename

        isSupportContinued = self.support_continue(url)
        if isSupportContinued:
            try:
                if os.path.exists(temp_filename):
                    with open(temp_filename, 'rb') as fin:
                        self.size = len(fin.read())
                else:
                    self.touch(temp_filename)
                    self.size = 0
            except:
                logger.error(traceback.print_exc())
            finally:
                headers['Range'] = "bytes=%d-" % (self.size, )
        else:
            self.touch(temp_filename)
            self.size = 0

        total = self.total
        size = self.size
        r = requests.get(url, stream=True, verify=False, headers=headers)

        if 'content-length' in r.headers:
            self.total = int(r.headers['content-length'])
        else:
            if self.tryCount < 5:
                self.download(url, filename)
                return

        start_t = time.time()
        with open(temp_filename, 'ab+') as f:
            f.seek(len(f.read()))
            f.truncate()
            try:
                for chunk in r.iter_content(chunk_size=block):
                    if self.songObj.stopDownloaded:
                        self.songObj.downloadStoped.emit(self.songObj.songId)
                        break
                    if chunk:
                        f.write(chunk)
                        size += len(chunk)
                        f.flush()
                        if total > 0:
                            self.progress = (float(size) / float(total)) * 100
                            self.songObj.progressUpdated.emit(self.progress)
                        if size == self.total:
                            self.songObj.downloadFinished.emit(True)
                    else:
                        break
                if not self.songObj.stopDownloaded:
                    self.songObj.downloadFinished.emit(True)
            except:
                logger.error(traceback.print_exc())


class DownloadSongWorker(QObject):

    __contextName__ = "DownloadSongWorker"

    _songsDict = LevelJsonDict(os.path.join(LevevDBPath, 'downloadSong'))

    _songObjs = OrderedDict()

    _downloadSongListModel = DownloadSongListModel(DownloadSongObject)

    allStartDownloadSignal = pyqtSignal()
    allPausedSignal = pyqtSignal()

    oneStartDownloadSignal = pyqtSignal(int)
    onePausedDownloadSignal = pyqtSignal(int)

    addDownloadSongToDataBase = pyqtSignal('QString')

    threadPool = QThreadPool()

    @registerContext
    def __init__(self, parent=None):
        super(DownloadSongWorker, self).__init__(parent)
        self._songsDict.open()
        self.threadPool.setMaxThreadCount(4)
        self.loadDB()
        self.initConnect()
        self.downloadObjs = {}

    def loadDB(self):
        if 'index' not in self._songsDict:
            self._songsDict['index'] = []
        else:
            keys = self._songsDict['index']
            for musicId in keys:
                if musicId in self._songsDict:
                    songDict = self._songsDict[musicId]
                    self.downloadSong(songDict, isDownloadNow=False)

    def initConnect(self):
        self.allStartDownloadSignal.connect(self.startDownloadAll)
        self.allPausedSignal.connect(self.pausedAll)

        self.oneStartDownloadSignal.connect(self.startDownloadBySongId)
        self.onePausedDownloadSignal.connect(self.pauseDownloadBySongId)

    def songObjConnect(self, songObj):
        if not songObj.isConnected:
            songObj.deleteSelf.connect(self.delSongObj)
            songObj.updateDBPoperty.connect(self.updateModel)
            songObj.downloadStoped.connect(self.removeFormDownloadList)
            songObj.addSongToDB.connect(self.addDownloadSongToDataBase)
            songObj.isConnected = True

    def songObjDisConnect(self, songObj):
        if songObj.isConnected:
            songObj.deleteSelf.disconnect(self.delSongObj)
            songObj.updateDBPoperty.disconnect(self.updateModel)
            songObj.downloadStoped.disconnect(self.removeFormDownloadList)
            songObj.addSongToDB.disconnect(self.addDownloadSongToDataBase)
            songObj.isConnected = False

    def startDownloadAll(self):
        for musicId, songObj in self._songObjs.items():
            songObj.stopDownloaded = False
            self.addSongObjToDownloadList(songObj)

    def pausedAll(self):
        for musicId, songObj in self.downloadObjs.items():
            songObj.stopDownload()
        flag = self.threadPool.waitForDone(1000)

        for songId, songObj in self.downloadObjs.items():
            self.songObjDisConnect(songObj)
        self.downloadObjs.clear()

    def startDownloadBySongId(self, songId):
        for _songId, songObj in self._songObjs.items():
            if songId == _songId:
                songObj.stopDownloaded = False
                self.addSongObjToDownloadList(songObj)
                break

    def pauseDownloadBySongId(self, songId):
        for _songId, songObj in self._songObjs.items():
            if songId == _songId:
                songObj.stopDownload()
                break

    def downloadSong(self, songDict, isDownloadNow=True):
        songId = songDict['songId']

        singerName = songDict['singerName']
        name = songDict['name']
        ext = songDict['ext']

        if self.isSongExisted(singerName, name, ext):
            logger.info('%s %s %s exists' % (singerName, name, ext))
            return
        if songId in self._songObjs:
            logger.info('%s %s %s %s has existed in download list' %
                        (songId, singerName, name, ext))
            return
        if isinstance(songDict['size'], unicode):
            if songDict['size']:
                songDict['size'] = float(songDict['size'][:-1]) * 1024 * 1024
            else:
                songDict['size'] = 0

        songDict['downloading'] = False

        songObj = DownloadSongObject(**songDict)
        self.songObjConnect(songObj)

        if isDownloadNow:
            self.addSongObjToDownloadList(songObj)

        self._songObjs[songId] = songObj
        self._songsDict[songId] = songDict
        self._downloadSongListModel.append(songObj)

        keys = self._songsDict['index']
        if songId not in keys:
            keys.append(songId)
            self._songsDict['index'] = keys

    def delSongObj(self, songId):
        if songId in self._songObjs:
            songObj = self._songObjs[songId]
            self.songObjDisConnect(songObj)
            del self._songObjs[songId]

        if songId in self._songsDict:
            del self._songsDict[songId]
            keys = self._songsDict['index']
            if songId in keys:
                keys.remove(songId)
                self._songsDict['index'] = keys

        for index, songObj in enumerate(self._downloadSongListModel.data):
            if songObj.songId == songId:
                self._downloadSongListModel.remove(index)

        if songId in self.downloadObjs:
            del self.downloadObjs[songId]
            for songId, songObj in self._songObjs.items():
                if songObj.songId not in self.downloadObjs:
                    self.addSongObjToDownloadList(songObj)
                    break

    def removeFormDownloadList(self, songId):
        if songId in self._songObjs:
            songObj = self._songObjs[songId]
            self.songObjDisConnect(songObj)

        if songId in self.downloadObjs:
            del self.downloadObjs[songId]
            # for songId, songObj in self._songObjs.items():
            #     if songObj.songId not in self.downloadObjs:
            #         self.addSongObjToDownloadList(songObj)
            #         break

    def addSongObjToDownloadList(self, songObj):
        if songObj.songId not in self.downloadObjs:
            self.downloadObjs[songObj.songId] = songObj
            self.songObjConnect(songObj)
            songObj.startDownLoad()
        else:
            self.songObjConnect(songObj)
            songObj.startDownLoad()

    def updateModel(self, songId, key, value):
        if songId in self._songsDict:
            songDict = self._songsDict[songId]
            songDict[key] = value
            self._songsDict[songId] = songDict
        for index, songObj in enumerate(self._downloadSongListModel.data):
            if songObj.songId == songId:
                self._downloadSongListModel.setProperty(index, key, value)

    @classmethod
    def getSongPath(cls, singerName, name, ext):
        configWorker = contexts['ConfigWorker']
        downloadSongPath = configWorker.DownloadSongPath
        return os.path.join(downloadSongPath, '%s-%s.%s' %
                            (singerName, name, ext))

    @classmethod
    def isSongExisted(cls, artist, title, ext):
        return os.path.exists(cls.getSongPath(artist, title, ext))

    @pyqtSlot('QString', 'QString', result=bool)
    def isOnlineSongExisted(self, artist, title):
        from dwidgets.mediatag.common import TRUST_AUDIO_EXT
        for ext in TRUST_AUDIO_EXT:
            if os.path.exists(self.getSongPath(artist, title, ext)):
                return True
        return False

    @classmethod
    def isLocalSongExisted(cls, artist, title):
        from dwidgets.mediatag.common import TRUST_AUDIO_EXT
        for ext in TRUST_AUDIO_EXT:
            path = cls.getSongPath(artist, title, ext)
            if os.path.exists(path):
                return True, path
        return False, ''

    @pyqtSlot('QString', 'QString', result='QString')
    def getDownloadSongByKey(self, artist, title):
        from dwidgets.mediatag.common import TRUST_AUDIO_EXT
        for ext in TRUST_AUDIO_EXT:
            path = self.getSongPath(artist, title, ext)
            if os.path.exists(path):
                return path
        return ''


downloadSongWorker = DownloadSongWorker()

if __name__ == '__main__':
    from PyQt5.QtGui import QGuiApplication
    app = QGuiApplication(sys.argv)
    url = "http://360.media.duomi.com/dm//duomial/L201YV83NS8wNi8wNC8zNzg1MTY0Ml82OTY3LTEyMzAwNDAx.m4a?type=0&pos=1&uid="

    song = Song('liudehua', 'ai ni yi wan nian', url)
    downloadWorker = DownloadSongWorker()
    song.startDownLoad()
    exitCode = app.exec_()
    sys.exit(exitCode)
