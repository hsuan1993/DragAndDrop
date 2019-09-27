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


                                }
                            }

                            DropArea{//拖移區域
                                id:dropArea
                                anchors.fill: parent
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
