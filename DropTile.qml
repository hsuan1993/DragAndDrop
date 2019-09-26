import QtQuick 2.0

DropArea {
    id: dragTarget

    property string colorKey
    property alias dropProxy: dragTarget

    width: mainpage.width/4 - units.gu(1)
    height: width
    keys: [ colorKey ]

    onDropped: {
        console.log("onDropped!")
    }

    onEntered: {
        console.log("onEntered!");
    }

    onExited: {
        console.log("onExited!")
    }

    onPositionChanged: {
        console.log("onPositionChanged!");
    }

    Rectangle {
        id: dropRectangle

        anchors.fill: parent
        color: colorKey

        states: [
            State {
                when: dragTarget.containsDrag
                PropertyChanges {
                    target: dropRectangle
                    color: "grey"
                }
            }
        ]
    }
}
