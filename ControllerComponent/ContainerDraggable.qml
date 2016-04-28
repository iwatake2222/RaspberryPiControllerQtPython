import QtQuick 2.0

Rectangle {
    id: container
    default property alias data : inner_space.data
    property alias caption: caption.text
    border.color: "LightBlue"
    border.width: 4
    radius: 10
    width: content.childrenRect.width + border.width * 2
    height: content.childrenRect.height + border.width * 2

    MouseArea {
        id: dragArea
        anchors.fill: content
        drag.target: container
        onPressed: {
            // todo: doesn't work...
            parent.z = parent.z + 1
        }
    }

    Column {
        id: content
        x: container.border.width
        y: container.border.width
        Text {
            id: caption
            text: " "
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            id: inner_space
        }
//        Rectangle {
//            id: aefea
//            width: 200
//            height: 200
//            color: "green"
//        }
    }


    function addContent(componentStr) {
        var newObject = Qt.createQmlObject(componentStr,
                                           content,
                                           "dynamicComponent");
    }
}

