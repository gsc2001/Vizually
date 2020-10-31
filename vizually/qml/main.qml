import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.15

import "ui" as Ui

ApplicationWindow {
    id: window
    objectName: "window"
    width: 1200; height: 800
    title: project && project.loaded ?
         ((project.url.toString().length > 0 ? project.displayUrl : "Untitled")
          + (project.unsavedChanges ? "*" : "")) : ""
    visible: true
    
    
    property var currentChose: undefined
    property real defaultSize: 400
    property real zoomRatio: 1.0

    FileDialog {
        id: fileDialog
        title: "Choose an Image for testing"
        folder: shortcuts.home
        onAccepted: {
            console.log(fileUrl)
            image.mainImage.load_image(fileUrl)
        }
        property var imageNameFilters : ["*.png", "*.jpg", ".jpeg"]
        Component.onCompleted: {
            if (typeof contextInitialUrl !== 'undefined') {
                // Launched from python with context properties set.
                imageNameFilters = contextImageNameFilters;
                picturesLocation = contextPicturesLocation;
                if (contextInitialUrl == "")
                    fileDialog.open();
                else
                    folderModel.folder = contextInitialUrl + "/";
            } else {
                // Launched via QML viewer without context properties set.
                fileDialog.open();
            }
        }
    }
    Button {
        x: 150; y: 450
        text: 'gray'
        onClicked: image.mainImage.apply('gray')
    }
    Label {
        id: mousePosition
        x: 150; y: 550
        text: "%1".arg(image.zoomArea.mouseX.toString())
    }

    Flickable {
        id: flickable
        x: 350; y: 0
        width: 1250; height: 900
        boundsBehavior: Flickable.StopAtBounds
        contentWidth: width * zoomRatio; contentHeight: height * zoomRatio // current size of viewport
        clip: true
        Ui.ImageCanvas {
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

    Rectangle {
        id: sidebar
        x: 0; y: 0
        width: 350; height: 900
        color: "#333"

        Rectangle {
            x: 25; y: 25
            width: 300; height: 100
            color: "#eee"
            radius: 10
            Text {
                id: tb
                x : 0; y : 0
                width: 100; height: 100
                text: qsTr("Hello World!")
            }
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
