import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    property variant nodePic: ["qrc:/image/LeftMenu.Video.Nomal.png", "qrc:/image/LeftMenu.Video.Over.png"]
    id:root

    TreeView {
        id: myTree
        anchors.fill: parent
//        style: treeViewStyle

    }
}
