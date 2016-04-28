import QtQuick 2.0

Rectangle {
    id: root
    width: 100
    height: 100
    color: "transparent"
    property color mainColor: "Black"
    property int speed: 0
    property int speedMax: 100
    property int speedMaxDuration: 5000

    Item {
        id: inner
        property int rotatorBold: root.width * 0.1
    }

    Rectangle {
        id: rect0
        x: 0
        y: root.height / 2 - height / 2
        width: root.width
        height: inner.rotatorBold
        color: root.mainColor
    }
    Rectangle {
        id: rect1
        x: 0
        y: root.height / 2 - height / 2
        rotation: 90
        width: root.width
        height: inner.rotatorBold
        color: root.mainColor
    }


    NumberAnimation {
        id: anim
        target: root
        property: "rotation"
        from: 0
        to: 360
        duration: speedMaxDuration * (1 - speed / (speedMax+1))
        //running: true
        loops: Animation.Infinite
    }

    function stop() {
        anim.stop()
    }

    function start() {
        anim.start()
    }
}
