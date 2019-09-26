import QtQuick 2.0

Item {
    id:channel_list
    ListModel {
        id:listModel
    }
    Component.onCompleted: {
        for (var i=0;i<9;i++)
            addModelData("Group 1","CH0"+(i+1),false,"rtsp://root:root@10.10.80.114:"+(554+i*2)+"/session0.mpg")
    }
    function addModelData(groupName,fileName,fileIsChecked,path){
        var index = findIndex(groupName)
        if(index === -1){
            listModel.append({"groupName":groupName,"level":0,
                                 "subNode":[{"fileName":fileName,"fileIsChecked":fileIsChecked,"path":path,"level":1,"subNode":[]}]})
        }
        else{
            listModel.get(index).subNode.append({"fileName":fileName,"fileIsChecked":fileIsChecked,"path":path,"level":1,"subNode":[]})
        }

    }

    function findIndex(name){
        for(var i = 0 ; i < listModel.count ; ++i){
            if(listModel.get(i).groupName === name){
                return i
            }
        }
        return -1
    }
}
