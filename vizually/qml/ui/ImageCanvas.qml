import QtQuick 2.0
import QtQuick.Controls 2.15

import Images 1.0

import "."

Rectangle {
        id: photoFrame
        width: mainImage.width + 10; height: mainImage.height + 10
        scale: defaultSize / Math.max(image.mainImage.width, image.mainImage.height)
        Behavior on scale { NumberAnimation { duration: 20 } }
		Behavior on x { NumberAnimation { duration: 20 } }
		Behavior on y { NumberAnimation { duration: 20 } }
		border.width: 10
		border.color: "transparent"
		smooth: true
		antialiasing: true
		anchors.centerIn: parent
       	property ImageViewer mainImage: mainImage
		property MouseArea mouse: zoomArea
        property bool reset: true
		ImageViewer {
           	id: mainImage
			width: _width
			height: _height
			anchors.centerIn:parent
        }
		MouseArea {
            id: zoomArea
            hoverEnabled: true
            anchors.fill: parent
            drag.target: parent
            onPressed: {
				if (reset)
                    image.anchors.centerIn = undefined
					reset = false
			}
            onWheel: {
                if (wheel.modifiers & Qt.ControlModifier) {
                    image.scale += image.scale * wheel.angleDelta.y / 120 / 10;
                }
            }
        }
}
