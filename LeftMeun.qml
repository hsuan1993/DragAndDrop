import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Controls 1.4

Item {
    id: leftMeun
    property alias model: listView.model
    ListView{
        id:listView
        anchors.fill: parent

//        model: ListModel {
//            id:listModel
//        }
        delegate: list_delegate

    }

//    Component.onCompleted: {
//        for (var i=0;i<9;i++)
//            addModelData("Group 1","CH0"+(i+1),false,"rtsp://root:root@10.10.80.114:"+(554+i*2)+"/session0.mpg")
//    }

//    function addModelData(groupName,fileName,fileIsChecked,path){
//        var index = findIndex(groupName)
//        if(index === -1){
//            listModel.append({"groupName":groupName,"level":0,
//                                 "subNode":[{"fileName":fileName,"fileIsChecked":fileIsChecked,"path":path,"level":1,"subNode":[]}]})
//        }
//        else{
//            listModel.get(index).subNode.append({"fileName":fileName,"fileIsChecked":fileIsChecked,"path":path,"level":1,"subNode":[]})
//        }

//    }

//    function findIndex(name){
//        for(var i = 0 ; i < listModel.count ; ++i){
//            if(listModel.get(i).groupName === name){
//                return i
//            }
//        }
//        return -1
//    }

    Component{
            id:list_delegate

            Column{
                id: objColumn
                property int titleHeight: 36 *appWindow.zoomRate
                property string fontFamily: "consolas"
                property color fontColor0: "#777777"
                property color fontColor1: "#FFFFFF"
                property color fontColor2: "#CCCCCC"
                property color fontColor3: "#8ABC2F"
                property bool isChecked: false
                Component.onCompleted: {
                    for(var i = 1; i < objColumn.children.length - 1; ++i) {
                        objColumn.children[i].visible = false
                    }
                }
                MouseArea{
                    id: _ma
                    hoverEnabled: true //This property affects the containsMouse property and the onEntered, onExited and onPositionChanged signals.
                    width:listView.width
                    height: objItem.implicitHeight
                    enabled: objColumn.children.length > 2
                    onClicked: {
                        isChecked = !isChecked
                        console.log("onClicked..")
                        for(var i = 1; i < parent.children.length - 1; ++i) {
                            console.log("onClicked..i=",i)
                            parent.children[i].visible = !parent.children[i].visible
                        }

                    }
                    Column {
                        id: objItem
                        anchors.fill: parent
                        Rectangle {
                            id:group
                            width: parent.width
                            height: objColumn.titleHeight -1//25
                            color: "#30000000"
                            Item {
                                id: titleIcon
                                anchors.verticalCenter: parent.verticalCenter
                                height: parent.height *0.6
                                width: parent.height *1.4
                                Image {
                                    anchors.centerIn: parent
                                    width: parent.height; height: parent.height;
                                    fillMode: Image.PreserveAspectFit
                                    source: {
                                        if (objColumn.isChecked) {
                                            if(_ma.containsMouse) {
                                                return "qrc:/image/LeftMenu.Reduce.Over.png"
                                            } else {
                                                return "qrc:/image/LeftMenu.Reduce.Nomal.png"
                                            }
                                        } else {
                                            if(_ma.containsMouse) {
                                                return "qrc:/image/LeftMenu.Add.Over.png"
                                            } else {
                                                return "qrc:/image/LeftMenu.Add.Nomal.png"
                                            }
                                        }
                                    }
                                }
                            }


                            Text{
                                text: groupName

                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: -1
                                anchors.left: titleIcon.right
                                font.pixelSize: Math.floor(parent.height *0.55)
                                font.family: objColumn.fontFamily
                                color: (_ma.containsMouse)? objColumn.fontColor3: objColumn.fontColor2
                            }
                            Item {
                                id: titleIcon2
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                height: parent.height
                                width: parent.height *1.4
                                Text{
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.verticalCenterOffset: -1
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text:(objColumn.isChecked)?"\u25bc": "\u25c0"
                                    font.family: "Arial"
                                    font.pixelSize: Math.floor(parent.height *0.55)
                                    color: (_ma.containsMouse)? "#8ABC2F": "#CCCCCC"
                                }
                            }
                        }
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: "black"
                        }
                    }
                }
                Repeater {

                   model: subNode
                    Column{
                        id: subObjColumn
                        property bool subIsChecked: false
                        Component.onCompleted: {
                            for(var i = 1; i < subObjColumn.children.length - 1; ++i) {
                                subObjColumn.children[i].visible = false
                            }
                        }
                        Item {
                            id:toggleModel
                            width: listView.width
                            height: subObjItem.implicitHeight
                            property int settingPageHeight: 20
                            property int cellHeight: 36 *appWindow.zoomRate
                            property url source0: "../image/LeftMenu.Video.Nomal.png"
                            property url source1: "../image/LeftMenu.Video.Over.png"



                            Column {
                                id: subObjItem
                                Rectangle{

                                    width: toggleModel.width
                                    height: toggleModel.cellHeight -1
                                    color: "#10000000"
                                    y:0


                                    Item {
                                        id: dragItem
                                        width: parent.width
                                        height: parent.height
                                        property int _index: index
                                        property string _fileName: fileName
                                        //Drag.keys: ["TEST"] //對應subObjItem中的mimeData
//                                        Drag.active: _ms.drag.active
//                                        Drag.dragType: Drag.Automatic //拖動類型//Drag.Internal,Drag.Automatic
//                                        Drag.supportedActions: Qt.CopyAction
                                        Drag.active: _ms.drag.active
                                        Drag.onDragStarted: {
                                            console.log("1 need2ChangeColor=",file_name.need2ChangeColor)
                                            for (var i=0;i<9;i++){
                                                console.log("array[0]=",appWindow.arrayCH[0]);
                                                if(appWindow.arrayCH[0] === fileName) {
                                                   file_name.need2ChangeColor=true;
                                                }
                                            }
                                            console.log("2 need2ChangeColor=",file_name.need2ChangeColor)
                                        }
                                        Drag.mimeData: {"index":index,"fileName":fileName}
                                        Drag.hotSpot.x: _ms.mouseX
                                        Drag.hotSpot.y: _ms.mouseY
                                        Item {
                                            id:cellIcon
                                            height: parent.height *0.6
                                            width: parent.height *1.4
                                            x: parent.height
                                            anchors.verticalCenter: parent.verticalCenter
                                            Image {
                                                id: videoIcon
                                                anchors.centerIn: parent
                                                width: parent.height
                                                height: parent.height
                                                fillMode: Image.PreserveAspectFit
                                                source: (fileIsChecked || _ms.containsMouse)? toggleModel.source1: toggleModel.source0
                                            }
                                        }
                                        Text {
                                            id:file_name
                                            text:fileName
                                            anchors.left: cellIcon.right
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.verticalCenterOffset: -1
                                            font.family: objColumn.fontFamily
                                            font.pixelSize: Math.floor(parent.height *0.55)
                                            color:  (fileIsChecked || _ms.containsMouse)? objColumn.fontColor1: objColumn.fontColor0
                                        }
                                        MouseArea {
                                            id: _ms
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            drag.target: parent
                                            onClicked: {

                                            }
                                            onPressed: {
                                                console.log("onPressed");
//                                                parent.Drag.active = true;//被拖動的物件產生一個拖動進入事件
//                                                parent.Drag.startDrag(Qt.CopyAction);
                                                parent.Drag.start(Qt.CopyAction);


                                            }
                                            onReleased: {
                                                console.log("onReleased");
                                                parent.Drag.drop();
//                                                parent.Drag.active = false; //產生拖動離開事件
                                                    parent.x = 0;
                                                    parent.y = 0;




                                            }

                                        }
                                    }
                                    Image {
                                        id:settingButton
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom
                                        anchors.topMargin: 2
                                        anchors.bottomMargin: 2
                                        width:height
                                        source:(isSetting | settingMouseArea.containsMouse)? "../image/Schedule.Setting.Button.Nomal.png":"../image/Schedule.Setting.Button.Disable.png"
                                        property bool isSetting: false

                                        MouseArea{
                                            id:settingMouseArea
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            onClicked: {
                                                settingButton.isSetting = !settingButton.isSetting;
                                            }
                                        }
                                    }
                                }
                                Rectangle{
                                    id: propertyRect
                                    width: toggleModel.width
                                    height: toggleModel.settingPageHeight
                                    color: "#000000"
                                    visible: settingButton.isSetting
                                    Text {
                                          anchors.fill: parent
                                          anchors.leftMargin: 2
                                          anchors.rightMargin: 2
                                          font.pixelSize: 10
                                          font.bold: false
                                          anchors.verticalCenter: parent.verticalCenter
                                          color: "white"
                                          text: path
                                          verticalAlignment: Text.AlignVCenter
                                          horizontalAlignment: Text.AlignLeft

                                    }

                                }
                                Rectangle{
                                    width: toggleModel.width
                                    height: 1
                                    color: "black"
                                }
                                Text {
                                    id:videoIsChecked
                                    property bool videoIsChecked: fileIsChecked
                                    text:fileIsChecked
                                    visible:false
                                }
                            }
                        }




                   }

                }
            }

        }
}

// videoList_Live END
