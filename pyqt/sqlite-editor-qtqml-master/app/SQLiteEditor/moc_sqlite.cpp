/****************************************************************************
** Meta object code from reading C++ file 'sqlite.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "sqlite.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#include <QtCore/QList>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'sqlite.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_SQLite_t {
    QByteArrayData data[25];
    char stringdata0[260];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_SQLite_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_SQLite_t qt_meta_stringdata_SQLite = {
    {
QT_MOC_LITERAL(0, 0, 6), // "SQLite"
QT_MOC_LITERAL(1, 7, 14), // "databaseOpened"
QT_MOC_LITERAL(2, 22, 0), // ""
QT_MOC_LITERAL(3, 23, 19), // "databasePathChanged"
QT_MOC_LITERAL(4, 43, 3), // "arg"
QT_MOC_LITERAL(5, 47, 12), // "queryChanged"
QT_MOC_LITERAL(6, 60, 13), // "statusChanged"
QT_MOC_LITERAL(7, 74, 6), // "Status"
QT_MOC_LITERAL(8, 81, 12), // "resultsReady"
QT_MOC_LITERAL(9, 94, 7), // "results"
QT_MOC_LITERAL(10, 102, 5), // "query"
QT_MOC_LITERAL(11, 108, 12), // "createThread"
QT_MOC_LITERAL(12, 121, 11), // "slotResults"
QT_MOC_LITERAL(13, 133, 17), // "QList<QSqlRecord>"
QT_MOC_LITERAL(14, 151, 15), // "dbThreadStarted"
QT_MOC_LITERAL(15, 167, 12), // "executeQuery"
QT_MOC_LITERAL(16, 180, 15), // "setDatabasePath"
QT_MOC_LITERAL(17, 196, 8), // "setQuery"
QT_MOC_LITERAL(18, 205, 9), // "setStatus"
QT_MOC_LITERAL(19, 215, 12), // "databasePath"
QT_MOC_LITERAL(20, 228, 6), // "status"
QT_MOC_LITERAL(21, 235, 4), // "Null"
QT_MOC_LITERAL(22, 240, 5), // "Ready"
QT_MOC_LITERAL(23, 246, 7), // "Loading"
QT_MOC_LITERAL(24, 254, 5) // "Error"

    },
    "SQLite\0databaseOpened\0\0databasePathChanged\0"
    "arg\0queryChanged\0statusChanged\0Status\0"
    "resultsReady\0results\0query\0createThread\0"
    "slotResults\0QList<QSqlRecord>\0"
    "dbThreadStarted\0executeQuery\0"
    "setDatabasePath\0setQuery\0setStatus\0"
    "databasePath\0status\0Null\0Ready\0Loading\0"
    "Error"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_SQLite[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       3,  108, // properties
       1,  120, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   74,    2, 0x06 /* Public */,
       3,    1,   75,    2, 0x06 /* Public */,
       5,    1,   78,    2, 0x06 /* Public */,
       6,    1,   81,    2, 0x06 /* Public */,
       8,    2,   84,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      11,    1,   89,    2, 0x08 /* Private */,
      12,    1,   92,    2, 0x08 /* Private */,
      14,    0,   95,    2, 0x08 /* Private */,
      15,    1,   96,    2, 0x0a /* Public */,
      16,    1,   99,    2, 0x0a /* Public */,
      17,    1,  102,    2, 0x0a /* Public */,
      18,    1,  105,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::QUrl,    4,
    QMetaType::Void, QMetaType::QString,    4,
    QMetaType::Void, 0x80000000 | 7,    4,
    QMetaType::Void, QMetaType::QVariantList, QMetaType::QString,    9,   10,

 // slots: parameters
    QMetaType::Void, QMetaType::QUrl,    2,
    QMetaType::Void, 0x80000000 | 13,    2,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::QUrl,    4,
    QMetaType::Void, QMetaType::QString,    4,
    QMetaType::Void, 0x80000000 | 7,    4,

 // properties: name, type, flags
      19, QMetaType::QUrl, 0x00495103,
      10, QMetaType::QString, 0x00495103,
      20, 0x80000000 | 7, 0x0049510b,

 // properties: notify_signal_id
       1,
       2,
       3,

 // enums: name, flags, count, data
       7, 0x0,    4,  124,

 // enum data: key, value
      21, uint(SQLite::Null),
      22, uint(SQLite::Ready),
      23, uint(SQLite::Loading),
      24, uint(SQLite::Error),

       0        // eod
};

void SQLite::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        SQLite *_t = static_cast<SQLite *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->databaseOpened(); break;
        case 1: _t->databasePathChanged((*reinterpret_cast< QUrl(*)>(_a[1]))); break;
        case 2: _t->queryChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->statusChanged((*reinterpret_cast< Status(*)>(_a[1]))); break;
        case 4: _t->resultsReady((*reinterpret_cast< QVariantList(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 5: _t->createThread((*reinterpret_cast< QUrl(*)>(_a[1]))); break;
        case 6: _t->slotResults((*reinterpret_cast< const QList<QSqlRecord>(*)>(_a[1]))); break;
        case 7: _t->dbThreadStarted(); break;
        case 8: _t->executeQuery((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: _t->setDatabasePath((*reinterpret_cast< QUrl(*)>(_a[1]))); break;
        case 10: _t->setQuery((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 11: _t->setStatus((*reinterpret_cast< Status(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (SQLite::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&SQLite::databaseOpened)) {
                *result = 0;
            }
        }
        {
            typedef void (SQLite::*_t)(QUrl );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&SQLite::databasePathChanged)) {
                *result = 1;
            }
        }
        {
            typedef void (SQLite::*_t)(QString );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&SQLite::queryChanged)) {
                *result = 2;
            }
        }
        {
            typedef void (SQLite::*_t)(Status );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&SQLite::statusChanged)) {
                *result = 3;
            }
        }
        {
            typedef void (SQLite::*_t)(QVariantList , QString );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&SQLite::resultsReady)) {
                *result = 4;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        SQLite *_t = static_cast<SQLite *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QUrl*>(_v) = _t->databasePath(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->getQuery(); break;
        case 2: *reinterpret_cast< Status*>(_v) = _t->getStatus(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        SQLite *_t = static_cast<SQLite *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setDatabasePath(*reinterpret_cast< QUrl*>(_v)); break;
        case 1: _t->setQuery(*reinterpret_cast< QString*>(_v)); break;
        case 2: _t->setStatus(*reinterpret_cast< Status*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject SQLite::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_SQLite.data,
      qt_meta_data_SQLite,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *SQLite::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *SQLite::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_SQLite.stringdata0))
        return static_cast<void*>(const_cast< SQLite*>(this));
    return QObject::qt_metacast(_clname);
}

int SQLite::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void SQLite::databaseOpened()
{
    QMetaObject::activate(this, &staticMetaObject, 0, Q_NULLPTR);
}

// SIGNAL 1
void SQLite::databasePathChanged(QUrl _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void SQLite::queryChanged(QString _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void SQLite::statusChanged(Status _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void SQLite::resultsReady(QVariantList _t1, QString _t2)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}
QT_END_MOC_NAMESPACE
