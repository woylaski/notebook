/****************************************************************************
** Meta object code from reading C++ file 'graph.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../qml-ogdf-master/ogdfplugin/graph.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'graph.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_Graph_t {
    QByteArrayData data[32];
    char stringdata0[293];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Graph_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Graph_t qt_meta_stringdata_Graph = {
    {
QT_MOC_LITERAL(0, 0, 5), // "Graph"
QT_MOC_LITERAL(1, 6, 13), // "sourceChanged"
QT_MOC_LITERAL(2, 20, 0), // ""
QT_MOC_LITERAL(3, 21, 12), // "updateModels"
QT_MOC_LITERAL(4, 34, 4), // "save"
QT_MOC_LITERAL(5, 39, 3), // "url"
QT_MOC_LITERAL(6, 43, 6), // "reload"
QT_MOC_LITERAL(7, 50, 11), // "randomGraph"
QT_MOC_LITERAL(8, 62, 1), // "n"
QT_MOC_LITERAL(9, 64, 1), // "m"
QT_MOC_LITERAL(10, 66, 17), // "randomSimpleGraph"
QT_MOC_LITERAL(11, 84, 22), // "randomBiconnectedGraph"
QT_MOC_LITERAL(12, 107, 23), // "randomTriconnectedGraph"
QT_MOC_LITERAL(13, 131, 2), // "p1"
QT_MOC_LITERAL(14, 134, 2), // "p2"
QT_MOC_LITERAL(15, 137, 10), // "randomTree"
QT_MOC_LITERAL(16, 148, 6), // "maxDeg"
QT_MOC_LITERAL(17, 155, 8), // "maxWidth"
QT_MOC_LITERAL(18, 164, 15), // "randomHierarchy"
QT_MOC_LITERAL(19, 180, 6), // "planar"
QT_MOC_LITERAL(20, 187, 12), // "singleSource"
QT_MOC_LITERAL(21, 200, 9), // "longEdges"
QT_MOC_LITERAL(22, 210, 13), // "randomDiGraph"
QT_MOC_LITERAL(23, 224, 1), // "p"
QT_MOC_LITERAL(24, 226, 5), // "clear"
QT_MOC_LITERAL(25, 232, 6), // "source"
QT_MOC_LITERAL(26, 239, 6), // "layout"
QT_MOC_LITERAL(27, 246, 12), // "GraphLayout*"
QT_MOC_LITERAL(28, 259, 5), // "nodes"
QT_MOC_LITERAL(29, 265, 10), // "NodeModel*"
QT_MOC_LITERAL(30, 276, 5), // "edges"
QT_MOC_LITERAL(31, 282, 10) // "EdgeModel*"

    },
    "Graph\0sourceChanged\0\0updateModels\0"
    "save\0url\0reload\0randomGraph\0n\0m\0"
    "randomSimpleGraph\0randomBiconnectedGraph\0"
    "randomTriconnectedGraph\0p1\0p2\0randomTree\0"
    "maxDeg\0maxWidth\0randomHierarchy\0planar\0"
    "singleSource\0longEdges\0randomDiGraph\0"
    "p\0clear\0source\0layout\0GraphLayout*\0"
    "nodes\0NodeModel*\0edges\0EdgeModel*"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Graph[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      13,   14, // methods
       4,  134, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   79,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       3,    0,   80,    2, 0x08 /* Private */,

 // methods: name, argc, parameters, tag, flags
       4,    1,   81,    2, 0x02 /* Public */,
       6,    0,   84,    2, 0x02 /* Public */,
       7,    2,   85,    2, 0x02 /* Public */,
      10,    2,   90,    2, 0x02 /* Public */,
      11,    2,   95,    2, 0x02 /* Public */,
      12,    3,  100,    2, 0x02 /* Public */,
      15,    1,  107,    2, 0x02 /* Public */,
      15,    3,  110,    2, 0x02 /* Public */,
      18,    5,  117,    2, 0x02 /* Public */,
      22,    2,  128,    2, 0x02 /* Public */,
      24,    0,  133,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Bool, QMetaType::QUrl,    5,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    8,    9,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    8,    9,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    8,    9,
    QMetaType::Void, QMetaType::Int, QMetaType::Double, QMetaType::Double,    8,   13,   14,
    QMetaType::Void, QMetaType::Int,    8,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int,    8,   16,   17,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Bool, QMetaType::Bool, QMetaType::Bool,    8,    9,   19,   20,   21,
    QMetaType::Void, QMetaType::Int, QMetaType::Double,    8,   23,
    QMetaType::Void,

 // properties: name, type, flags
      25, QMetaType::QUrl, 0x00495103,
      26, 0x80000000 | 27, 0x00095409,
      28, 0x80000000 | 29, 0x00095409,
      30, 0x80000000 | 31, 0x00095409,

 // properties: notify_signal_id
       0,
       0,
       0,
       0,

       0        // eod
};

void Graph::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Graph *_t = static_cast<Graph *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->sourceChanged(); break;
        case 1: _t->updateModels(); break;
        case 2: { bool _r = _t->save((*reinterpret_cast< const QUrl(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 3: { bool _r = _t->reload();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 4: _t->randomGraph((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 5: _t->randomSimpleGraph((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 6: _t->randomBiconnectedGraph((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 7: _t->randomTriconnectedGraph((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< double(*)>(_a[2])),(*reinterpret_cast< double(*)>(_a[3]))); break;
        case 8: _t->randomTree((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 9: _t->randomTree((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 10: _t->randomHierarchy((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< bool(*)>(_a[3])),(*reinterpret_cast< bool(*)>(_a[4])),(*reinterpret_cast< bool(*)>(_a[5]))); break;
        case 11: _t->randomDiGraph((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< double(*)>(_a[2]))); break;
        case 12: _t->clear(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (Graph::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Graph::sourceChanged)) {
                *result = 0;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 3:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< EdgeModel* >(); break;
        case 1:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< GraphLayout* >(); break;
        case 2:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< NodeModel* >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        Graph *_t = static_cast<Graph *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QUrl*>(_v) = _t->source(); break;
        case 1: *reinterpret_cast< GraphLayout**>(_v) = _t->layout(); break;
        case 2: *reinterpret_cast< NodeModel**>(_v) = _t->nodes(); break;
        case 3: *reinterpret_cast< EdgeModel**>(_v) = _t->edges(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        Graph *_t = static_cast<Graph *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setSource(*reinterpret_cast< QUrl*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject Graph::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Graph.data,
      qt_meta_data_Graph,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *Graph::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Graph::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_Graph.stringdata0))
        return static_cast<void*>(const_cast< Graph*>(this));
    return QObject::qt_metacast(_clname);
}

int Graph::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
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
void Graph::sourceChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, Q_NULLPTR);
}
QT_END_MOC_NAMESPACE
