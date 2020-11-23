import QtQuick 2.0
Item {
    id: root

    signal dragged()
	property var mouse: mousearea

    Rectangle {
        anchors.centerIn: parent
        width: 20
        height: 20
        color: "blue"
        opacity: 0.3
		radius: 50

        MouseArea {
			id: mousearea
            anchors.fill: parent
            drag.target: root
			drag.minimumX: 0
			drag.minimumY: 0
			drag.maximumX: parent.parent.parent.width
			drag.maximumY: parent.parent.parent.height
            onPositionChanged: {
                if(drag.active) {
                    dragged()
                }
            }
        }
    }
}