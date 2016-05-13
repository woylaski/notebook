/****************************************************************************
** Meta object code from reading C++ file 'manu_filesystem.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.6.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../ManuKnow/src/manu_filesystem.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'manu_filesystem.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.6.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_ManuFileIO_t {
    QByteArrayData data[20];
    char stringdata0[194];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_ManuFileIO_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_ManuFileIO_t qt_meta_stringdata_ManuFileIO = {
    {
QT_MOC_LITERAL(0, 0, 10), // "ManuFileIO"
QT_MOC_LITERAL(1, 11, 13), // "sourceChanged"
QT_MOC_LITERAL(2, 25, 0), // ""
QT_MOC_LITERAL(3, 26, 5), // "fname"
QT_MOC_LITERAL(4, 32, 14), // "contentChanged"
QT_MOC_LITERAL(5, 47, 4), // "data"
QT_MOC_LITERAL(6, 52, 9), // "setSource"
QT_MOC_LITERAL(7, 62, 6), // "source"
QT_MOC_LITERAL(8, 69, 10), // "setContent"
QT_MOC_LITERAL(9, 80, 9), // "readBytes"
QT_MOC_LITERAL(10, 90, 8), // "filename"
QT_MOC_LITERAL(11, 99, 10), // "readString"
QT_MOC_LITERAL(12, 110, 11), // "writeString"
QT_MOC_LITERAL(13, 122, 8), // "saveFile"
QT_MOC_LITERAL(14, 131, 10), // "createFile"
QT_MOC_LITERAL(15, 142, 10), // "deleteFile"
QT_MOC_LITERAL(16, 153, 11), // "listDirInfo"
QT_MOC_LITERAL(17, 165, 7), // "dirname"
QT_MOC_LITERAL(18, 173, 12), // "listFileInfo"
QT_MOC_LITERAL(19, 186, 7) // "content"

    },
    "ManuFileIO\0sourceChanged\0\0fname\0"
    "contentChanged\0data\0setSource\0source\0"
    "setContent\0readBytes\0filename\0readString\0"
    "writeString\0saveFile\0createFile\0"
    "deleteFile\0listDirInfo\0dirname\0"
    "listFileInfo\0content"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_ManuFileIO[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       2,  112, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   74,    2, 0x06 /* Public */,
       4,    1,   77,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       6,    1,   80,    2, 0x0a /* Public */,
       8,    1,   83,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
       9,    1,   86,    2, 0x02 /* Public */,
      11,    1,   89,    2, 0x02 /* Public */,
      12,    1,   92,    2, 0x02 /* Public */,
      13,    2,   95,    2, 0x02 /* Public */,
      14,    1,  100,    2, 0x02 /* Public */,
      15,    1,  103,    2, 0x02 /* Public */,
      16,    1,  106,    2, 0x02 /* Public */,
      18,    1,  109,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QString,    5,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,    7,
    QMetaType::Void, QMetaType::QString,    5,

 // methods: parameters
    QMetaType::QByteArray, QMetaType::QString,   10,
    QMetaType::QString, QMetaType::QString,   10,
    QMetaType::Bool, QMetaType::QString,    5,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString,   10,    5,
    QMetaType::Bool, QMetaType::QString,   10,
    QMetaType::Bool, QMetaType::QString,   10,
    QMetaType::Bool, QMetaType::QString,   17,
    QMetaType::Bool, QMetaType::QString,   10,

 // properties: name, type, flags
       7, QMetaType::QString, 0x00495103,
      19, QMetaType::QString, 0x00495103,

 // properties: notify_signal_id
       0,
       1,

       0        // eod
};

void ManuFileIO::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        ManuFileIO *_t = static_cast<ManuFileIO *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->sourceChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->contentChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: _t->setSource((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->setContent((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 4: { QByteArray _r = _t->readBytes((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QByteArray*>(_a[0]) = _r; }  break;
        case 5: { QString _r = _t->readString((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 6: { bool _r = _t->writeString((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 7: { bool _r = _t->saveFile((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 8: { bool _r = _t->createFile((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 9: { bool _r = _t->deleteFile((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 10: { bool _r = _t->listDirInfo((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 11: { bool _r = _t->listFileInfo((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (ManuFileIO::*_t)(QString );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&ManuFileIO::sourceChanged)) {
                *result = 0;
                return;
            }
        }
        {
            typedef void (ManuFileIO::*_t)(QString );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&ManuFileIO::contentChanged)) {
                *result = 1;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        ManuFileIO *_t = static_cast<ManuFileIO *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->source(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->content(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        ManuFileIO *_t = static_cast<ManuFileIO *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setSource(*reinterpret_cast< QString*>(_v)); break;
        case 1: _t->setContent(*reinterpret_cast< QString*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject ManuFileIO::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ManuFileIO.data,
      qt_meta_data_ManuFileIO,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *ManuFileIO::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ManuFileIO::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_ManuFileIO.stringdata0))
        return static_cast<void*>(const_cast< ManuFileIO*>(this));
    return QObject::qt_metacast(_clname);
}

int ManuFileIO::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 12)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 12;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 12)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 12;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 2;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void ManuFileIO::sourceChanged(QString _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void ManuFileIO::contentChanged(QString _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
