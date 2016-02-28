/****************************************************************************
** Meta object code from reading C++ file 'codemodel.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "codemodel.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'codemodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_CodeModel_t {
    QByteArrayData data[9];
    char stringdata0[73];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_CodeModel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_CodeModel_t qt_meta_stringdata_CodeModel = {
    {
QT_MOC_LITERAL(0, 0, 9), // "CodeModel"
QT_MOC_LITERAL(1, 10, 9), // "published"
QT_MOC_LITERAL(2, 20, 0), // ""
QT_MOC_LITERAL(3, 21, 11), // "listChanged"
QT_MOC_LITERAL(4, 33, 7), // "publish"
QT_MOC_LITERAL(5, 41, 7), // "program"
QT_MOC_LITERAL(6, 49, 4), // "list"
QT_MOC_LITERAL(7, 54, 8), // "preamble"
QT_MOC_LITERAL(8, 63, 9) // "postamble"

    },
    "CodeModel\0published\0\0listChanged\0"
    "publish\0program\0list\0preamble\0postamble"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_CodeModel[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       4,   32, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   29,    2, 0x06 /* Public */,
       3,    0,   30,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       4,    0,   31,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,

 // properties: name, type, flags
       5, QMetaType::QString, 0x00495103,
       6, QMetaType::QStringList, 0x00495001,
       7, QMetaType::QString, 0x00095001,
       8, QMetaType::QString, 0x00095001,

 // properties: notify_signal_id
       0,
       1,
       0,
       0,

       0        // eod
};

void CodeModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        CodeModel *_t = static_cast<CodeModel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->published(); break;
        case 1: _t->listChanged(); break;
        case 2: _t->publish(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (CodeModel::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&CodeModel::published)) {
                *result = 0;
            }
        }
        {
            typedef void (CodeModel::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&CodeModel::listChanged)) {
                *result = 1;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        CodeModel *_t = static_cast<CodeModel *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->program(); break;
        case 1: *reinterpret_cast< QStringList*>(_v) = _t->list(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->preamble(); break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->postamble(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        CodeModel *_t = static_cast<CodeModel *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setProgram(*reinterpret_cast< QString*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
    Q_UNUSED(_a);
}

const QMetaObject CodeModel::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_CodeModel.data,
      qt_meta_data_CodeModel,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *CodeModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *CodeModel::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_CodeModel.stringdata0))
        return static_cast<void*>(const_cast< CodeModel*>(this));
    return QObject::qt_metacast(_clname);
}

int CodeModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 3;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 4;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void CodeModel::published()
{
    QMetaObject::activate(this, &staticMetaObject, 0, Q_NULLPTR);
}

// SIGNAL 1
void CodeModel::listChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, Q_NULLPTR);
}
QT_END_MOC_NAMESPACE
