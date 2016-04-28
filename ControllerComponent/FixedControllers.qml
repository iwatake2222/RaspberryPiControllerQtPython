import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    id: root
    visible: true
    width: 1800
    height: 1800
    Row {
        anchors.centerIn: parent
        spacing: 50
        Column {
            spacing: 5
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                text: qsTr("Output: LED")
            }
            Row {
                spacing: 10
                Switch{
                    id: switch0
                    width: 100
                    height: 200
                    onClicked: {
                        console.log("[User] switch0: " + state)
                    }
                }
                Switch{
                    id: switch1
                    width: 100
                    height: 200
                    colorCircleOn: "red"
                    onClicked: {
                        console.log("[User] switch1: " + state)
                    }
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                text: qsTr("Output: 3 Color LED")
            }
            Row {
                spacing: 10
                SeekBar {
                    id: seekBarRed
                    rotation: 180
                    colorCircle: "red"
                    onValueChanged: {
                        console.log("[main] SeekBar Red: " + value)
                    }
                }
                SeekBar {
                    id: seekBarGreen
                    rotation: 180
                    colorCircle: "green"
                    onValueChanged: {
                        console.log("[main] SeekBar Green: " + value)
                    }
                }
                SeekBar {
                    id: seekBarBlue
                    rotation: 180
                    colorCircle: "blue"
                    onValueChanged: {
                        console.log("[main] SeekBar Blue: " + value)
                    }
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                text: qsTr("Output: Motor PWM")
            }
            Row {
                spacing: 10
                SeekBar {
                    id: seekBarMotor
                    rotation: 180
                    value: 0
                    min: 0
                    max: 100
                    colorCircle: "Gold"
                    onValueChanged: {
                        console.log("[main] SeekBar Motor: " + value)
                        rotator.stop()
                        if(value != 0){
                            rotator.speed = value
                            rotator.start()
                        }
                    }
                }
                Rotator {
                    id: rotator
                    mainColor: "Gold"
                    anchors.verticalCenter: seekBarMotor.verticalCenter
                    speed: 0
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                text: qsTr("Output: Servo")
            }
            Row {
                spacing: 10
                SeekBar {
                    id: seekBarServo
                    rotation: 180
                    value: 0
                    min: 0
                    max: 100
                    colorCircle: "Purple"
                    onValueChanged: {
                        console.log("[main] SeekBar Servo: " + value)
                    }
                }

            }
        }

        Column {
            spacing: 10
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                text: qsTr("Input: Button")
            }
            Row {
                spacing: 10
                Button {
                    id: button0
                    onPushedChanged: {
                       console.log("[main] Button 0: " + pushed)
                    }
                }
                Button {
                    id: button1
                    onPushedChanged: {
                       console.log("[main] Button 1: " + pushed)
                    }
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                text: qsTr("Input: Rotary Encoder")
            }

            Rotator {
                id: rotaryEncoder
                speed: 0
            }


            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                text: qsTr("Input: Tap")
            }
            Tap {
                id: tap
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                text: qsTr("Input: G sensor")
            }
            Object3D {
                id: object3D
            }

        }

        Rectangle {
            width: 200
            height: 200
            color: "blue"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    rotaryEncoder.rotation+=10
                    button0.pushed = !button0.pushed
                    tap.singleTap()
                    object3D.rotate(30,80,30)
                }
            }
        }

        ContainerDraggable {
            caption: "aaa"
            Button {
                id: button02
                onPushedChanged: {
                   console.log("[main] Button 0: " + pushed)
                }
            }
            Button {
                id: button023
                onPushedChanged: {
                   console.log("[main] Button 0: " + pushed)
                }
            }
        }

    }

}
