import QtQuick 2.0
import QtQuick.Controls 2.15

import Images 1.0

import "."

Rectangle {
    id: photoFrame
    width: photoContainer.width * photoContainer.scale + 2;
    height: photoContainer.height * photoContainer.scale + 2;
    border.color: "transparent"
    border.width: 2
    anchors.centerIn: parent
    property ImageViewer mainImage: mainImage
    property MouseArea mouse: zoomArea
    property var scale: photoContainer.scale
    property bool reset: true
    Rectangle {
        id: photoContainer
        width: mainImage.width; height: mainImage.height
        scale: defaultSize / Math.max(mainImage.width, mainImage.height)
        Behavior on scale { NumberAnimation { duration: 20 } }
        Behavior on x { NumberAnimation { duration: 20 } }
        Behavior on y { NumberAnimation { duration: 20 } }
        smooth: true
        antialiasing: true
        anchors.centerIn: parent
        ImageViewer {
            id: mainImage
            width: _width
            height: _height
            anchors.centerIn:parent
        }
        MouseArea {
            id: zoomArea
            anchors.fill: parent
            onClicked: {
                photoFrame.border.color = "yellow"
            }
            onWheel: {
                if (wheel.modifiers & Qt.ControlModifier) {
                    photoContainer.scale += photoContainer.scale * wheel.angleDelta.y / 120 / 10;
                }
            }
        }
    }
}
