import QtQuick 2.5

pragma Singleton

/*!
   \qmltype MaterialAnimation
   \inqmlmodule Material

   \brief A singleton with common animation durations.
 */
QtObject {
    id: materialAnimation

    property int pageTransitionDuration: 250
}

