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
        onClicked: console.log("commit")
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
        onClicked: console.log("revert")
    }

    Rectangle {
        id: sidebar
        x: 0; y: 0
        width: 345; height: parent.height
        color: "#333"
        clip: true

        Behavior on width { NumberAnimation { duration: 250 } }

       // collapse 
        Rectangle {
            color: 'steelblue'
            width: 20; height: parent.height
            anchors.right: parent.right

            Text {
                id: hsymbol
                text: '<'
                anchors.horizontalCenter: parent.horizontalCenter
                y: 5
                font.bold: true
                font.pointSize: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: () => {
                    sidebar.width = 360 - sidebar.width
                    hsymbol.text = String.fromCharCode('>'.charCodeAt(0) + '<'.charCodeAt(0) - hsymbol.text.charCodeAt(0))
                }
            }
        }

        Flickable {
            width: 325; height: parent.height
            x: 15; y: 15
            contentHeight: sidebar_col.height + 30
            clip: true
            // boundsMovement: Flickable.StopAtBounds
            ScrollBar.vertical: ScrollBar {}

            Column {
                id: sidebar_col
                spacing: 15

                // Rotation
                Ui.Feature {
                    id: rotation
                    name: "Rotation"

                    Column {
                        x: 25; y: 35

                            Ui.Slider {
                                from: 0
                                to: 360
                                unit: " deg"
                            }
                    }
                }

                // Blur
                Ui.Feature {
                    id: blur
                    name: "Blurring"

                    Column {
                    x: 25; y: 35
                        
                        Ui.Slider {
                            from: 1
                            to: 20
                            unit: "%"
                        }
                    }
                }
                
                // Flip
                Ui.Feature {
                    id: flip
                    name: "Flip"
                    height: 130

                    Column {
                    x: 25; y: 35

                        Switch {
                            text: 'Horizontal'
                        }
                        Switch {
                            text: 'Vertical'
                        }
                    }
                }

                // Contrast
                Ui.Feature {
                    id: contrast
                    name: "Contrast"
                    
                    Column {
                        x: 25; y: 35

                        Ui.Slider{
                            from: 0
                            to: 3
                            value: 0
                            stepSize: 0.1
                            unit: " lev"
                        }
                    }
                }

                // Bilateral Blue
                Ui.Feature {
                    id: bilateralBlur
                    name: "Bilateral Blue"

                    Column {
                        x: 25; y: 35
                        
                        Switch {
                            text: "Apply"
                        }
                    }
                }

                // Edge
                Ui.Feature {
                    id: edge
                    name: "Edge detection"

                    Column {
                        x: 25; y: 35
                        
                        Ui.Slider{
                            from: 0
                            to: 127
                            value: 0
                            stepSize: 1
                            unit: " pow" 
                        }
                    }
                }

                // Thresholding
                Ui.Feature {
                    id: thresholding
                    name: "Thresholding"

                    Column {
                        x: 25; y: 35
                        
                        Switch {
                            text: "Apply"
                        }
                    }
                }
                
                // Ridge Detection
                Ui.Feature {
                    id: ridge
                    name: "Ridge Detect"

                    Column {
                        x: 25; y: 35
                        
                        Switch {
                            text: "Apply"
                        }
                    }
                }

                // Sharpening
                Ui.Feature {
                    id: sharpen
                    name: "Sharpening"
                    height: 130

                    Column {
                        x: 25; y: 35
                        Ui.Slider{
                            implicitWidth: 150
                            from: 1
                            to: 11
                            stepSize: 2
                            unit: " kernel size"
                        }
                        Ui.Slider{
                            implicitWidth: 150
                            from: 0
                            to: 10
                            stepSize: 0.5
                            unit: " strength"
                        }
                    }
                }
                

                // combo box
                // Rectangle {
                //     width: 300; height: 100
                //     color: "#eee"
                //     radius: 10

                //     Column {
                //         x: 25; y: 15

                //         Text {
                //             y: 100
                //             text: "Select Filter to be applied: "
                //             font.italic: true
                //             font.pointSize: 11
                //         }

                //         ComboBox {
                //             y: 50
                //             currentIndex: 0
                //             model: ListModel {
                //                 id: cbItems
                //                 ListElement { text: "None"}
                //                 ListElement { text: "Sharpening" }
                //                 ListElement { text: "Blurring" }
                //                 ListElement { text: "Perspective" }
                //                 ListElement { text: "Morphing" }
                //                 ListElement { text: "Perspective" }
                //             }
                //             width: 200
                //             onCurrentIndexChanged: console.debug(cbItems.get(currentIndex).text)
                //         }
                //     }
                // }   
            }
        // Rectangle {
        //     x: 25; y: 25
        //     width: 300; height: 100
        //     color: "#eee"
        //     radius: 10
        //     Text {
        //         id: tb
        //         x : 0; y : 0
        //         width: 100; height: 100
        //         text: qsTr("Hello World!")
        //     }
        // }
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
