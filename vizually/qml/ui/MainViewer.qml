import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.15

import "."

Rectangle {
    id: mainViewer
    property var image: imageCanvas.mainImage
    property var overlay: overlay
    Flickable {
        id: flickable
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        contentWidth: Math.max(imageCanvas.width * imageCanvas.scale + 300, width);
        contentHeight: Math.max(imageCanvas.height * imageCanvas.scale + 100, height);
        clip: true
        ImageCanvas {
            id: imageCanvas
        }
        ImageOverlay {
            id: overlay
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
