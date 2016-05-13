/****************************************************************************
** Meta object code from reading C++ file 'manu_fileopendialog.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.6.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../ManuKnow/src/manu_fileopendialog.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#include <QtCore/QList>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'manu_fileopendialog.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.6.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_FileOpenDialog_t {
    QByteArrayData data[23];
    char stringdata0[250];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_FileOpenDialog_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_FileOpenDialog_t qt_meta_stringdata_FileOpenDialog = {
    {
QT_MOC_LITERAL(0, 0, 14), // "FileOpenDialog"
QT_MOC_LITERAL(1, 15, 14), // "fileUrlChanged"
QT_MOC_LITERAL(2, 30, 0), // ""
QT_MOC_LITERAL(3, 31, 15), // "fileUrlsChanged"
QT_MOC_LITERAL(4, 47, 15), // "filenameChanged"
QT_MOC_LITERAL(5, 63, 12), // "titleChanged"
QT_MOC_LITERAL(6, 76, 18), // "nameFiltersChanged"
QT_MOC_LITERAL(7, 95, 8), // "accepted"
QT_MOC_LITERAL(8, 104, 8), // "rejected"
QT_MOC_LITERAL(9, 113, 21), // "selectMultipleChanged"
QT_MOC_LITERAL(10, 135, 12), // "validChanged"
QT_MOC_LITERAL(11, 148, 6), // "accept"
QT_MOC_LITERAL(12, 155, 6), // "reject"
QT_MOC_LITERAL(13, 162, 4), // "open"
QT_MOC_LITERAL(14, 167, 5), // "close"
QT_MOC_LITERAL(15, 173, 5), // "valid"
QT_MOC_LITERAL(16, 179, 7), // "fileUrl"
QT_MOC_LITERAL(17, 187, 8), // "fileUrls"
QT_MOC_LITERAL(18, 196, 11), // "QList<QUrl>"
QT_MOC_LITERAL(19, 208, 8), // "filename"
QT_MOC_LITERAL(20, 217, 5), // "title"
QT_MOC_LITERAL(21, 223, 11), // "nameFilters"
QT_MOC_LITERAL(22, 235, 14) // "selectMultiple"

    },
    "FileOpenDialog\0fileUrlChanged\0\0"
    "fileUrlsChanged\0filenameChanged\0"
    "titleChanged\0nameFiltersChanged\0"
    "accepted\0rejected\0selectMultipleChanged\0"
    "validChanged\0accept\0reject\0open\0close\0"
    "valid\0fileUrl\0fileUrls\0QList<QUrl>\0"
    "filename\0title\0nameFilters\0selectMultiple"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_FileOpenDialog[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      13,   14, // methods
       7,   92, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       9,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   79,    2, 0x06 /* Public */,
       3,    0,   80,    2, 0x06 /* Public */,
       4,    0,   81,    2, 0x06 /* Public */,
       5,    0,   82,    2, 0x06 /* Public */,
       6,    0,   83,    2, 0x06 /* Public */,
       7,    0,   84,    2, 0x06 /* Public */,
       8,    0,   85,    2, 0x06 /* Public */,
       9,    0,   86,    2, 0x06 /* Public */,
      10,    0,   87,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      11,    0,   88,    2, 0x09 /* Protected */,
      12,    0,   89,    2, 0x09 /* Protected */,

 // methods: name, argc, parameters, tag, flags
      13,    0,   90,    2, 0x02 /* Public */,
      14,    0,   91,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
      15, QMetaType::Bool, 0x00495001,
      16, QMetaType::QUrl, 0x00495001,
      17, 0x80000000 | 18, 0x00495009,
      19, QMetaType::QString, 0x00495103,
      20, QMetaType::QString, 0x00495103,
      21, QMetaType::QStringList, 0x00495103,
      22, QMetaType::Bool, 0x00495103,

 // properties: notify_signal_id
       8,
       0,
       1,
       2,
       3,
       4,
       7,

       0        // eod
};

void FileOpenDialog::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        FileOpenDialog *_t = static_cast<FileOpenDialog *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->fileUrlChanged(); break;
        case 1: _t->fileUrlsChanged(); break;
        case 2: _t->filenameChanged(); break;
        case 3: _t->titleChanged(); break;
        case 4: _t->nameFiltersChanged(); break;
        case 5: _t->accepted(); break;
        case 6: _t->rejected(); break;
        case 7: _t->selectMultipleChanged(); break;
        case 8: _t->validChanged(); break;
        case 9: _t->accept(); break;
        case 10: _t->reject(); break;
        case 11: _t->open(); break;
        case 12: _t->close(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (FileOpenDialog::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FileOpenDialog::fileUrlChanged)) {
                *result = 0;
                return;
            }
        }
        {
            typedef void (FileOpenDialog::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FileOpenDialog::fileUrlsChanged)) {
                *result = 1;
                return;
            }
        }
        {
            typedef void (FileOpenDialog::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FileOpenDialog::filenameChanged)) {
                *result = 2;
                return;
            }
        }
        {
            typedef void (FileOpenDialog::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FileOpenDialog::titleChanged)) {
                *result = 3;
                return;
            }
        }
        {
            typedef void (FileOpenDialog::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FileOpenDialog::nameFiltersChanged)) {
                *result = 4;
                return;
            }
        }
        {
            typedef void (FileOpenDialog::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FileOpenDialog::accepted)) {
                *result = 5;
                return;
            }
        }
        {
            typedef void (FileOpenDialog::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FileOpenDialog::rejected)) {
                *result = 6;
                return;
            }
        }
        {
            typedef void (FileOpenDialog::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FileOpenDialog::selectMultipleChanged)) {
                *result = 7;
                return;
            }
        }
        {
            typedef void (FileOpenDialog::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FileOpenDialog::validChanged)) {
                *result = 8;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 2:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<QUrl> >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        FileOpenDialog *_t = static_cast<FileOpenDialog *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = _t->valid(); break;
        case 1: *reinterpret_cast< QUrl*>(_v) = _t->fileUrl(); break;
        case 2: *reinterpret_cast< QList<QUrl>*>(_v) = _t->fileUrls(); break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->filename(); break;
        case 4: *reinterpret_cast< QString*>(_v) = _t->title(); break;
        case 5: *reinterpret_cast< QStringList*>(_v) = _t->nameFilters(); break;
        case 6: *reinterpret_cast< bool*>(_v) = _t->selectMultiple(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        FileOpenDialog *_t = static_cast<FileOpenDialog *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 3: _t->setFilename(*reinterpret_cast< QString*>(_v)); break;
        case 4: _t->setTitle(*reinterpret_cast< QString*>(_v)); break;
        case 5: _t->setNameFilters(*reinterpret_cast< QStringList*>(_v)); break;
        case 6: _t->setSelectMultiple(*reinterpret_cast< bool*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject FileOpenDialog::staticMetaObject = {
    { &QQuickItem::staticMetaObject, qt_meta_stringdata_FileOpenDialog.data,
      qt_meta_data_FileOpenDialog,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *FileOpenDialog::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *FileOpenDialog::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_FileOpenDialog.stringdata0))
        return static_cast<void*>(const_cast< FileOpenDialog*>(this));
    return QQuickItem::qt_metacast(_clname);
}

int FileOpenDialog::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QQuickItem::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 13)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 13)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 13;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 7;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void FileOpenDialog::fileUrlChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, Q_NULLPTR);
}

// SIGNAL 1
void FileOpenDialog::fileUrlsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, Q_NULLPTR);
}

// SIGNAL 2
void FileOpenDialog::filenameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, Q_NULLPTR);
}

// SIGNAL 3
void FileOpenDialog::titleChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, Q_NULLPTR);
}

// SIGNAL 4
void FileOpenDialog::nameFiltersChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, Q_NULLPTR);
}

// SIGNAL 5
void FileOpenDialog::accepted()
{
    QMetaObject::activate(this, &staticMetaObject, 5, Q_NULLPTR);
}

// SIGNAL 6
void FileOpenDialog::rejected()
{
    QMetaObject::activate(this, &staticMetaObject, 6, Q_NULLPTR);
}

// SIGNAL 7
void FileOpenDialog::selectMultipleChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, Q_NULLPTR);
}

// SIGNAL 8
void FileOpenDialog::validChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 8, Q_NULLPTR);
}
QT_END_MOC_NAMESPACE
