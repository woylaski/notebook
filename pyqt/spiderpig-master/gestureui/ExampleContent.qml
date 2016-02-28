import QtQuick 1.0

Rectangle {
    width: 800
    height: 600
    color: "white"


    Menu {
        Menu {
            label: "Call"
            Menu {
                label: "New call"
                Menu {
                    label: "Favories"
                }
                Menu {
                    label: "Recents"
                }
                Menu {
                    label: "Phonebook"
                }
                Menu {
                    label: "URI"
                }
            }
            Menu {
                label: "Call 1: Nico Cormiere"
                Menu {
                    label: "End call"
                }
                Menu {
                    label: "Pause call"
                }
                Menu {
                    label: "Mute"
                }
                Menu {
                    label: "Speaker off"
                }
            }
            Menu {
                label: "Call 2: Eivind Haarr"
            }
        }
        Menu {
            label: "Applications"
        }
        Menu {
            label: "Settings"
        }
    }
}
