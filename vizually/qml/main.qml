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
    title: qsTr("Vizually")
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
        x: 150; y: 500
        text: 'gray'
        onClicked: image.mainImage.apply({func_name: "rotate", rotation_angle: 45})
    }
    Label {
        id: mousePosition
        x: 150; y: 550
        text: "%1".arg(image.mouse.mouseX.toString())
    }

    Flickable {
        id: flickable
        anchors.left: sidebar.right
        anchors.right: parent.right
        anchors.top : parent.top
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        contentWidth: Math.max(image.width * image.scale + 300, width);
        contentHeight: Math.max(image.height * image.scale + 100, height);
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
    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: "Open"
                onTriggered: fileDialog.open()
            }
            // MenuItem {
            //     text: "Save"
            // }
            MenuItem {
                text: "Exit"
                onTriggered: Qt.quit()
            }
        }
        Menu {
            title: qsTr("&Help")
            MenuItem {
                text: "About"
            }
        }
    }

    Button {
        id: commit
        palette {
            button: "blue"
            buttonText: "white"
        }
        anchors.right : parent.right
        anchors.bottom : parent.bottom
        anchors.rightMargin: 20
        anchors.bottomMargin: 20
        text: 'Commit Changes'
        onClicked: image.mainImage.commit()
    }
    Button {
        id: revert
        palette {
            button: "red"
            buttonText: "white"
        }
        anchors.right : parent.right
        anchors.bottom : parent.bottom
        anchors.rightMargin: 20
        anchors.bottomMargin: 80
        text: 'Revert Changes'
        onClicked: () => {
            if (sidebar.opened) sidebar.opened.toggle()
        }
    }
    Ui.Sidebar {
        id: sidebar
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
