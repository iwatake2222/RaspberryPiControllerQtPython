import QtQuick 2.0

Rectangle {
    id: root
    width: 100
    height: 100
    color: "Cyan"

    Text {
        text: "AAAA\nAAAA\nAAAA"
    }

    transform: [
        Rotation {
            id: rotateX
            origin.x: root.width / 2
            origin.y: root.height / 2
            axis { x: 1; y: 0; z: 0}
        },
        Rotation {
            id: rotateY
            origin.x: root.width / 2
            origin.y: root.height / 2
            axis { x: 0; y: 1; z: 0}
        },
        Rotation {
            id: rotateZ
            origin.x: root.width / 2
            origin.y: root.height / 2
            axis { x: 0; y: 0; z: 1}
        }
    ]
    function rotate(x, y, z){
        rotateX.angle = x
        rotateY.angle = y
        rotateZ.angle = z
    }
}
