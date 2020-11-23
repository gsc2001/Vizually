import QtQuick 2.15
import QtQuick.Controls 2.15

import Images 1.0

import "."

// img is global

Rectangle {
    id: imageOverlay2
		anchors.fill: imageCanvas
    function fetch() {
        if (sidebar.opened != 0) {
            if (sidebar.opened.name == "Image Masking") {
                if (sidebar.opened.children[1].children[1].checked) {
					mainmouse.enabled = false
					mouseA.enabled = false
                    mouseB.enabled = false
                    mouseC.enabled = false
					pointA.visible = false
					pointB.visible = false
					pointC.visible = false
					pointD.visible = false
                    return false
				}
				mainmouse.enabled = true
                mouseA.enabled = true
                mouseB.enabled = true
                mouseC.enabled = true
                mouseD.enabled = true
				pointA.visible = true
				pointB.visible = true
				pointC.visible = true
				pointD.visible = true
				return true
            }
		}
		mainmouse.enabled = false
        mouseA.enabled = false
        mouseB.enabled = false
        mouseC.enabled = false
		mouseD.enabled = false
		pointA.visible = false
		pointB.visible = false
		pointC.visible = false
		pointD.visible = false
        return false
    }
    color: "transparent"
    visible: fetch() 
    property var sscale: imageCanvas.scale
	property var top_left_x : selComp.x  / targetscale
	property var top_left_y : selComp.y / targetscale
	property var bottom_right_x : (selComp.x + selComp.width) / targetscale
	property var bottom_right_y : (selComp.y + selComp.height) / targetscale

	Rectangle {
		id: selComp
		x: parent.width / 4
		y: parent.height/ 4
		width: parent.width / 2
		height: parent.height / 2
		border.width: 2
		border.color: "steelblue"
		color: "#354682B4"

		property int rulersSize: 18

		MouseArea {     // drag mouse area
			id: mainmouse
			anchors.fill: parent
			drag {
				target: parent
				minimumX: 0
				minimumY: 0
				maximumX: selComp.parent.width - selComp.width
				maximumY: selComp.parent.height - selComp.height
				smoothed: true
			}
		}

		Rectangle {
			id: pointA
			width: selComp.rulersSize
			height: selComp.rulersSize
			radius: selComp.rulersSize
			color: "steelblue"
			anchors.horizontalCenter: selComp.left
			anchors.verticalCenter: selComp.verticalCenter

			MouseArea {
				id: mouseA
				anchors.fill: parent
				drag{ target: parent; axis: Drag.XAxis }
				onMouseXChanged: {
					if(drag.active){
						selComp.width = selComp.width - mouseX
						selComp.x = selComp.x + mouseX
						if(selComp.width < 30)
							selComp.width = 30
					}
				}
			}
		}

		Rectangle {
			id: pointB
			width: selComp.rulersSize
			height: selComp.rulersSize
			radius: selComp.rulersSize
			color: "steelblue"
			anchors.horizontalCenter: selComp.right
			anchors.verticalCenter: selComp.verticalCenter

			MouseArea {
				id: mouseB
				anchors.fill: parent
				drag{ target: parent; axis: Drag.XAxis }
				onMouseXChanged: {
					if(drag.active){
						selComp.width = selComp.width + mouseX
						if(selComp.width < 50)
							selComp.width = 50
					}
				}
			}
		}

		Rectangle {
			id: pointC
			width: selComp.rulersSize
			height: selComp.rulersSize
			radius: selComp.rulersSize
			x: parent.x / 2
			y: 0
			color: "steelblue"
			anchors.horizontalCenter: selComp.horizontalCenter
			anchors.verticalCenter: selComp.top

			MouseArea {
				id: mouseC
				anchors.fill: parent
				drag{ target: parent; axis: Drag.YAxis }
				onMouseYChanged: {
					if(drag.active){
						selComp.height = selComp.height - mouseY
						selComp.y = selComp.y + mouseY
						if(selComp.height < 50)
							selComp.height = 50
					}
				}
			}
		}


		Rectangle {
			id: pointD
			width: selComp.rulersSize
			height: selComp.rulersSize
			radius: selComp.rulersSize
			x: parent.x / 2
			y: parent.y
			color: "steelblue"
			anchors.horizontalCenter: selComp.horizontalCenter
			anchors.verticalCenter: selComp.bottom

			MouseArea {
				id: mouseD
				anchors.fill: parent
				drag{ target: parent; axis: Drag.YAxis }
				onMouseYChanged: {
					if(drag.active){
						selComp.height = selComp.height + mouseY
						if(selComp.height < 50)
							selComp.height = 50
					}
				}
			}
		}
	}
}

