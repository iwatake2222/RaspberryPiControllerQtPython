import QtQuick 2.0

Rectangle {
    property color colorBack: "DarkGray"
    property color colorCircleOn: "LightGreen"
    property color colorCircleOff: "Gray"
    signal clicked(bool state)
    id: root
    width: 40
    height: 80
    color: colorBack
    radius: width/2

    Rectangle {
        id: circle
        width: parent.width
        height: width
        color: colorCircleOff
        radius: width/2
    }

    onClicked: {
        console.log("[Comp] switch: " + state)
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            switch(switchState.state){
            case "off":
                switchState.state = "on"
                root.clicked(true)
                break
            case "on":
            default:
                switchState.state = "off"
                root.clicked(false)
                break
            }
        }
    }

    StateGroup{
        id: switchState
        state: "off"    // default state is off
        states: [
            State {
                name: "off"
                PropertyChanges {
                    target: circle
                    color: colorCircleOff
                    y: root.height - height
                }
            },
            State {
                name: "on"
                PropertyChanges {
                    target: circle
                    color: colorCircleOn
                    y: 0

                }
            }
        ]
        transitions: [
            Transition {
                NumberAnimation {
                    target: circle
                    property: "y"
                    duration: 200
                    easing.type: Easing.InOutBounce
                }
                ColorAnimation {
                    target: circle
                    property: "color"
                    duration: 200
                }
            }

        ]
    }
}
