import QtQuick 2.0
import QtQuick.Controls 2.15

import Images 1.0

import "."

// img is global

Rectangle {
    id: imageOverlay
	anchors.fill: imageCanvas
    function fetch() {
        if (sidebar.opened != 0) {
            if (sidebar.opened.name == "Perspective Transform") {
                if (sidebar.opened.children[1].children[0].checked) {
                    pointA.mouse.enabled = false
                    pointB.mouse.enabled = false
                    pointC.mouse.enabled = false
                    pointD.mouse.enabled = false
                    return false
                }
                pointA.mouse.enabled = true
                pointB.mouse.enabled = true
                pointC.mouse.enabled = true
                pointD.mouse.enabled = true
                return true
            }
        }
        pointA.mouse.enabled = false
        pointB.mouse.enabled = false
        pointC.mouse.enabled = false
        pointD.mouse.enabled = false
        return false
    }
    color: "transparent"
    visible: fetch() 
    property var sscale: imageCanvas.scale

    property var pts: [ pointA.x / targetscale,
                        pointA.y / targetscale, 
                        pointB.x / targetscale, 
                        pointB.y / targetscale, 
                        pointC.x / targetscale, 
                        pointC.y / targetscale,
                        pointD.x / targetscale,
                        pointD.y / targetscale
                      ] 

    Point {
        id: pointA
        x: parent.width / 4
        y: parent.height / 4
    }
    Point {
        id: pointB
        x: (parent.width * 3) / 4
        y: parent.height / 4
    }
    Point {
        id: pointC
        x: (parent.width * 3) / 4
        y: (parent.height * 3) / 4
    }
    Point {
        id: pointD
        x: parent.width / 4
        y: (parent.height * 3) / 4
    }

    Item {
        anchors.fill: parent

        Canvas {
            id: canvas
            anchors.fill: parent
            onHeightChanged: {
                repaint()
            }
            onWidthChanged: {
               repaint()
            }
            onPaint: {
                var ctx = canvas.getContext('2d');
                ctx.moveTo(pointA.x, pointA.y);
                ctx.lineTo(pointB.x, pointB.y);
                ctx.lineTo(pointC.x, pointC.y);
                ctx.lineTo(pointD.x, pointD.y);
                ctx.lineTo(pointA.x, pointA.y);
                ctx.stroke();
            }
            Component.onCompleted: {
                pointA.dragged.connect(repaint)
                pointB.dragged.connect(repaint)
                pointC.dragged.connect(repaint)
                pointD.dragged.connect(repaint)
            }

            function repaint() {
                var ctx = getContext("2d");
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.beginPath();
                requestPaint()
            }
        }
    }
}
