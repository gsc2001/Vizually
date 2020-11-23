import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.15
import QtQuick.Controls.Material 2.12

import "ui" as Ui

ApplicationWindow {
    id: window
    objectName: "window"
    width: 1200; height: 800
    title: qsTr("Vizually")
    visible: true
    
    Material.theme: Material.Light
    Material.accent: Material.Purple
    
    property var targetimage: mainViewer.image
    property var targetoverlay: mainViewer.overlay
    property var targetmaskoverlay: mainViewer.maskoverlay
    property var targetscale: mainViewer.sscale
    property bool loaded: false
    property real defaultSize: 600
    property real zoomRatio: 1.0

    property var undo: () => {
        if (sidebar.opened) {
            sidebar.opened.toggle()
            targetimage.reset()
        } else {
            targetimage.undo()
        }
    }

    property var redo: () => {
        if (sidebar.opened)
            sidebar.opened.toggle()
        
        targetimage.redo()
    }

    property var save: () => targetimage.save_image()

    Action {
        shortcut: "Ctrl+Z"
        onTriggered: undo()
    }
    
    Action {
        shortcut: "Ctrl+Y"
        onTriggered: redo()
    }

    Action {
        shortcut: "Ctrl+S"
        onTriggered: save()
    }

    FileDialog {
        id: fileDialog
        title: "Choose an Image for testing"
        folder: shortcuts.home
        onAccepted: {
            
            targetimage.load_image(fileUrl)
            if (!loaded) loaded = true
        }
        property var imageNameFilters : ["*.png", "*.jpg", ".jpeg"]
        // For testing only
        Component.onCompleted: {
            fileDialog.open()
            loaded = true
        }
    }
    
    Ui.MainViewer {
        id: mainViewer
        anchors.left: sidebar.right
        anchors.right: parent.right
        anchors.top : parent.top
        anchors.bottom: parent.bottom
    }
    
    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: "Open"
                onTriggered: {
                fileDialog.open()
                if (sidebar.opened) sidebar.opened.toggle()
                }
            }
            MenuItem {
                text: "Save"
                onTriggered: save()
            }
            MenuItem {
                text: "Exit"
                onTriggered: Qt.quit()
            }
        }
        Menu {
            title: qsTr("&Edit")
            MenuItem {
                text: "Undo"
                onTriggered: undo()
            }
            MenuItem {
                text: "Redo"
                onTriggered: redo()
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
        anchors.right : parent.right
        anchors.bottom : parent.bottom
        anchors.rightMargin: 20
        anchors.bottomMargin: 20
        text: ' Apply '
        Material.background: Material.Blue
        Material.foreground: "#ffffff"
        Material.elevation: 6
        onClicked: {
            targetimage.commit()
            if (sidebar.opened) sidebar.opened.toggle()
        }
        visible: loaded
    }
    Button {
        id: revert
        anchors.right : parent.right
        anchors.bottom : parent.bottom
        anchors.rightMargin: 100
        anchors.bottomMargin: 20
        text: 'Revert'
        Material.background: Material.Red
        Material.foreground: "#ffffff"
        Material.elevation: 6
        onClicked: () => {
            if (sidebar.opened) sidebar.opened.toggle()
            targetimage.reset()
        }
        visible: loaded
    }
    Ui.Sidebar {
        id: sidebar
        visible: loaded
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
