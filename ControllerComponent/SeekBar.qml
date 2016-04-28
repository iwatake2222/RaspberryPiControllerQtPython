import QtQuick 2.0
import "Utilities.js" as Utilities

Rectangle {
    id: root
    width: 50
    height: 200
    property int circleSize: width
    property int barSize: width/2
    property color colorBarBorder: "Black"
    property color colorBar: "LightGray"
    property color colorCircle: "Red"
    property int value: min
    property int max: 100
    property int min: 0

    Item {
        id: inner
        function convPixelToValue(positionY) {
            /*
             * ratio = (value-min)/(max-min)
             * value = ratio * (max-min) + min
             */
            positionY = positionY - circle.height/2
            if(positionY < 0)positionY = 0
            if(positionY > root.height- circleSize) positionY = root.height - circleSize
            return positionY / (root.height- circleSize) * (max - min) + min
        }
    }

    onValueChanged: {
        if(value < min) {
            value = min
        } else if (value > max) {
            value = max
        }
        console.log("[Component] SeekBar: " + value)
    }

    Rectangle {
        id: barBorder
        x: root.width / 2 - width/2
        y: circleSize/2
        width: barSize
        height: root.height - circleSize
        color: colorBar
        border.color: colorBarBorder
        border.width: 2
    }

    Rectangle {
        id: barColored
        x: root.width / 2 - width/2
        y: circleSize/2 + barBorder.border.width
        width: barSize - (barBorder.border.width*2)
        height: (root.height - circleSize) * (value - min) / (max - min)
        color: Utilities.calcInternalColor(colorBar, colorCircle, value)
    }

    Rectangle {
        id: circle
        x: root.width / 2 - width / 2
        y: (root.height- circleSize) * (value - min) / (max - min)
        width: circleSize
        height: circleSize
        radius: width/2
        color: colorCircle
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: {            
            value = inner.convPixelToValue(mouse.y)
        }
        onPositionChanged: {
            value = inner.convPixelToValue(mouse.y)
        }
        onClicked: focus = true
    }

    Keys.onPressed: {
        //console.log(event.key)
    }
    Keys.onDownPressed:  {
        if(rotation %180 ==0)
            value--
        else
            value++
    }
    Keys.onUpPressed: {
        if(rotation %180 ==0)
            value++
        else
            value--
    }
}
