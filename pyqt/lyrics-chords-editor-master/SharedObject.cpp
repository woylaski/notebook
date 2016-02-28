
#include "SharedObject.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QJsonParseError>
#include <QFile>
#include <QStringBuilder>

/******************** SHARED *************************/

SharedObject::SharedObject (QObject * parent)
    : QObject (parent)
{
    m_basePath = (QDir::homePath () % "/Lyrics&Chords");
    QDir dirBase (m_basePath);
    if (!dirBase.exists ()) {
        QDir ().mkpath (m_basePath);
    }

    m_modelFiles = new QQmlObjectListModel<FileItem> (this);

    m_watcher = new QFileSystemWatcher (this);
    m_watcher->addPath (m_basePath);
    connect (m_watcher, &QFileSystemWatcher::directoryChanged, this, &SharedObject::onDirChanged);
    onDirChanged ("");

    m_currentSongItem = new SongItem (this);

    /*
#define USE_SAMPLE_RESOURCE
#ifndef USE_SAMPLE_RESOURCE
    m_currentSongItem->set_title ("Hello - Lionel Ritchie");

    GroupItem * groupItem1 = new GroupItem;
    groupItem1->set_group ("Chorus");
    m_currentSongItem->get_modelGroups ()->append (groupItem1);

    LineItem * lineItem1 = new LineItem;
    lineItem1->set_lyrics ("Hello !");
    groupItem1->get_modelLines ()->append (lineItem1);

    LineItem * lineItem2 = new LineItem;
    lineItem2->set_lyrics ("Is it me you're looking for ?");
    groupItem1->get_modelLines ()->append (lineItem2);

    ChordItem * chordItem1 = new ChordItem;
    chordItem1->set_position (4);
    chordItem1->set_type (ChordKey::A);
    chordItem1->set_variant (ChordVariant::Minor);
    lineItem1->get_modelChords ()->append (chordItem1);

    ChordItem * chordItem2 = new ChordItem;
    chordItem2->set_position (9);
    chordItem2->set_type (ChordKey::F);
    lineItem2->get_modelChords ()->append (chordItem2);

    ChordItem * chordItem3 = new ChordItem;
    chordItem3->set_position (24);
    chordItem3->set_type (ChordKey::E);
    chordItem3->set_variant (ChordExtra::Dom7th);
    lineItem2->get_modelChords ()->append (chordItem3);
#else
    QFile res (":/hello_lionel.ritchie.json");
    if (res.open (QFile::ReadOnly | QFile::Text | QFile::Unbuffered)) {
        m_currentSongItem->importFromJson (QString::fromUtf8 (res.readAll ()));
        res.close ();
    }
#endif
    */
}

QString SharedObject::getChordNotation (int type, int variant, int extra, bool useNamedNotes) {
    QString ret = "";
    switch ((ChordKey::Type) type) {
        case ChordKey::A:
            ret.append (useNamedNotes ? "La" : "A");
            break;
        case ChordKey::Bb:
            ret.append (useNamedNotes ? "Sib" : "Bb");
            break;
        case ChordKey::B:
            ret.append (useNamedNotes ? "Si" : "B");
            break;
        case ChordKey::C:
            ret.append (useNamedNotes ? "Do" : "C");
            break;
        case ChordKey::Db:
            ret.append (useNamedNotes ? "Do#" : "C#");
            break;
        case ChordKey::D:
            ret.append (useNamedNotes ? "Ré" : "D");
            break;
        case ChordKey::Eb:
            ret.append (useNamedNotes ? "Mib" : "Eb");
            break;
        case ChordKey::E:
            ret.append (useNamedNotes ? "Mi" : "E");
            break;
        case ChordKey::F:
            ret.append (useNamedNotes ? "Fa" : "F");
            break;
        case ChordKey::Gb:
            ret.append (useNamedNotes ? "Fa#" : "F#");
            break;
        case ChordKey::G:
            ret.append (useNamedNotes ? "Sol" : "G");
            break;
        case ChordKey::Ab:
            ret.append (useNamedNotes ? "Lab" : "Ab");
            break;
        default:
            ret.append ("?");
            break;
    }
    if (type > ChordKey::Unknown) {
        switch ((ChordExtra::Type) extra) {
            case ChordExtra::Dom6th:
                ret.append ("6");
                break;
            case ChordExtra::Dom7th:
                ret.append ("7");
                break;
            case ChordExtra::Dom8th:
                ret.append ("8");
                break;
            default:
                break;
        }
        switch ((ChordVariant::Type) variant) {
            case ChordVariant::Minor:
                ret.append ("m");
                break;
            case ChordVariant::Sus2:
                ret.append ("sus2");
                break;
            case ChordVariant::Sus4:
                ret.append ("sus4");
                break;
            case ChordVariant::Dim:
                ret.append ("dim");
                break;
            case ChordVariant::Aug:
                ret.append ("aug");
                break;
            case ChordVariant::Major:
            default:
                break;
        }
    }
    return ret;
}

QString SharedObject::readTextFile (QUrl fileUrl) {
    QString ret;
    if (fileUrl.isLocalFile ()) {
        QFile file (fileUrl.toLocalFile ());
        if (file.open (QFile::ReadOnly | QFile::Text | QFile::Unbuffered)) {
            QByteArray buffer = file.readAll ();
            ret = QString::fromUtf8 (buffer);
            file.close ();
        }
    }
    return ret;
}

void SharedObject::writeTextFile (QUrl fileUrl, const QString & content) {
    if (fileUrl.isLocalFile ()) {
        QFile file (fileUrl.toLocalFile ());
        if (file.open (QFile::WriteOnly | QFile::Text | QFile::Truncate | QFile::Unbuffered)) {
            QByteArray buffer = content.toUtf8 ();
            file.write (buffer);
            file.flush ();
            file.close ();
        }
    }
}

void SharedObject::onDirChanged (const QString & path) {
    Q_UNUSED (path)
    // TODO : use incremental atomic changes to model
    m_modelFiles->clear ();
    QStringList list = QDir (m_basePath).entryList (QDir::NoDotAndDotDot | QDir::Files);
    foreach (QString file, list) {
        FileItem * item = new FileItem;
        item->update_fileName (file.remove (m_basePath).remove (".json"));
        m_modelFiles->append (item);
    }
}

/******************** CHORD *************************/

ChordItem::ChordItem (QObject * parent)
    : QObject (parent)
    , m_position (0)
    , m_type (ChordKey::Unknown)
    , m_variant (ChordVariant::Major)
    , m_extra (ChordExtra::None)
{

}

void ChordItem::transposeLow (void) {
    set_type (m_type > ChordKey::A ? m_type -1 : ChordKey::Ab);
}

void ChordItem::transposeHigh (void) {
    set_type (m_type < ChordKey::Ab ? m_type +1 : ChordKey::A);
}

/******************** LYRICS LINE *************************/

LineItem::LineItem (QObject * parent)
    : QObject (parent)
    , m_lyrics ("[new line]")
{
    m_modelChords = new QQmlObjectListModel<ChordItem> (this);
}

ChordItem * LineItem::addNewChord (int position) {
    ChordItem * chordItem = new ChordItem;
    chordItem->set_position (position);
    m_modelChords->append (chordItem);
    return chordItem;
}

void LineItem::moveChordLeft (ChordItem * chordItem) {
    if (chordItem && m_modelChords->contains (chordItem)) {
        int pos = chordItem->get_position ();
        if (pos > 0) {
            chordItem->set_position (pos -1);
        }
    }
}

void LineItem::moveChordRight (ChordItem * chordItem) {
    if (chordItem && m_modelChords->contains (chordItem)) {
        int pos = chordItem->get_position ();
        if (pos < m_lyrics.size () -1) {
            chordItem->set_position (pos +1);
        }
    }
}

void LineItem::removeChord (ChordItem * chordItem) {
    if (chordItem && m_modelChords->contains (chordItem)) {
        m_modelChords->remove (chordItem);
    }
}

void LineItem::transposeLow (void) {
    foreach (ChordItem * chordItem, m_modelChords->toList ()) {
        if (chordItem) {
            chordItem->transposeLow ();
        }
    }
}

void LineItem::transposeHigh (void) {
    foreach (ChordItem * chordItem, m_modelChords->toList ()) {
        if (chordItem) {
            chordItem->transposeHigh ();
        }
    }
}

/******************** LINE GROUP *************************/

GroupItem::GroupItem (QObject * parent)
    : QObject (parent)
    , m_group ("[new group]")
{
    m_modelLines = new QQmlObjectListModel<LineItem> (this);
}

LineItem * GroupItem::addNewLine (int position) {
    LineItem * lineItem = new LineItem;
    m_modelLines->insert (position, lineItem);
    return lineItem;
}

void GroupItem::moveLineUp (LineItem * lineItem) {
    if (lineItem && m_modelLines->contains (lineItem)) {
        int pos = m_modelLines->indexOf (lineItem);
        if (pos > 0) {
            m_modelLines->move (pos, pos -1);
        }
    }
}

void GroupItem::moveLineDown (LineItem * lineItem) {
    if (lineItem && m_modelLines->contains (lineItem)) {
        int pos = m_modelLines->indexOf (lineItem);
        if (pos < m_modelLines->count () -1) {
            m_modelLines->move (pos, pos +1);
        }
    }
}

void GroupItem::duplicateLine (LineItem * lineItem) {
    if (lineItem && m_modelLines->contains (lineItem)) {
        int pos = m_modelLines->indexOf (lineItem);
        LineItem * lineClone = new LineItem;
        lineClone->set_lyrics (lineItem->get_lyrics ());
        foreach (ChordItem * chordItem, lineItem->get_modelChords ()->toList ()) {
            ChordItem * chordClone = new ChordItem;
            chordClone->set_position (chordItem->get_position ());
            chordClone->set_type (chordItem->get_type ());
            chordClone->set_variant (chordItem->get_variant ());
            chordClone->set_extra (chordItem->get_extra ());
            lineClone->get_modelChords ()->append (chordClone);
        }
        m_modelLines->insert (pos +1, lineClone);
    }
}

void GroupItem::removeLine (LineItem * lineItem) {
    if (lineItem && m_modelLines->contains (lineItem)) {
        m_modelLines->remove (lineItem);
    }
}

void GroupItem::transposeLow (void) {
    foreach (LineItem * lineItem, m_modelLines->toList ()) {
        if (lineItem) {
            lineItem->transposeLow ();
        }
    }
}

void GroupItem::transposeHigh (void) {
    foreach (LineItem * lineItem, m_modelLines->toList ()) {
        if (lineItem) {
            lineItem->transposeHigh ();
        }
    }
}

/******************** SONG *************************/

SongItem::SongItem (QObject * parent)
    : QObject (parent)
    , m_title ("[new untitled song]")
{
    m_modelGroups = new QQmlObjectListModel<GroupItem> (this);
}

GroupItem * SongItem::addNewGroup (int position) {
    GroupItem * groupItem = new GroupItem;
    m_modelGroups->insert (position, groupItem);
    return groupItem;
}

void SongItem::moveGroupUp (GroupItem * groupItem) {
    if (groupItem && m_modelGroups->contains (groupItem)) {
        int pos = m_modelGroups->indexOf (groupItem);
        if (pos > 0) {
            m_modelGroups->move (pos, pos -1);
        }
    }
}

void SongItem::moveGroupDown (GroupItem * groupItem) {
    if (groupItem && m_modelGroups->contains (groupItem)) {
        int pos = m_modelGroups->indexOf (groupItem);
        if (pos < m_modelGroups->count () -1) {
            m_modelGroups->move (pos, pos +1);
        }
    }
}

void SongItem::duplicateGroup (GroupItem * groupItem) {
    if (groupItem && m_modelGroups->contains (groupItem)) {
        int pos = m_modelGroups->indexOf (groupItem);
        GroupItem * groupClone = new GroupItem;
        groupClone->set_group (groupItem->get_group ());
        foreach (LineItem * lineItem, groupItem->get_modelLines ()->toList ()) {
            LineItem * lineClone = new LineItem;
            lineClone->set_lyrics (lineItem->get_lyrics ());
            foreach (ChordItem * chordItem, lineItem->get_modelChords ()->toList ()) {
                ChordItem * chordClone = new ChordItem;
                chordClone->set_position (chordItem->get_position ());
                chordClone->set_type (chordItem->get_type ());
                chordClone->set_variant (chordItem->get_variant ());
                chordClone->set_extra (chordItem->get_extra ());
                lineClone->get_modelChords ()->append (chordClone);
            }
            groupClone->get_modelLines ()->append (lineClone);
        }
        m_modelGroups->insert (pos +1, groupClone);
    }
}

void SongItem::removeGroup (GroupItem * groupItem) {
    if (groupItem && m_modelGroups->contains (groupItem)) {
        m_modelGroups->remove (groupItem);
    }
}

void SongItem::transposeLow (void) {
    foreach (GroupItem * groupItem, m_modelGroups->toList ()) {
        if (groupItem) {
            groupItem->transposeLow ();
        }
    }
}

void SongItem::transposeHigh (void) {
    foreach (GroupItem * groupItem, m_modelGroups->toList ()) {
        if (groupItem) {
            groupItem->transposeHigh ();
        }
    }
}

void SongItem::importFromJson (QString json) {
    m_modelGroups->clear ();
    set_title ("");
    QJsonParseError result;
    QJsonDocument doc = QJsonDocument::fromJson (json.toUtf8 (), &result);
    if (result.error == QJsonParseError::NoError) {
        QJsonObject rootObj = doc.object ();
        if (!rootObj.isEmpty ()) {
            set_title (rootObj.value ("title").toString ("[untitled song]"));
            QJsonArray groupsList = rootObj.value ("groups").toArray ();
            foreach (QJsonValue group, groupsList) {
                QJsonObject groupObj = group.toObject ();
                if (!groupObj.isEmpty ()) {
                    GroupItem * groupItem = new GroupItem;
                    groupItem->set_group (groupObj.value ("group").toString ("[untitled group]"));
                    QJsonArray linesList = groupObj.value ("lines").toArray ();
                    foreach (QJsonValue line, linesList) {
                        QJsonObject lineObj = line.toObject ();
                        if (!lineObj.isEmpty ()) {
                            LineItem * lineItem = new LineItem;
                            lineItem->set_lyrics (lineObj.value ("lyrics").toString ("[empty line]"));
                            QJsonArray chordsList = lineObj.value ("chords").toArray ();
                            foreach (QJsonValue chord, chordsList) {
                                QJsonObject chordObj = chord.toObject ();
                                if (!chordObj.isEmpty ()) {
                                    ChordItem * chordItem = new ChordItem;
                                    chordItem->set_position (chordObj.value ("position").toInt (0));
                                    chordItem->set_type (chordObj.value ("type").toInt (ChordKey::Unknown));
                                    chordItem->set_variant (chordObj.value ("variant").toInt (ChordVariant::Major));
                                    chordItem->set_extra (chordObj.value ("extra").toInt (ChordExtra::None));
                                    lineItem->get_modelChords ()->append (chordItem);
                                }
                            }
                            groupItem->get_modelLines ()->append (lineItem);
                        }
                    }
                    m_modelGroups->append (groupItem);
                }
            }
        }
    }
}

QString SongItem::exportToJson (void) {
    QVariantMap songEntry;
    songEntry.insert ("title", m_title);
    QVariantList groupsList;
    foreach (GroupItem * groupItem, m_modelGroups->toList ()) {
        if (groupItem) {
            QVariantMap groupEntry;
            groupEntry.insert ("group", groupItem->get_group ());
            QVariantList linesList;
            foreach (LineItem * lineItem, groupItem->get_modelLines ()->toList ()) {
                if (lineItem) {
                    QVariantMap lineEntry;
                    lineEntry.insert ("lyrics", lineItem->get_lyrics ());
                    QVariantList chordsList;
                    foreach (ChordItem * chordItem, lineItem->get_modelChords ()->toList ()) {
                        if (chordItem) {
                            QVariantMap chordEntry;
                            chordEntry.insert ("position", chordItem->get_position ());
                            chordEntry.insert ("type", chordItem->get_type ());
                            if (chordItem->get_variant () != ChordVariant::Major) {
                                chordEntry.insert ("variant", chordItem->get_variant ());
                            }
                            if (chordItem->get_extra () != ChordExtra::None) {
                                chordEntry.insert ("extra", chordItem->get_extra ());
                            }
                            chordsList.append (chordEntry);
                        }
                    }
                    if (!chordsList.isEmpty ()) {
                        lineEntry.insert ("chords", chordsList);
                    }
                    linesList.append (lineEntry);
                }
            }
            groupEntry.insert ("lines", linesList);
            groupsList.append (groupEntry);
        }
    }
    songEntry.insert ("groups", groupsList);
    QJsonDocument json = QJsonDocument::fromVariant (QVariant::fromValue (songEntry));
    QString ret = json.toJson (QJsonDocument::Indented);
    return ret;
}

/*************************** FILE *******************************/

FileItem::FileItem (QObject * parent)
    : QObject (parent)
    , m_fileName ("")
{

}
