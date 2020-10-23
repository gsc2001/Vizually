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
    }

    Flickable {
        id: flickable
        x: 350; y: 0
        width: 1250; height: 900
        clip: True
        contentWidth: width * zoomRatio; contentHeight: height * zoomRatio // current size of viewport
        Rectangle {
            id: photoFrame
            width: image.width; height: image.height
            scale: defaultSize / Math.max(image.sourceSize.width, image.sourceSize.height)
            Behavior on scale { NumberAnimation { duration: 200 } }
            border.width: 2
            border.color: "black"
            smooth: true
            antialiasing: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
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
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                onClicked: parent.setToBeSelected();
                onWheel: {
                    if (wheel.modifiers & Qt.ControlModifier) {
                        var scaleBefore = photoFrame.scale;
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

    Component.onCompleted: {
        if (typeof contextInitialUrl !== 'undefined') {
            // Launched from C++ with context properties set.
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

    property var imageNameFilters : ["*.png", "*.jpg", "*.gif"];
    property string picturesLocation : "";

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
