import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.15

import "."

Rectangle {
    id: mainViewer
    property var image: image.mainImage
    Flickable {
        id: flickable
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        contentWidth: Math.max(image.width * image.scale + 300, width);
        contentHeight: Math.max(image.height * image.scale + 100, height);
        clip: true
        ImageCanvas {
            id: image
        }
        ScrollBar.vertical: ScrollBar {
            id: verticalScrollBar
            active: horizontalScrollBar.active
        }
        ScrollBar.horizontal: ScrollBar {
            id: horizontalScrollBar
            active: verticalScrollBar.active
        }   
    }
}