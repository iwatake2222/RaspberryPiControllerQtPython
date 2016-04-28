import QtQuick 2.0

Rectangle {
    id: root
    width: 100
    height: width
    property color colorUntapped: "Gray"
    property color colorSingleTapped: "Cyan"
    property color colorDoubleTapped: "Blue"
    //color: "red"

    Rectangle {
        id: circle0
        width: root.width*0.5
        height: width
        x: root.width/2 - width/2
        y: x
        radius: width * 0.5
        color: colorUntapped
    }

    Rectangle {
        id: circle1
        width: root.width*0.7
        height: width
        x: root.width/2 - width/2
        y: x
        radius: width * 0.5
        color: "transparent"
        border.color: colorUntapped
        border.width: 4
    }
    Rectangle {
        id: circle2
        width: root.width*0.9
        height: width
        x: root.width/2 - width/2
        y: x
        radius: width * 0.5
        color: "transparent"
        border.color: colorUntapped
        border.width: 4
    }

    Timer {
        id: timerReset
        interval: 1000
        running: false
        repeat: false
        onTriggered: {
            circle0.color = colorUntapped
            circle1.border.color = colorUntapped
            circle2.border.color = colorUntapped
        }
    }

    function singleTap() {
        circle0.color = colorSingleTapped
        circle1.border.color = colorSingleTapped
        timerReset.start()
    }

    function doubleTap() {
        circle0.color = colorDoubleTapped
        circle1.border.color = colorDoubleTapped
        circle2.border.color = colorDoubleTapped
        timerReset.start()
    }
}
