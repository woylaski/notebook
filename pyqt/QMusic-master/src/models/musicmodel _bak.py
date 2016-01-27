#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import datetime
from peewee import *
import traceback
try:
    from dwidgets.mediatag import common
except:
    import sys
    sys.path.insert(0, os.path.join(os.path.dirname(os.getcwd()), 'dwidgets'))
    from mediatag import common

from PyQt5.QtCore import QDir, QUrl
import chardet
import copy

try:
    from config.constants import MusicDBFile
except:
    MusicDBFile = 'music.db'

db = SqliteDatabase(MusicDBFile, threadlocals=True)


class BaseModel(Model):
    class Meta:
        database = db

    @classmethod
    @db.atomic()
    def getRecord(cls, **kwargs):
        key = getattr(cls, '__key__')
        assert key in kwargs
        try:
            ret = cls.get(getattr(cls, key) == kwargs[key])
            return ret
        except DoesNotExist:
            return None

    @classmethod
    def isRecordExisted(cls, **kwargs):
        ret = cls.getRecord(**kwargs)
        if ret:
            return True
        else:
            return False

    @classmethod
    @db.atomic()
    def updateRecord(cls, **kwargs):
        key = getattr(cls, '__key__')
        assert key in kwargs
        retId = cls.update(
            **kwargs).where(getattr(cls, key) == kwargs[key]).execute()
        if retId != 0:
            return True
        else:
            return False

    @classmethod
    @db.atomic()
    def createRecord(cls, **kwargs):
        key = getattr(cls, '__key__')
        assert key in kwargs
        try:
            ret = cls.create(**kwargs)
        except IntegrityError:
            ret = None
        return ret

    @classmethod
    @db.atomic()
    def get_create_Record(cls, **kwargs):
        key = getattr(cls, '__key__')
        assert key in kwargs
        try:
            ret = cls.create(**kwargs)
        except IntegrityError:
            # print('%s is already in use' % kwargs['url'])
            retId = cls.update(
                **kwargs).where(getattr(cls, key) == kwargs[key]).execute()
            if retId != 0:
                ret = cls.get(cls.id == retId)
            else:
                ret = None
        return ret

    @classmethod
    def get_create_Records(cls, records):
        with db.transaction():
            for record in records:
                key = getattr(cls, '__key__')
                assert key in record
                try:
                    ret = cls.create(**record)
                except IntegrityError:
                    cls.update(
                        **record).where(getattr(cls, key) == record[key]).execute()


class Artist(BaseModel):
    name = CharField(default='', unique=True)
    area = CharField(default='')
    summary = CharField(default='')

    created_date = DateTimeField(default=datetime.datetime.now)

    __key__ = 'name'


class Album(BaseModel):
    name = CharField(default='', unique=True)
    artist = CharField(default='')

    created_date = DateTimeField(default=datetime.datetime.now)

    __key__ = 'name'


class Folder(BaseModel):
    name = CharField(default='', unique=True)

    created_date = DateTimeField(default=datetime.datetime.now)

    __key__ = 'name'


class Playlist(BaseModel):
    name = CharField(default='', unique=True)
    created_date = DateTimeField(default=datetime.datetime.now)

    __key__ = 'name'

    @classmethod
    def getPlaylistByName(cls, name):
        try:
            playlistRecord = cls.get(cls.name == name)
        except DoesNotExist:
            playlistRecord = None
        return playlistRecord


class Song(BaseModel):
    fartist = ForeignKeyField(Artist, related_name='songs')
    falbum = ForeignKeyField(Album, related_name='songs')
    ffolder = ForeignKeyField(Folder, related_name='songs')

    url = CharField(default='', unique=True)
    folder = CharField(default='')

    #Common attributes
    title = CharField(default='')
    artist = CharField(default='')
    album = CharField(default='')
    tracknumber = IntegerField(default=0)
    discnumber = IntegerField(default=0)
    genre = CharField(default='')
    date = CharField(default='')

    # subTitle = CharField(default='')
    # comment = CharField(default='')
    # description = CharField(default='')
    # category = CharField(default='')
    # year = IntegerField(default=0)
    # userRating = CharField(default='')
    # keywords = CharField(default='')
    # language = CharField(default='')
    # publisher = CharField(default='')
    # copyright = CharField(default='')
    # parentalRating = CharField(default='')
    # ratingOrganization = CharField(default='')

    #Media attributes
    size = IntegerField(default=0)
    mediaType = CharField(default='')
    duration = IntegerField(default=0)

    #Audio attributes
    bitrate = IntegerField(default=0)
    # audioCodec = CharField(default='')
    # averageLevel = IntegerField(default=0)
    # channelCount = IntegerField(default=0)
    # peakValue = IntegerField(default=0)
    sample_rate = IntegerField(default=0)

    #Music attributes
    # albumArtist = CharField(default='')
    # albumTitle = CharField(default='')
    # contributingArtist = CharField(default='')
    # composer = CharField(default='')
    # conductor = CharField(default='')
    # lyrics = CharField(default='')
    # mood = CharField(default='')
    # trackCount = CharField(default='')
    # coverArtUrlLarge = CharField(default='')
    cover = CharField(default='')

    #other
    created_date = DateTimeField(default=datetime.datetime.now)

    __key__ = 'url'

    TAG_KEYS = [
        'title', 'artist', 'album', 'tracknumber', 'discnumber', 'genre',
        'date'
    ]

    TAGS_KEYS_OVERRIDE = {}

    TAGS_KEYS_OVERRIDE['Musepack'] = {"tracknumber": "track", "date": "year"}

    TAGS_KEYS_OVERRIDE['MP4'] = {
        "title": "\xa9nam",
        "artist": "\xa9ART",
        "album": "\xa9alb",
        "tracknumber": "trkn",
        "discnumber": "disk",
        "genre": "\xa9gen",
        "date": "\xa9day"
    }

    TAGS_KEYS_OVERRIDE['ASF'] = {
        "title": "Title",
        "artist": "Author",
        "album": "WM/AlbumArtist",
        "tracknumber": "WM/TrackNumber",
        "discnumber": "WM/PartOfSet",
        "genre": "WM/Genre",
        "date": "WM/Year"
    }

    @classmethod
    def createLocalInstanceByUrl(self, url):
        from os.path import abspath, realpath, normpath
        url = normpath(realpath(abspath(url)))
        if Song.checkUrl(url):
            kwargs = {'url': url}
            song = Song.get_create_Record(**kwargs)
            if song:
                song.getTags()
                ret = song.save()
            return song
        else:
            return None

    @classmethod
    def checkUrl(cls, url):
        return cls.isExisted(url)

    @classmethod
    def isExisted(cls, url):
        return os.path.exists(url)

    def isLocalFile(self):
        return QUrl.fromLocalFile(self.url).isLocalFile()

    @property
    def baseName(self):
        return os.path.basename(self.url)

    @property
    def fileName(self):
        return os.path.splitext(self.baseName)[0]

    @property
    def ext(self):
        return os.path.splitext(self.baseName)[1][1:]

    def updateTagsToDB(self, **kwargs):
        for key, value in kwargs.items():
            setattr(self, key, value)
        retID = self.save()
        ret = self.saveTags()
        if retID > 0 and ret:
            return True
        else:
            return False

    def getTags(self):
        path = self.url

        TAG_KEYS = self.TAG_KEYS
        TAGS_KEYS_OVERRIDE = self.TAGS_KEYS_OVERRIDE

        setattr(self, 'size', os.path.getsize(path))

        audio = common.MutagenFile(path, common.FORMATS)

        if audio is not None:
            tag_keys_override = TAGS_KEYS_OVERRIDE.get(
                audio.__class__.__name__, None)
            for file_tag in TAG_KEYS:
                if tag_keys_override and tag_keys_override.has_key(file_tag):
                    file_tag = tag_keys_override[file_tag]
                if audio.has_key(file_tag) and audio[file_tag]:
                    value = audio[file_tag]
                    if isinstance(value, list) or isinstance(value, tuple):
                        value = value[0]
                    fix_value = common.fix_charset(value)
                    if fix_value == "[Invalid Encoding]":
                        if tag == "title":
                            fix_value = self.fileName
                        else:
                            fix_value = ""

                    setattr(self, file_tag, fix_value)

            for key in ['sample_rate', 'bitrate', 'length']:
                try:
                    if hasattr(audio.info, key):
                        if key == 'length':
                            setattr(self, 'duration', getattr(audio.info, key))
                        else:
                            setattr(self, key, getattr(audio.info, key))
                except Exception, e:
                    print e

    def saveTags(self):
        ''' Save tag information to file. '''
        if not self.isLocalFile():
            self.last_error = self.url + " " + "is not a local file"
            return False
        if not self.isExisted(self.url):
            self.last_error = self.url + " doesn't exist"
            return False
        if not os.access(self.url, os.W_OK):
            self.last_error = self.url + " doesn't have enough permission"
            return False

        TAG_KEYS = self.TAG_KEYS
        TAGS_KEYS_OVERRIDE = self.TAGS_KEYS_OVERRIDE

        try:
            audio = common.MutagenFile(self.url, common.FORMATS)
            tag_keys_override = None

            if audio is not None:
                if audio.tags is None:
                    audio.add_tags()
                tag_keys_override = TAGS_KEYS_OVERRIDE.get(
                    audio.__class__.__name__, None)

                for file_tag in TAG_KEYS:
                    if tag_keys_override and tag_keys_override.has_key(file_tag):
                        file_tag = tag_keys_override[file_tag]

                    value = getattr(self, file_tag)
                    if value:
                        try:
                            value = unicode(value)
                        except Exception, e:
                            value = value.decode('utf-8')
                        # print file_tag, value, type(value)
                        audio[file_tag] = value
                    else:
                        try:
                            del (audio[file_tag])  # TEST
                        except KeyError:
                            pass
                audio.save()
            else:
                raise "w:Song:MutagenTag:No audio found"

        except Exception, e:
            print traceback.format_exc()
            print "W: Error while writting (" + self.get("url") + ")Tracback :", e
            self.last_error = "Error while writting" + \
                ": " + self.url
            return False
        else:
            return True

    def getMp3FontCover(self):
        from common import EasyMP3
        audio = common.MutagenFile(self.url, common.FORMATS)
        ext = None
        img_data = None
        if isinstance(audio, EasyMP3):
            apics = audio.tags.getID3().getall('APIC')
            if len(apics) > 0:
                apic = apics[0]
                if apic.type == 3:
                    mine = apic.mime
                    ext = mine.split('/')[-1]
                    img_data = apic.data
        return ext, img_data

    def pprint(self):
        keys = [
            'url',
            'title',
            'artist',
            'album',
            'date',
            'genre',
            'tracknumber',
            'discnumber',
            'sample_rate',
            'bitrate',
            'duration',
            'size',
        ]

        p = {}
        for key in keys:
            if hasattr(self, key):
                if isinstance(getattr(self, key), unicode):
                    p[key] = getattr(self, key).encode('utf-8')
                else:
                    p[key] = getattr(self, key)
        ret = ''.join(['%s: %s' % (key, p[key]) for key in keys
                       if p.has_key(key)])
        return ret

    def toDict(self):
        keys = [
            'url',
            'folder',
            'title',
            'artist',
            'album',
            'date',
            'genre',
            'tracknumber',
            'discnumber',
            'sample_rate',
            'bitrate',
            'duration',
            'size',
            'cover',
        ]

        p = {}
        for key in keys:
            if hasattr(self, key):
                p[key] = getattr(self, key)
        return p


class SongPlaylist(BaseModel):
    song = ForeignKeyField(Song)
    playlist = ForeignKeyField(Playlist)

    @classmethod
    def addSongToPlaylist(cls, url, name='temporary'):

        songRecord = Song.getSongByUri(url)
        playlistRecord = Playlist.getPlaylistByName(name)

        if songRecord and playlistRecord:
            kwargs = {'song': songRecord, 'playlist': playlistRecord}
            try:
                ret = cls.get(cls.song == songRecord,
                              cls.playlist == playlistRecord)
                if ret:
                    # print('cls existed, Emit Singal')
                    pass
            except DoesNotExist:
                ret = cls.create(**kwargs)
        else:
            ret = None

        return ret

    @classmethod
    def getSongsByPlaylistName(cls, name):
        songs = []
        for song in Song.select().join(cls).join(Playlist).where(Playlist.name
                                                                 == name):
            songs.append(song.url)

        return songs

    @classmethod
    def getPlaylistsBySongUri(cls, url):
        playlists = []
        for playlist in Playlist.select().join(cls).join(Song).where(Song.url
                                                                     == url):
            playlists.append(playlist.name)
        return playlists


if __name__ == '__main__':

    class DBWorker(object):
        def __init__(self):
            super(DBWorker, self).__init__()
            db.connect()
            db.create_tables(
                [Song, Artist, Album, Folder, Playlist, SongPlaylist],
                safe=True)

    dbWorker = DBWorker()

    # basePath = '/home/djf/workspace/github/musicplayer-qml/music'
    # url = os.path.join(basePath, '1.mp3')
    # song = Song.createLocalInstanceByUrl(url)
    # # song.updateTagsToDB(**{'title': '12456789'})
    # print song, song.title
    # song = Song.createLocalInstanceByUrl(url)
    # print song
    # song = Song.createLocalInstanceByUrl(url)
    # print song
    # song = Song.createLocalInstanceByUrl(url)
    # print song

    artists = []
    for i in range(1000):
        artists.append({'name': 'val1-%s' % i})

    with db.transaction():
        # a = Song.insert(**{'url': '111'})
        # print a.sql()[0]
        # print a.__dict__
        # db.get_cursor().executemany('INSERT INTO artist(name) VALUES (?)', artists)
        # a.execute()
        # Artist.insert_many(artists).execute()

        for idx in range(0, len(artists), 500):
            Artist.insert_many(artists[idx:idx + 500]).execute()

    # con = sqlite3.connect('existing_db.db')
    # with open('dump.sql', 'w') as f:
    #     for line in db.get_conn().iterdump():
    #         f.write('%s' % line)

    # import sqlite3
    # conn = sqlite3.connect('example.db')
    # # print artists
    # c = conn.cursor()
    # c.execute('''CREATE TABLE artist (name TEXT, name1 TEXT,name2 TEXT,name3 TEXT)''')
    # c.executemany('INSERT INTO artist VALUES (?, ?, ? ,?)', artists)
    # conn.commit()
