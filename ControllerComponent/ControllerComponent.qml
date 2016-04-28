import QtQuick 2.0
import QtQuick.Window 2.2
import "WrapperWebApi.js" as Api

Rectangle {
    id: root
    visible: true
    width: main.width * 1.1
    height: main.height * 1.1

    Row {
        id: main
        anchors.centerIn: parent
        spacing: 50
        Column {
            spacing: 5

            ContainerDraggable {
                caption: "Output: LED"
                Row {
                    spacing: 10
                    Switch{
                        id: switch0
                        width: 100
                        height: 200
                        onClicked: {
                            console.log("[User] switch0: " + state)
                            Api.callApiLed(0, state)
                        }
                    }
                    Switch{
                        id: switch1
                        width: 100
                        height: 200
                        colorCircleOn: "red"
                        onClicked: {
                            console.log("[User] switch1: " + state)
                            Api.callApiLed(1, state)
                        }
                    }
                }
            }

            ContainerDraggable {
                caption: "Output: 3 Color LED"
                Row {
                    spacing: 10
                    SeekBar {
                        id: seekBarRed
                        rotation: 180
                        colorCircle: "red"
                        onValueChanged: {
                            console.log("[main] SeekBar Red: " + value)
                            Api.callApiLed3Color(seekBarRed.value, seekBarGreen.value, seekBarBlue.value)
                        }
                    }
                    SeekBar {
                        id: seekBarGreen
                        rotation: 180
                        colorCircle: "green"
                        onValueChanged: {
                            console.log("[main] SeekBar Green: " + value)
                            Api.callApiLed3Color(seekBarRed.value, seekBarGreen.value, seekBarBlue.value)
                        }
                    }
                    SeekBar {
                        id: seekBarBlue
                        rotation: 180
                        colorCircle: "blue"
                        onValueChanged: {
                            console.log("[main] SeekBar Blue: " + value)
                            Api.callApiLed3Color(seekBarRed.value, seekBarGreen.value, seekBarBlue.value)
                        }
                    }
                }
            }

            ContainerDraggable {
                caption: "Output: Motor PWM"
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
                            Api.callApiMotorPwm(value)
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
            }

            ContainerDraggable {
                caption: "Output: Servo"
                SeekBar {
                    id: seekBarServo
                    rotation: 180
                    value: 0
                    min: 0
                    max: 100
                    colorCircle: "Purple"
                    onValueChanged: {
                        console.log("[main] SeekBar Servo: " + value)
                        Api.callApiServo(value)
                    }
                }
            }
        }

        Column {
            spacing: 10
            ContainerDraggable {
                caption: "Input: Button"
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
            }

            ContainerDraggable {
                caption: "Input: Rotary Encoder"
                Rotator {
                    id: rotaryEncoder
                    speed: 0
                }
            }

            ContainerDraggable {
                caption: "Input: Tap"
                Tap {
                    id: tap
                }
            }

            ContainerDraggable {
                caption: "Input: G sensor"
                Object3D {
                    id: object3D
                }
            }

        }

        // debug area
//        Rectangle {
//            width: 200
//            height: 200
//            color: "blue"
//            MouseArea {
//                anchors.fill: parent
//                onClicked: {
//                    rotaryEncoder.rotation+=10
//                    button0.pushed = !button0.pushed
//                    tap.singleTap()
//                    object3D.rotate(30,80,30)
//                }
//            }
//        }
    }

    Timer {
        id: timerMonitoring
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            Api.monitor()
        }
    }

}
