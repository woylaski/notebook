#ifndef SHAREDOBJECT_H
#define SHAREDOBJECT_H

#include <QObject>
#include <QVariant>
#include <QString>
#include <QList>
#include <QHash>
#include <QUrl>
#include <QDir>
#include <QFileSystemWatcher>

#include <QQmlObjectListModel>
#include <QQmlHelpers>

QML_ENUM_CLASS (ChordKey, Unknown = -1, A, Bb, B, C, Db, D, Eb, E, F, Gb, G, Ab)

QML_ENUM_CLASS (ChordVariant, Major, Minor, Sus2, Sus4, Dim, Aug)

QML_ENUM_CLASS (ChordExtra, None, Dom6th, Dom7th, Dom8th)

class ChordItem : public QObject {
    Q_OBJECT
    QML_WRITABLE_PROPERTY (int, position)
    QML_WRITABLE_PROPERTY (int, type)
    QML_WRITABLE_PROPERTY (int, variant)
    QML_WRITABLE_PROPERTY (int, extra)
    QML_READONLY_PROPERTY (QString, notation)

public:
    explicit ChordItem (QObject * parent = NULL);

    Q_INVOKABLE void transposeLow  (void);
    Q_INVOKABLE void transposeHigh (void);
};

class LineItem : public QObject {
    Q_OBJECT
    QML_WRITABLE_PROPERTY (QString, lyrics)
    QML_OBJMODEL_PROPERTY (ChordItem, modelChords)

public:
    explicit LineItem (QObject * parent = NULL);

    Q_INVOKABLE ChordItem * addNewChord (int position);

    Q_INVOKABLE void moveChordLeft  (ChordItem * chordItem);
    Q_INVOKABLE void moveChordRight (ChordItem * chordItem);
    Q_INVOKABLE void removeChord    (ChordItem * chordItem);
    Q_INVOKABLE void transposeLow   (void);
    Q_INVOKABLE void transposeHigh  (void);
};

class GroupItem : public QObject {
    Q_OBJECT
    QML_WRITABLE_PROPERTY (QString, group)
    QML_OBJMODEL_PROPERTY (LineItem, modelLines)

public:
    explicit GroupItem (QObject * parent = NULL);

    Q_INVOKABLE LineItem * addNewLine (int position);

    Q_INVOKABLE void moveLineUp    (LineItem * lineItem);
    Q_INVOKABLE void moveLineDown  (LineItem * lineItem);
    Q_INVOKABLE void duplicateLine (LineItem * lineItem);
    Q_INVOKABLE void removeLine    (LineItem * lineItem);
    Q_INVOKABLE void transposeLow   (void);
    Q_INVOKABLE void transposeHigh  (void);
};

class SongItem : public QObject {
    Q_OBJECT
    QML_WRITABLE_PROPERTY (QString, title)
    QML_OBJMODEL_PROPERTY (GroupItem, modelGroups)

public:
    explicit SongItem (QObject * parent = NULL);

    Q_INVOKABLE GroupItem * addNewGroup (int position);

    Q_INVOKABLE void    moveGroupUp    (GroupItem * groupItem);
    Q_INVOKABLE void    moveGroupDown  (GroupItem * groupItem);
    Q_INVOKABLE void    duplicateGroup (GroupItem * groupItem);
    Q_INVOKABLE void    removeGroup    (GroupItem * groupItem);
    Q_INVOKABLE void    transposeLow   (void);
    Q_INVOKABLE void    transposeHigh  (void);
    Q_INVOKABLE void    importFromJson (QString json);
    Q_INVOKABLE QString exportToJson   (void);
};

class FileItem : public QObject {
    Q_OBJECT
    QML_READONLY_PROPERTY (QString, fileName)

public:
    explicit FileItem (QObject * parent = NULL);
};

class SharedObject : public QObject {
    Q_OBJECT
    QML_READONLY_PROPERTY (SongItem *, currentSongItem)
    QML_CONSTANT_PROPERTY (QString, basePath)
    QML_OBJMODEL_PROPERTY (FileItem, modelFiles)

public:
    explicit SharedObject (QObject * parent = NULL);

    Q_INVOKABLE QString getChordNotation (int type, int variant, int extra, bool useNamedNotes = false);
    Q_INVOKABLE QString readTextFile     (QUrl fileUrl);
    Q_INVOKABLE void    writeTextFile    (QUrl fileUrl, const QString & content);

protected slots:
    void onDirChanged (const QString & path);

private:
    QFileSystemWatcher * m_watcher;
};

#endif // SHAREDOBJECT_H
