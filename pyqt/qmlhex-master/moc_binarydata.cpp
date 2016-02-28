/****************************************************************************
** Meta object code from reading C++ file 'binarydata.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "binarydata.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'binarydata.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_BinaryData_t {
    QByteArrayData data[26];
    char stringdata0[233];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_BinaryData_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_BinaryData_t qt_meta_stringdata_BinaryData = {
    {
QT_MOC_LITERAL(0, 0, 10), // "BinaryData"
QT_MOC_LITERAL(1, 11, 13), // "addressChange"
QT_MOC_LITERAL(2, 25, 0), // ""
QT_MOC_LITERAL(3, 26, 7), // "address"
QT_MOC_LITERAL(4, 34, 12), // "offsetChange"
QT_MOC_LITERAL(5, 47, 10), // "modeChange"
QT_MOC_LITERAL(6, 58, 13), // "enteredChange"
QT_MOC_LITERAL(7, 72, 12), // "promptChange"
QT_MOC_LITERAL(8, 85, 6), // "search"
QT_MOC_LITERAL(9, 92, 7), // "pattern"
QT_MOC_LITERAL(10, 100, 9), // "findFirst"
QT_MOC_LITERAL(11, 110, 8), // "keyPress"
QT_MOC_LITERAL(12, 119, 7), // "keyCode"
QT_MOC_LITERAL(13, 127, 7), // "keyText"
QT_MOC_LITERAL(14, 135, 11), // "findPattern"
QT_MOC_LITERAL(15, 147, 5), // "start"
QT_MOC_LITERAL(16, 153, 6), // "offset"
QT_MOC_LITERAL(17, 160, 4), // "mode"
QT_MOC_LITERAL(18, 165, 4), // "Mode"
QT_MOC_LITERAL(19, 170, 7), // "entered"
QT_MOC_LITERAL(20, 178, 6), // "prompt"
QT_MOC_LITERAL(21, 185, 10), // "BrowseMode"
QT_MOC_LITERAL(22, 196, 10), // "InsertMode"
QT_MOC_LITERAL(23, 207, 10), // "SearchMode"
QT_MOC_LITERAL(24, 218, 5), // "Param"
QT_MOC_LITERAL(25, 224, 8) // "LineSize"

    },
    "BinaryData\0addressChange\0\0address\0"
    "offsetChange\0modeChange\0enteredChange\0"
    "promptChange\0search\0pattern\0findFirst\0"
    "keyPress\0keyCode\0keyText\0findPattern\0"
    "start\0offset\0mode\0Mode\0entered\0prompt\0"
    "BrowseMode\0InsertMode\0SearchMode\0Param\0"
    "LineSize"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_BinaryData[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       5,   74, // properties
       2,   94, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   54,    2, 0x06 /* Public */,
       4,    0,   57,    2, 0x06 /* Public */,
       5,    0,   58,    2, 0x06 /* Public */,
       6,    0,   59,    2, 0x06 /* Public */,
       7,    0,   60,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       8,    2,   61,    2, 0x02 /* Public */,
      11,    2,   66,    2, 0x02 /* Public */,
      14,    1,   71,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Int, QMetaType::QString, QMetaType::Bool,    9,   10,
    QMetaType::Void, QMetaType::Int, QMetaType::QString,   12,   13,
    QMetaType::Int, QMetaType::Int,   15,

 // properties: name, type, flags
       3, QMetaType::QString, 0x00495103,
      16, QMetaType::Int, 0x00495103,
      17, 0x80000000 | 18, 0x0049510b,
      19, QMetaType::QString, 0x00495001,
      20, QMetaType::QString, 0x00495001,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       4,

 // enums: name, flags, count, data
      18, 0x0,    3,  102,
      24, 0x0,    1,  108,

 // enum data: key, value
      21, uint(BinaryData::BrowseMode),
      22, uint(BinaryData::InsertMode),
      23, uint(BinaryData::SearchMode),
      25, uint(BinaryData::LineSize),

       0        // eod
};

void BinaryData::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        BinaryData *_t = static_cast<BinaryData *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->addressChange((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: _t->offsetChange(); break;
        case 2: _t->modeChange(); break;
        case 3: _t->enteredChange(); break;
        case 4: _t->promptChange(); break;
        case 5: { int _r = _t->search((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 6: _t->keyPress((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 7: { int _r = _t->findPattern((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (BinaryData::*_t)(int );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&BinaryData::addressChange)) {
                *result = 0;
            }
        }
        {
            typedef void (BinaryData::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&BinaryData::offsetChange)) {
                *result = 1;
            }
        }
        {
            typedef void (BinaryData::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&BinaryData::modeChange)) {
                *result = 2;
            }
        }
        {
            typedef void (BinaryData::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&BinaryData::enteredChange)) {
                *result = 3;
            }
        }
        {
            typedef void (BinaryData::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&BinaryData::promptChange)) {
                *result = 4;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        BinaryData *_t = static_cast<BinaryData *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->address(); break;
        case 1: *reinterpret_cast< int*>(_v) = _t->offset(); break;
        case 2: *reinterpret_cast< Mode*>(_v) = _t->mode(); break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->entered(); break;
        case 4: *reinterpret_cast< QString*>(_v) = _t->prompt(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        BinaryData *_t = static_cast<BinaryData *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setAddress(*reinterpret_cast< QString*>(_v)); break;
        case 1: _t->setOffset(*reinterpret_cast< int*>(_v)); break;
        case 2: _t->setMode(*reinterpret_cast< Mode*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject BinaryData::staticMetaObject = {
    { &QAbstractListModel::staticMetaObject, qt_meta_stringdata_BinaryData.data,
      qt_meta_data_BinaryData,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *BinaryData::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BinaryData::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_BinaryData.stringdata0))
        return static_cast<void*>(const_cast< BinaryData*>(this));
    return QAbstractListModel::qt_metacast(_clname);
}

int BinaryData::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 8;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 5;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void BinaryData::addressChange(int _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void BinaryData::offsetChange()
{
    QMetaObject::activate(this, &staticMetaObject, 1, Q_NULLPTR);
}

// SIGNAL 2
void BinaryData::modeChange()
{
    QMetaObject::activate(this, &staticMetaObject, 2, Q_NULLPTR);
}

// SIGNAL 3
void BinaryData::enteredChange()
{
    QMetaObject::activate(this, &staticMetaObject, 3, Q_NULLPTR);
}

// SIGNAL 4
void BinaryData::promptChange()
{
    QMetaObject::activate(this, &staticMetaObject, 4, Q_NULLPTR);
}
QT_END_MOC_NAMESPACE
