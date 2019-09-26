import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.12
import QtQuick.Layouts 1.12

Window {
    id: appWindow
    visible: true
    width: 1366
    height: 768
    title: qsTr("Hello World")
    property real zoomRate: Math.min(width /1920, height /1080)



    Rectangle
    {
        id: line1
        y: parent.height *60 /1080; width: parent.width; height: 1; color: "#000000";
    }

    Rectangle
    {
        id: line2
        x: parent.width *300 /1920; height: parent.height; width: 1; color: "#000000";
    }
    Rectangle
    {
        id: bgFiller3
        anchors.left: parent.left; anchors.right: line2.left; anchors.top: line1.bottom; anchors.bottom: parent.bottom;
        color: "#2F2F2F";
    }
    Rectangle
    {
        id: bgFiller4
        anchors.left: line2.right
        anchors.right: parent.right
        anchors.top: line1.bottom
        anchors.bottom: parent.bottom;
        color: "#252525";
    }

    Item {
        id:videoList_Live
        anchors.fill: bgFiller3
        LeftMeun {
            id:myTree
            anchors.fill: parent
            model: channelList
        }
        ListModel {
            id:channelList
            Component.onCompleted: {
                for (var i=0;i<9;i++) {
                    addModelData("Group 1","CH0"+(i+1),false,"rtsp://root:root@10.10.80.114:"+(554+i*2)+"/session0.mpg")
                console.log(i)
                }
            }
            function addModelData(groupName,fileName,fileIsChecked,path){
                var index = findIndex(groupName)
                if(index === -1){
                    channelList.append({"groupName":groupName,"level":0,
                                         "subNode":[{"fileName":fileName,"fileIsChecked":fileIsChecked,"path":path,"level":1,"subNode":[]}]})
                }
                else{
                    channelList.get(index).subNode.append({"fileName":fileName,"fileIsChecked":fileIsChecked,"path":path,"level":1,"subNode":[]})
                }

            }

            function findIndex(name){
                for(var i = 0 ; i < channelList.count ; ++i){
                    if(channelList.get(i).groupName === name){
                        return i
                    }
                }
                return -1
            }
        }
    }

//    Item {
//        id: videoList_Live
//        anchors.fill: bgFiller3

//        ListView{
//            id:listView
//            anchors.fill: parent
//            //anchors.top: parent.top
//            //anchors.topMargin:5
//            //spacing: 7
//            model: ListModel{
//                id:listModel
//            }
//            delegate: list_delegate

//        }

//        Component.onCompleted: {
//            for (var i=0;i<9;i++)
//                addModelData("Group 1","CH0"+(i+1),false,"rtsp://10.10.80.114:"+(554+i*2)+"/session0.mpg")
//            addModelData("Group 2","CH01",false,"rtsp://10.10.80.114:554/session0.mpg")
//            addModelData("Group 2","CH02",false,"rtsp://10.10.80.114:556/session0.mpg")
//            addModelData("Group 3","CH03",false,"rtsp://10.10.80.114:558/session0.mpg")
//            addModelData("Group 2","CH04",false,"rtsp://10.10.80.114:560/session0.mpg")
//            addModelData("Group 2","CH05",false,"rtsp://10.10.80.114:562/session0.mpg")
//            addModelData("Group 3","CH06",false,"rtsp://10.10.80.114:564/session0.mpg")
//            addModelData("Group 3","CH07",false,"rtsp://10.10.80.114:566/session0.mpg")
//            addModelData("Group 3","CH08",false,"rtsp://10.10.80.114:568/session0.mpg")
//            addModelData("Group 3","CH09",false,"rtsp://10.10.80.114:570/session0.mpg")
//        }

//        function addModelData(groupName,fileName,fileIsChecked,path){
//            var index = findIndex(groupName)
//            if(index === -1){
//                listModel.append({"groupName":groupName,"level":0,
//                                     "subNode":[{"fileName":fileName,"fileIsChecked":fileIsChecked,"path":path,"level":1,"subNode":[]}]})
//            }
//            else{
//                listModel.get(index).subNode.append({"fileName":fileName,"fileIsChecked":fileIsChecked,"path":path,"level":1,"subNode":[]})
//            }

//        }

//        function findIndex(name){
//            for(var i = 0 ; i < listModel.count ; ++i){
//                if(listModel.get(i).groupName === name){
//                    return i
//                }
//            }
//            return -1
//        }

//        Component{
//                id:list_delegate

//                Column{
//                    id: objColumn
//                    property bool isChecked: false
//                    Component.onCompleted: {
//                        for(var i = 1; i < objColumn.children.length - 1; ++i) {
//                            objColumn.children[i].visible = false
//                        }
//                    }
//                    MouseArea{
//                        id: _ma
//                        hoverEnabled: true //This property affects the containsMouse property and the onEntered, onExited and onPositionChanged signals.
//                        width:listView.width
//                        height: objItem.implicitHeight
//                        enabled: objColumn.children.length > 2
//                        onClicked: {
//                            isChecked = !isChecked
//                            console.log("onClicked..")
//                            for(var i = 1; i < parent.children.length - 1; ++i) {
//                                console.log("onClicked..i=",i)
//                                parent.children[i].visible = !parent.children[i].visible
//                            }

//                        }
//                        Column {
//                            id: objItem
//                            anchors.fill: parent
//                            Rectangle {
//                                id:group
//                                width: parent.width
//                                height: 25
//                                color: "#30000000"
//                                Image {
//                                    id:titleIcon
//                                    x: parent.height
//                                    anchors.verticalCenter: parent.verticalCenter
//                                    source: {
//                                        if (objColumn.isChecked) {
//                                            if(_ma.containsMouse) {
//                                                return "qrc:/image/LeftMenu.Reduce.Over.png"
//                                            } else {
//                                                return "qrc:/image/LeftMenu.Reduce.Nomal.png"
//                                            }
//                                        } else {
//                                            if(_ma.containsMouse) {
//                                                return "qrc:/image/LeftMenu.Add.Over.png"
//                                            } else {
//                                                return "qrc:/image/LeftMenu.Add.Nomal.png"
//                                            }
//                                        }
//                                    }
//                                }
//                                Text{
//                                    text: groupName
//                                    x: titleIcon.x *2
//                                    anchors.verticalCenter: parent.verticalCenter
//                                    font.pixelSize: Math.floor(25 *0.55)
//                                    font.family: "consolas"
//                                    color: (_ma.containsMouse)? "#8ABC2F": "#CCCCCC"
//                                }
//                                Item {
//                                    id: titleIcon2
//                                    anchors.verticalCenter: parent.verticalCenter
//                                    anchors.right: parent.right
//                                    width: titleIcon.width
//                                    height: titleIcon.height
//                                    Text{
//                                        anchors.verticalCenter: parent.verticalCenter
//                                        anchors.verticalCenterOffset: -1
//                                        anchors.horizontalCenter: parent.horizontalCenter
//                                        text:(objColumn.isChecked)?"\u25bc": "\u25c0"
//                                        font.family: "Arial"
//                                        font.pixelSize: Math.floor(parent.height)
//                                        color: (_ma.containsMouse)? "#8ABC2F": "#CCCCCC"
//                                    }
//                                }
//                            }
//                            Rectangle {
//                                width: parent.width
//                                height: 1
//                                color: "black"
//                            }
//                        }

///*
//                        Row{
//                            id:objItem
//                            //spacing: 5
//                            leftPadding: 20
//                            Item {
//                                id: titleIcon
//                                //anchors.verticalCenter: parent.verticalCenter
//                                anchors.top: parent.top
//                                anchors.topMargin:5
//                                height: parent.height *0.4
//                                width: parent.height *1.4
//                                Image {
//                                    id: icon
//                                    height:14
//                                    width: height
//                                    //anchors.verticalCenter: parent.verticalCenter
//                                    anchors.centerIn: parent
//                                    source: {
//                                        if (objColumn.isChecked) {
//                                            if(_ma.containsMouse) {
//                                                return "qrc:/image/LeftMenu.Reduce.Over.png"
//                                            } else {
//                                                return "qrc:/image/LeftMenu.Reduce.Nomal.png"
//                                            }
//                                        } else {
//                                            if(_ma.containsMouse) {
//                                                return "qrc:/image/LeftMenu.Add.Over.png"
//                                            } else {
//                                                return "qrc:/image/LeftMenu.Add.Nomal.png"
//                                            }
//                                        }
//                                    }



//                                }
//                            }
////                            Image {
////                                id: icon
////                                height:14
////                                width: height
////                                //anchors.verticalCenter: parent.verticalCenter
////                                anchors.centerIn: parent
////                                source: {
////                                    if (objColumn.isChecked) {
////                                        if(_ma.containsMouse) {
////                                            return "qrc:/image/LeftMenu.Reduce.Over.png"
////                                        } else {
////                                            return "qrc:/image/LeftMenu.Reduce.Nomal.png"
////                                        }
////                                    } else {
////                                        if(_ma.containsMouse) {
////                                            return "qrc:/image/LeftMenu.Add.Over.png"
////                                        } else {
////                                            return "qrc:/image/LeftMenu.Add.Nomal.png"
////                                        }
////                                    }
////                                }

////                            }
//                            Label{
//                                id:group_name
//                                text: groupName
////                                font.pixelSize: fontSizeLarge
//                                font.pixelSize: Math.floor(25 *0.55)
//                                font.family: "consolas"
//                                color: (_ma.containsMouse)? "#8ABC2F": "#CCCCCC"
//                                anchors.verticalCenter: parent.verticalCenter
//                            }
////                            Label{
////                                text: date
////                                font.pixelSize: fontSizeMedium
////                                font.family: "consolas"
////                                color: (_ma.containsMouse)? "#8ABC2F": "#CCCCCC"
////                                anchors.verticalCenter: parent.verticalCenter

////                            }

//                        }
//*/
//                    }
//                    Repeater {

//                       model: subNode
//                        Column{
//                            id: subObjColumn
//                            property bool subIsChecked: false
//                            Component.onCompleted: {
//                                for(var i = 1; i < subObjColumn.children.length - 1; ++i) {
//                                    subObjColumn.children[i].visible = false
//                                }
//                            }

//                            MouseArea{
//                                id: _subma
//                                hoverEnabled: true
//                                width: listView.width
//                                height: subObjItem.implicitHeight
//                                enabled: subObjColumn.children.length > 2


//                                Column {
//                                    id: subObjItem
//                                    anchors.fill: parent
//                                    property int _index: index
//                                   //Drag.dragType: Drag.Internal //Drag.Automatic
//                                   Drag.onDragStarted: console.log("onDragStarted");
//                                   Drag.mimeData: {"index": index}
//                                   Drag.keys: [index];
//                                   //Drag.keys: [index];
//                                   //Drag.active: _ms.drag.active
//                                   Drag.hotSpot.x: _ms.mouseX
//                                   Drag.hotSpot.y: _ms.mouseY

//                                    Rectangle {
//                                      id: rect
//                                      width: parent.width
//                                      height:25
//                                      color: bgFiller3.color
//                                      Rectangle {
//                                          id: drag_item
//                                          height: parent.height

//                                          Image {
//                                              id: videoImage
//                                              x: parent.height * 2
//                                              anchors.verticalCenter: parent.verticalCenter
//                                              source: (fileIsChecked || _ms.containsMouse)? "qrc:/image/LeftMenu.Video.Over.png": "qrc:/image/LeftMenu.Video.Nomal.png"
//                                              //isChecked = input value, video source is open or not
//                                          }
//                                          Text {
//                                              id:file_name
//                                              text:fileName
//                                              anchors.verticalCenter: parent.verticalCenter
//                                              x: videoImage.x *1.6
//                                              font.family: "consolas"
//                                              font.pixelSize: Math.floor(parent.height *0.55)
//                                              color: (fileIsChecked || _ms.containsMouse)? "#FFFFFF": "#777777"
//                                          }
//                                      }
//                                     MouseArea
//                                     {
//                                         id: _ms
//                                         anchors.fill: parent
//                                         hoverEnabled: true
//                                         onClicked:
//                                         {
//                                             if (fileIsChecked) {
//                                                 fileIsChecked = false;
//      //                                           removeCheck(index);
//                                             }
//                                         }
//                                         onPressed:
//                                         {
//                                             drag_item.Drag.active = true;
//                                             //parent.Drag.startDrag(Qt.CopyAction);
//                                             toggleModel.isDragging = true;
//                                             subObjItem.Drag.start(Qt.CopyAction);
//                                         }
//                                         onReleased:
//                                         {
//                                             console.log("onReleased");
//                                             drag_item.Drag.drop();
//                                             drag_item.Drag.active = false;
//                                             drag_item.x = 0;
//                                             drag_item.y = 0;
//                                             subObjItem.isDragging = false;
//                                         }

//                                         drag.target: drag_item
//                                    }

//                                      Image {
//                                          id: settingImage
//                                          anchors.right: parent.right
//                                          //anchors.top: parent.top
//                                          //anchors.bottom: parent.bottom
//                                          anchors.verticalCenter: parent.verticalCenter
//                                          height:20
//                                          width: height
//                                          source: (isSetting | setting_ma.containsMouse) ? "../image/Schedule.Setting.Button.Nomal.png":"../image/Schedule.Setting.Button.Disable.png"
//                                          property bool isSetting: false
//                                             MouseArea {
//                                                 id: setting_ma
//                                                 anchors.fill: parent
//                                                 hoverEnabled: true
//                                                 onClicked: {
//                                                     settingImage.isSetting = !settingImage.isSetting;
//                                                     if (settingImage.isSetting) {
//                                                         propertyRect.visible = true
//                                                     }
//                                                     else {
//                                                         propertyRect.visible = false
//                                                     }
//                                                 }
//                                             }
//                                      }
//                                    }

//                                    Rectangle {
//                                      id: propertyRect
//                                      width: parent.width
//                                      height: 20
//                                      color: "#000000"
//                                      visible: false
//                                      Text {
//                                          font.family: "consolas"
//                                          font.pixelSize: 9
//                                          anchors.verticalCenter: parent.verticalCenter
//                                        //  anchors.fill: parent
//                                          //anchors.leftMargin: 2
//                                          //anchors.rightMargin: 2
//                                         // font.pixelSize: 10
//                                         // font.bold: false
//                                          color: "white"
////                                          text: "rtsp://10.10.80.114:"+(index*2+554)+"/session0.mpg"
//                                          text: path
//                                          verticalAlignment: Text.AlignVCenter
//                                          horizontalAlignment: Text.AlignLeft
//                                          //visible:settingButton.isSetting
//                                      }

//                                    }
//                                  Rectangle {
//                                      width: parent.width
//                                      height: 1
//                                      color: "black"
//                                  }
//                                }
//                            }


//                       }

//                    }
//                }

//            }


////        Component{
////                id:list_delegate

////                Column{
////                    id: objColumn
////                    property bool isChecked: false
////                    Component.onCompleted: {
////                        for(var i = 1; i < objColumn.children.length - 1; ++i) {
////                            objColumn.children[i].visible = false
////                        }
////                    }

////                    MouseArea{
////                        id: _ma
////                        hoverEnabled: true //This property affects the containsMouse property and the onEntered, onExited and onPositionChanged signals.
////                        width:listView.width
////                        height: objItem.implicitHeight
////                        enabled: objColumn.children.length > 2
////                        onClicked: {
////                            isChecked = !isChecked
////                            console.log("onClicked..")
////                            var flag = false;
////                            for(var i = 1; i < parent.children.length - 1; ++i) {
////                                console.log("onClicked..i=",i)
////                                flag = parent.children[i].visible;
////                                parent.children[i].visible = !parent.children[i].visible
////                            }
////                            console.log("onClicked..flag = ",flag)

////                        }
////                        Row{
////                            id:objItem
////                            spacing: 10
////                            leftPadding: 20

////                            Image {
////                                id: icon
////                                source: {
////                                    if (objColumn.isChecked) {
////                                        if(_ma.containsMouse) {
////                                            return "qrc:/image/LeftMenu.Reduce.Over.png"
////                                        } else {
////                                            return "qrc:/image/LeftMenu.Reduce.Nomal.png"
////                                        }
////                                    } else {
////                                        if(_ma.containsMouse) {
////                                            return "qrc:/image/LeftMenu.Add.Over.png"
////                                        } else {
////                                            return "qrc:/image/LeftMenu.Add.Nomal.png"
////                                        }
////                                    }
////                                }

////                                anchors.verticalCenter: parent.verticalCenter

////                            }
////                            Label{
////                                id:group_name
////                                text: groupName
////                                font.pixelSize: fontSizeMedium
////                                color: (_ma.containsMouse)? "#8ABC2F": "#CCCCCC"
////                                anchors.verticalCenter: parent.verticalCenter
////                            }
////                            Label{
////                                text: date
////                                font.pixelSize: fontSizeMedium
////                                color: (_ma.containsMouse)? "#8ABC2F": "#CCCCCC"
////                                anchors.verticalCenter: parent.verticalCenter

////                            }
////                        }
////                    }
////                    Repeater {
////                       model: subNode

////                       delegate: Rectangle{
////                           width: parent.width
////                           height: 30
////                           color: "#10000000"
////                           y:0

////                           Item
////                           {
////                               id: dragableItem
////                               width: parent.width
////                               height: parent.height
////                               property int _index: index
//////                               //Drag.dragType: Drag.Internal //Drag.Automatic
//////                               Drag.onDragStarted: console.log("onDragStarted");
//////                               Drag.mimeData: {"index": index}
//////                               Drag.keys: [index];
//////                               //Drag.keys: [index];
//////                               //Drag.active: _ms.drag.active
//////                               Drag.hotSpot.x: _ms.mouseX
//////                               Drag.hotSpot.y: _ms.mouseY
////                               Item
////                               {
////                                   id: cellIcon
////                                   anchors.verticalCenter: parent.verticalCenter
////                                   height: parent.height *0.6
////                                   width: parent.height *1.4
////                                   x: parent.height
////                                   Image
////                                   {
////                                       anchors.centerIn: parent
////                                       width: parent.height; height: parent.height;
////                                       fillMode: Image.PreserveAspectFit
////                                       source: (isChecked || _ms.containsMouse)? "qrc:/image/LeftMenu.Video.Over.png": "qrc:/image/LeftMenu.Video.Nomal.png"
////                                   }
////                               }
////                               Text
////                               {
////                                   anchors.verticalCenter: parent.verticalCenter
////                                   anchors.verticalCenterOffset: -1
////                                   anchors.left: cellIcon.right
////                                   text: fileName
////                                   font.family: fontFamily
////                                   font.pixelSize: Math.floor(parent.height *0.55)
////                                   color: (isChecked || _ms.containsMouse)? "#FFFFFF": "#777777"
////                               }
////                               MouseArea
////                               {
////                                   id: _ms
////                                   anchors.fill: parent
////                                   hoverEnabled: true
////                                   onClicked:
////                                   {
////                                       if (isChecked) {
////                                           isChecked = false;
//////                                           removeCheck(index);
////                                       }
////                                   }
//////                                   onPressed:
//////                                   {
//////                                       parent.Drag.active = true;
//////                                       //parent.Drag.startDrag(Qt.CopyAction);
//////                                       toggleModel.isDragging = true;
//////                                       parent.Drag.start(Qt.CopyAction);
//////                                   }
//////                                   onReleased:
//////                                   {
//////                                       console.log("onReleased");
//////                                       parent.Drag.drop();
//////                                       parent.Drag.active = false;
//////                                       parent.x = 0;
//////                                       parent.y = 0;
//////                                       toggleModel.isDragging = false;
//////                                   }

//////                                   drag.target: parent
////                               }
////                           }

////                           Image {
////                               id: settingBtn
////                               anchors.right: parent.right
////                               anchors.top: parent.top
////                               anchors.bottom: parent.bottom
////                               anchors.topMargin: 2
////                               anchors.bottomMargin: 2

////                               property bool isSetting: false
////                               width: height
////                               source:(isSetting | setting_ma.containsMouse) ? "../image/Schedule.Setting.Button.Nomal.png":"../image/Schedule.Setting.Button.Disable.png"

////                               MouseArea {
////                                   id: setting_ma
////                                   anchors.fill: parent
////                                   hoverEnabled: true
////                                   onClicked: {
////                                       settingBtn.isSetting = !settingBtn.isSetting;
////                                   }
////                               }

////                           }
////                           Rectangle {
////                              id: propertyRect
////                              width: parent.width
////                              height: settingBtn.isSetting? 20: 1
////                              color: "#000000"
////                              y: parent.height
////                           }

////                       }

////                    }
////                }
////            }

   //}

//// videoList_Live END


    Item
    {

        id: videoWs
        anchors.fill: bgFiller4

        Item {
            id: videoLayoutWidget
            anchors.fill: parent
            property int layoutType: 0
            property int contentWidth: Math.min(parent.width , parent.height*16/9)*0.98
            property int contentHeight: contentWidth *9 /16
            property int widthSpacing: parent.width -contentWidth
            property int heightSpacing: parent.height -contentHeight

            property int contentWidthSpacing: Math.min(widthSpacing *9 /16, heightSpacing) *16 /36
            property int contentHeightSpacing: contentWidthSpacing *9 /16
            property int contentMinSpacing: Math.min(contentWidthSpacing, contentHeightSpacing)

            property int contentWidth4: Math.min( (contentWidth -contentMinSpacing) *9 /16, (contentHeight -contentMinSpacing) ) *16 /18
            property int contentHeight4: contentWidth4 *9 /16
            property int contentWidth9: Math.min( (contentWidth -contentMinSpacing *2) *9 /16, (contentHeight -contentMinSpacing *2) ) *16 /27
            property int contentHeight9: contentWidth9 *9 /16
            property int contentWidth16: Math.min( (contentWidth -contentMinSpacing *3) *9 /16, (contentHeight -contentMinSpacing *3) ) *16 /36
            property int contentHeight16: contentWidth16 *9 /16

            Item {
                id: gridDlg
                width: Math.round(videoLayoutWidget.contentWidth)
                height: Math.round(videoLayoutWidget.contentHeight)
                x: Math.round(videoLayoutWidget.widthSpacing /2)
                y: Math.round(videoLayoutWidget.heightSpacing /2)
                //color: bgFiller4.color

                GridLayout {
                    id : grid
                    anchors.fill: parent
                    rows    : 12
                    columns : 12
                    property double colMulti : grid.width / grid.columns
                    property double rowMulti : grid.height / grid.rows
                    function prefWidth(item){
                        return colMulti * item.Layout.columnSpan
                    }
                    function prefHeight(item){
                        return rowMulti * item.Layout.rowSpan
                    }

                    Repeater {
                        model:4
                        Rectangle {
                            id :dlg
                            color : "black"
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            Layout.rowSpan   : {
                                if (index < 4) {
                                    switch(index) {
                                        case 0:
                                            return 12
                                        case 1:
                                        case 2:
                                        case 3:
                                            return 4
                                    }
                                }
                            }

                            Layout.columnSpan: {
                                    if (index < 4) {
                                        switch(index) {
                                        case 0:
                                            return 8
                                        case 1:
                                        case 2:
                                        case 3:
                                            return 4
                                        }
                                    }
                            }
                            Layout.preferredWidth  : grid.prefWidth(this)
                            Layout.preferredHeight : grid.prefHeight(this)

                            border.color: "#8ABC2F"
                            border.width: (dropArea.containsDrag)? 2: 0

                            property string titleName: "CH01"//+padLeft(index+1,2)
                            property int targetChannel: 0 //index

                            Rectangle {
                                anchors.fill: parent
                                color: "transparent"
                                Image {
                                    id:livePreview
                                    anchors.fill:parent

                                    //change & remove channel
//                                    Item {
//                                        id:dragItem
//                                        width: parent.width
//                                        height:parent.height
//                                        property int _index: index
//                                        property string _filename: dlg.titleName
//                                        //Drag.keys: ["TEST"]
//                                        //Drag.mimeData: {"index":index, "filename":dlg.titleName}
//                                        Drag.hotSpot.x:_ms.mouseX
//                                        Drag.hotSpot.y:_ms.mouseY

                                        //show current channel
                                        Text {
                                            id: title_txt
                                            text:dlg.titleName
                                            font.pixelSize: 30
                                            color:"white"
                                        }
                                        //兩個或以上的顏色無接縫混和
                                        LinearGradient  {
                                            anchors.fill: title_txt
                                            source: title_txt
                                            gradient: Gradient {
                                                GradientStop { position: 0; color: "white" }
                                                GradientStop { position: 1; color: "black" }
                                            }
                                        }
//                                        MouseArea {
//                                            id: _ms
//                                            anchors.fill:parent
//                                            hoverEnabled: true
//                                            drag.target: parent
//                                            onClicked: {

//                                            }
//                                            onPressed: {
//                                                console.log("[CW] _change on pressed");
//                                                parent.Drag.active = true;
//                                                parent.Drag.start(Qt.CopyAction);
//                                            }
//                                            onReleased: {
//                                                console.log("[CW] _change on released");
//                                                parent.Drage.drop();
//                                                parent.Drage.active = false;
//                                                parent.x =0;
//                                                parent.y =0;
//                                            }
//                                        }
//                                    }


                                }
                            }

                            DropArea{//拖移區域
                                id:dropArea
                                anchors.fill: parent
                                //keys: ["TEST"]
                                property alias dropProxy: dropArea

                                onDropped: {

                                    console.log("drop source=",drop.source._index," ,Channel=",drop.source._fileName)

                                    if (dlg.targetChannel>=0) {

                                        channelList.get(0).subNode.setProperty(dlg.targetChannel, "fileIsChecked", false);
                                    }
                                    dlg.targetChannel = drop.source._index;
                                    dlg.titleName = drop.source._fileName;

                                    console.log("[CW] dlg.targetChannel=",dlg.targetChannel)

                                    channelList.get(0).subNode.setProperty(dlg.targetChannel, "fileIsChecked", true);


                                }
                                onEntered: {
                                    //dlg.border.color="#8ABC2F"
                                }
                                onExited: {
                                    //滑鼠拖移退出時
                                    //dlg.border.color="white"
                                }
                            }
                        }
                    }




                }
            }

        }

    //videoLayoutWidget END

    }
}
