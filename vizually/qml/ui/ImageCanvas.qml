import QtQuick 2.0
import QtQuick.Controls 2.15

import Images 1.0

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
        property ImageViewer mainImage: mainImage
		property MouseArea mouse: zoomArea
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
			drag.target: photoFrame
			anchors.rightMargin: 0
			anchors.bottomMargin: 0
			anchors.leftMargin: 0
			anchors.topMargin: 0
            onWheel: {
				if (wheel.modifiers & Qt.ControlModifier) {
					photoFrame.scale += photoFrame.scale * wheel.angleDelta.y / 120 / 10;
				}
		    }
		}
}
