import QtQuick 2.0

Item {
    id: root
        property string colorKey

        width: mainpage.width/4 - units.gu(1); height: width

        MouseArea {
            id: mouseArea

            width: parent.width
            height: width

            anchors.centerIn: parent

            drag.target: tile

            onReleased: parent = tile.Drag.target !== null ? tile.Drag.target : root

            Rectangle {
                id: tile

                width: root.width; height: width
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                color: colorKey

                Drag.keys: [ colorKey ]
                Drag.active: mouseArea.drag.active
                Drag.hotSpot.x: 32
                Drag.hotSpot.y: 32

                Image {
                    anchors.fill: parent
                    source: image
                }

                states: State {
                    when: mouseArea.drag.active
                    ParentChange { target: tile; parent: root }
                    AnchorChanges { target: tile; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
                }

            }
        }

}
