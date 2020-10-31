import QtQuick 2.0
import QtQuick.Controls 2.15

import Images 1.0

Rectangle {
        id: photoFrame
	    width: image.width + 10; height: image.height + 10
        scale: defaultSize / Math.max(image.sourceSize.width, image.sourceSize.height)
		Behavior on scale { NumberAnimation { duration: 20 } }
		Behavior on x { NumberAnimation { duration: 20 } }
		Behavior on y { NumberAnimation { duration: 20 } }
		border.width: 10
		border.color: "transparent"
		smooth: true
		antialiasing: true
		Image  {
            id: image
            source: fileDialog.fileUrl
            visible: false
            cache: true
            anchors.centerIn: photoFrame
            fillMode: Image.PreserveAspectFit
            antialiasing: true
		}
        ImageViewer {
            id: mainImage
			anchors.fill: image
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
			onPressed: parent.setToBeSelected();
            onWheel: {
				if (wheel.modifiers & Qt.ControlModifier) {
					photoFrame.scale += photoFrame.scale * wheel.angleDelta.y / 120 / 10;
				}
		    }
		}
}
