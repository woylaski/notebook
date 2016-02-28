/****************************************************************************
** Meta object code from reading C++ file 'qchdbusconnections.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "qchdbusconnections.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qchdbusconnections.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_QchDBusConnections_t {
    QByteArrayData data[15];
    char stringdata0[187];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QchDBusConnections_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QchDBusConnections_t qt_meta_stringdata_QchDBusConnections = {
    {
QT_MOC_LITERAL(0, 0, 18), // "QchDBusConnections"
QT_MOC_LITERAL(1, 19, 10), // "busChanged"
QT_MOC_LITERAL(2, 30, 0), // ""
QT_MOC_LITERAL(3, 31, 14), // "enabledChanged"
QT_MOC_LITERAL(4, 46, 20), // "interfaceNameChanged"
QT_MOC_LITERAL(5, 67, 11), // "pathChanged"
QT_MOC_LITERAL(6, 79, 18), // "serviceNameChanged"
QT_MOC_LITERAL(7, 98, 15), // "_q_handleSignal"
QT_MOC_LITERAL(8, 114, 12), // "QDBusMessage"
QT_MOC_LITERAL(9, 127, 3), // "bus"
QT_MOC_LITERAL(10, 131, 16), // "QchDBus::BusType"
QT_MOC_LITERAL(11, 148, 7), // "enabled"
QT_MOC_LITERAL(12, 156, 13), // "interfaceName"
QT_MOC_LITERAL(13, 170, 4), // "path"
QT_MOC_LITERAL(14, 175, 11) // "serviceName"

    },
    "QchDBusConnections\0busChanged\0\0"
    "enabledChanged\0interfaceNameChanged\0"
    "pathChanged\0serviceNameChanged\0"
    "_q_handleSignal\0QDBusMessage\0bus\0"
    "QchDBus::BusType\0enabled\0interfaceName\0"
    "path\0serviceName"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QchDBusConnections[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       5,   52, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   44,    2, 0x06 /* Public */,
       3,    0,   45,    2, 0x06 /* Public */,
       4,    0,   46,    2, 0x06 /* Public */,
       5,    0,   47,    2, 0x06 /* Public */,
       6,    0,   48,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       7,    1,   49,    2, 0x09 /* Protected */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, 0x80000000 | 8,    2,

 // properties: name, type, flags
       9, 0x80000000 | 10, 0x0049510b,
      11, QMetaType::Bool, 0x00495103,
      12, QMetaType::QString, 0x00495103,
      13, QMetaType::QString, 0x00495103,
      14, QMetaType::QString, 0x00495103,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       4,

       0        // eod
};

void QchDBusConnections::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QchDBusConnections *_t = static_cast<QchDBusConnections *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->busChanged(); break;
        case 1: _t->enabledChanged(); break;
        case 2: _t->interfaceNameChanged(); break;
        case 3: _t->pathChanged(); break;
        case 4: _t->serviceNameChanged(); break;
        case 5: _t->d_func()->_q_handleSignal((*reinterpret_cast< QDBusMessage(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (QchDBusConnections::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QchDBusConnections::busChanged)) {
                *result = 0;
            }
        }
        {
            typedef void (QchDBusConnections::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QchDBusConnections::enabledChanged)) {
                *result = 1;
            }
        }
        {
            typedef void (QchDBusConnections::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QchDBusConnections::interfaceNameChanged)) {
                *result = 2;
            }
        }
        {
            typedef void (QchDBusConnections::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QchDBusConnections::pathChanged)) {
                *result = 3;
            }
        }
        {
            typedef void (QchDBusConnections::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QchDBusConnections::serviceNameChanged)) {
                *result = 4;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        QchDBusConnections *_t = static_cast<QchDBusConnections *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QchDBus::BusType*>(_v) = _t->bus(); break;
        case 1: *reinterpret_cast< bool*>(_v) = _t->isEnabled(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->interfaceName(); break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->path(); break;
        case 4: *reinterpret_cast< QString*>(_v) = _t->serviceName(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        QchDBusConnections *_t = static_cast<QchDBusConnections *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setBus(*reinterpret_cast< QchDBus::BusType*>(_v)); break;
        case 1: _t->setEnabled(*reinterpret_cast< bool*>(_v)); break;
        case 2: _t->setInterfaceName(*reinterpret_cast< QString*>(_v)); break;
        case 3: _t->setPath(*reinterpret_cast< QString*>(_v)); break;
        case 4: _t->setServiceName(*reinterpret_cast< QString*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

static const QMetaObject * const qt_meta_extradata_QchDBusConnections[] = {
        &QchDBus::staticMetaObject,
    Q_NULLPTR
};

const QMetaObject QchDBusConnections::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QchDBusConnections.data,
      qt_meta_data_QchDBusConnections,  qt_static_metacall, qt_meta_extradata_QchDBusConnections, Q_NULLPTR}
};


const QMetaObject *QchDBusConnections::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QchDBusConnections::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_QchDBusConnections.stringdata0))
        return static_cast<void*>(const_cast< QchDBusConnections*>(this));
    if (!strcmp(_clname, "QDeclarativeParserStatus"))
        return static_cast< QDeclarativeParserStatus*>(const_cast< QchDBusConnections*>(this));
    if (!strcmp(_clname, "org.qt-project.Qt.QDeclarativeParserStatus"))
        return static_cast< QDeclarativeParserStatus*>(const_cast< QchDBusConnections*>(this));
    return QObject::qt_metacast(_clname);
}

int QchDBusConnections::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 6;
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
void QchDBusConnections::busChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, Q_NULLPTR);
}

// SIGNAL 1
void QchDBusConnections::enabledChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, Q_NULLPTR);
}

// SIGNAL 2
void QchDBusConnections::interfaceNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, Q_NULLPTR);
}

// SIGNAL 3
void QchDBusConnections::pathChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, Q_NULLPTR);
}

// SIGNAL 4
void QchDBusConnections::serviceNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, Q_NULLPTR);
}
QT_END_MOC_NAMESPACE
