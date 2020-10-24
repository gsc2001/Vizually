import QtQuick 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Extras 1.4

ApplicationWindow {
    id: root
    width: 1600; height: 900
    property var currentChose: undefined
    property real defaultSize: 400
    property real zoomRatio: 1.0

    FileDialog {
        id: fileDialog
        title: "Choose an Image for testing"
        folder: shortcuts.home
        property var imageNameFilters : ["*.png", "*.jpg"]
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

    Flickable {
        id: flickable
        x: 350; y: 0
        width: 1250; height: 900
        clip: true
        contentWidth: width * zoomRatio; contentHeight: height * zoomRatio // current size of viewport
        Rectangle {
            id: photoFrame
            width: image.width + 10; height: image.height + 10  
            scale: defaultSize / Math.max(image.sourceSize.width, image.sourceSize.height)
            Behavior on scale { NumberAnimation { duration: 20 } }
            Behavior on x { NumberAnimation { duration: 20 } }
            Behavior on y { NumberAnimation { duration: 20 } }
            border.width: 10
            border.color: "black"
            smooth: true
            antialiasing: true
            Image  {
                id: image
                source: fileDialog.fileUrl
                cache: true
                anchors.centerIn: photoFrame
                fillMode: Image.PreserveAspectFit
                antialiasing: true
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
            function setToBeSelected() {
                if (currentChose) {
                    currentChose.border.color = "black"
                }
                currentChose = photoFrame;
                currentChose.border.color = "red";
            }
        }
    }

    Label {
        id: label
        x: 20
        y: 22
        width: 128
        height: 32
        text: fileDialog.fileUrl
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/