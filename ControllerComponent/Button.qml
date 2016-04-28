import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    width: 100
    height: 100
    property bool pushed: false
    property color colorPushed: "red"
    property color colorUnpushed: "Blue"
    color: "transparent"

    Rectangle {
        id: button
        width: root.width *0.9
        height: root.height *0.9
        radius: width * 0.4
        color: colorUnpushed
    }
    DropShadow {
        id: shadow
        anchors.fill: button
        cached: true
        horizontalOffset: root.width * 0.1
        verticalOffset: root.height * 0.1
        //radius: 8.0
        samples: 16
        color: "#80000000"
        smooth: true
        source: button
    }

    onPushedChanged: {
        //console.log(pushed)
        if(pushed == true) {
            buttonState.state = "on"
        } else {
            buttonState.state = "off"
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            pushed = !pushed
        }
    }
    StateGroup{
        id: buttonState
        state: "off"    // default state is off
        states: [
            State {
                name: "off"
                PropertyChanges {
                    target: button
                    color: colorUnpushed
                }
                PropertyChanges {
                    target: shadow
                    visible: true
                }
            },
            State {
                name: "on"
                PropertyChanges {
                    target: button
                    color: colorPushed
                    x: root.width * 0.1
                    y: root.height * 0.1
                }
                PropertyChanges {
                    target: shadow
                    visible: false
                }
            }
        ]
    }
}
