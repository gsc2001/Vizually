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

    property var pts: [pointA.x, pointA.y, pointB.x, pointB.y, pointC.x,pointC.y, pointD.x, pointD.y] 

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
            onPaint: {
                var ctx = canvas.getContext('2d');
                /*
                TODO
                def order_points(point_list):
                    # initialzie a list of coordinates that will be ordered
                    # such that the first entry in the list is the top-left,
                    # the second entry is the top-right, the third is the
                    # bottom-right, and the fourth is the bottom-left
                    rect = np.zeros((4, 2), dtype = "float32")
                    # the top-left point will have the smallest sum, whereas
                    # the bottom-right point will have the largest sum
                    s = point_list.sum(axis = 1)
                    rect[0] = point_list[np.argmin(s)]
                    rect[2] = point_list[np.argmax(s)]
                    # now, compute the difference between the points, the
                    # top-right point will have the smallest difference,
                    # whereas the bottom-left will have the largest difference
                    diff = np.diff(point_list, axis = 1)
                    rect[1] = point_list[np.argmin(diff)]
                    rect[3] = point_list[np.argmax(diff)]
                    # return the ordered coordinates
                    return rect
                */

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
