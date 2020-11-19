import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3

import "." as Ui
import "Utils.js" as Utils

Rectangle {
    id: sidebar
    x: 0; y: 0
    width: 345; height: parent.height
    color: "#333"
    clip: true
    property var opened: 0

    Behavior on width { NumberAnimation { duration: 250 } }

    // collapse
    Rectangle {
        id: collapse
        color: 'steelblue'
        width: 13; height: parent.height
        anchors.right: parent.right
        property var tot_width: width + sidebar.width

        Text {
            id: hsymbol
            text: '<'
            anchors.horizontalCenter: parent.horizontalCenter
            y: 5
            font.bold: true
            font.pointSize: parent.width
        }

        MouseArea {
            anchors.fill: parent
            onClicked: () => {
                sidebar.width = parent.tot_width - sidebar.width
                hsymbol.text = String.fromCharCode('>'.charCodeAt(0) + '<'.charCodeAt(0) - hsymbol.text.charCodeAt(0))
            }
        }

        Component.onCompleted: () => {
            tot_width = tot_width
        }
    }

    Flickable {
        x: 15; y: 15
        contentHeight: sidebar_col.height + 30
        clip: true
        height: parent.height
        anchors.left: parent.left;
        anchors.right: collapse.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        anchors.topMargin: 15   
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds
        ScrollBar.vertical: ScrollBar {}

        Column {
            id: sidebar_col
            spacing: 15
            width: parent.width

            // Blur
            Ui.Feature {
                id: blur
                name: "Blur"
                property int option: 0
                args: ({func_name: blurItems.get(0).func_name})
                height: Utils.getHeight(children[1])

                Column {
                    x: 25; y: 35

                    ComboBox {
                        currentIndex: 0
                        textRole: "text"
                        model: ListModel {
                            id: blurItems
                            ListElement { text: "Average Blur"; func_name: "avgBlur"}
                            ListElement { text: "Gaussian Blur"; func_name: "gaussianBlur"}
                            ListElement { text: "Bilateral Blur"; func_name: "bilateralBlur"}
                        }
                        width: 200
                        onCurrentIndexChanged: () => {
                            targetimage.reset()
                            blur.args = ({func_name: blurItems.get(currentIndex).func_name})
                            blur.option = currentIndex
                            blur.height = Utils.getHeight(parent)
                        }
                    }
                    

                    Ui.Slider {
                        visible: (blur.option == 0)
                        from: 1
                        to: 20
                        unit: " value"
                        key: "blurValue"
                    }

                    Ui.Slider {
                        visible: (blur.option == 1)
                        from: 0
                        to: 2
                        stepSize: 0.1
                        unit: " sigmaX"
                        key: "sigmaX"
                        implicitWidth: 200
                    }

                    Ui.Slider {
                        visible: (blur.option == 1)
                        from: 0
                        to: 2
                        stepSize: 0.1
                        unit: " sigmaY"
                        key: "sigmaY"
                        implicitWidth: 200
                    }

                    Ui.Switch {
                        visible: (blur.option == 2)
                        text: "Apply"
                    }
                }
            }



            // Edge Detection
            Ui.Feature {
                id: edge
                name: "Edge"
                property int option: 0
                args: ({func_name: edgeItems.get(0).func_name})
                height: Utils.getHeight(children[1])

                Column {
                    x: 25; y: 35

                    ComboBox {
                        currentIndex: 0
                        textRole: "text"
                        model: ListModel {
                            id: edgeItems
                            ListElement { text: "Canny Edge Detection"; func_name: "canny"}
                            ListElement { text: "Sobel Edge Detection"; func_name: "sobel"}
                        }
                        width: 200
                        onCurrentIndexChanged: () => {
                                                   targetimage.reset()
                                                   edge.args = ({func_name: edgeItems.get(currentIndex).func_name})
                                                   edge.option = currentIndex
                                                   edge.height = Utils.getHeight(parent)
                                               }
                    }
                    

                    // canny
                    Ui.Slider {
                        visible: (edge.option == 0)
                        from: 0
                        to: 127
                        unit: " value"
                        key: "strength"
                    }
                    // sobel
                    Ui.ComboBox {
                        visible: (edge.option == 1)
                        textRole: "name"
                        key: "kernel_size"
                        model: ListModel {
                            id: cbItems
                            ListElement {name: "3"; value: 3}
                            ListElement {name: "5"; value: 5}
                        }
                    }

                }
            }

            // Thresholding
            Ui.Feature {
                id: thresholding
                name: "Thresholding"
                property int option: 0
                args: ({func_name: thresholdingItems.get(0).func_name})
                height: Utils.getHeight(children[1])

                Column {
                    x: 25; y: 35

                    ComboBox {
                        currentIndex: 0
                        textRole: "text"
                        model: ListModel {
                            id: thresholdingItems
                            ListElement { text: "otsu"; func_name: "otsuThres"}
                            ListElement { text: "Adaptive"; func_name: "thres"}
                            ListElement { text: "Absolute"; func_name: "absThres"}
                        }
                        width: 200
                        onCurrentIndexChanged: () => {
                                                   targetimage.reset()
                                                   thresholding.args = ({func_name: thresholdingItems.get(currentIndex).func_name})
                                                   thresholding.option = currentIndex
                                                   thresholding.height = Utils.getHeight(parent)
                                               }
                    }


                    // adaptive
                    Ui.Slider {
                        visible: (thresholding.option == 1)
                        from: 0
                        to: 2
                        stepSize: 0.1
                        unit: " value"
                        key: "threshold_value"
                    }
                    

                    // otsu
                    Ui.Switch {
                        visible: (thresholding.option == 0)
                        text: "Apply"
                    }

                    // absolute
                    Ui.Slider {
                        visible: (thresholding.option == 2)
                        from: 1
                        to: 254
                        stepSize: 1
                        unit: " value"
                        key: "threshold_value"
                    }
                }
            }
            

            // Flip
            Ui.Feature {
                id: flip
                name: "Flip"
                height: 130
                args: ({func_name: "flip"})

                Column {
                    x: 25; y: 35
                    Ui.Switch {
                        text: 'Horizontal'
                        key: "horizontal"
                    }
                    Ui.Switch {
                        text: 'Vertical'
                        key: "vertical"
                    }
                }
            }

            // Ridge Detection
            Ui.Feature {
                id: ridge
                name: "Ridge Detect"
                args: ({func_name: "ridge"})
                Column {
                    x: 25; y: 35

                    Ui.Switch {
                        text: "Apply"
                    }

                }
            }

            // Contrast
            Ui.Feature {
                id: contrast
                name: "Contrast"
                args: ({func_name: "contrast"})
                Column {
                    x: 25; y: 35

                    Ui.Slider {
                        implicitWidth: 150
                        from: 0
                        to: 4
                        stepSize: 0.1
                        unit: " lev"
                        key: "contrast_limit"
                    }
                }
            }

            // Sharpening
            Ui.Feature {
                id: sharpen
                name: "Sharpening"
                height: 130
                args: ({func_name: "sharpen"})

                Column {
                    x: 25; y: 35
                    Ui.Slider{
                        implicitWidth: 150
                        from: 1
                        to: 11
                        stepSize: 2
                        unit: " kernel size"
                        key: "kernel_size"
                    }
                    Ui.Slider{
                        implicitWidth: 150
                        from: 0
                        to: 10
                        stepSize: 0.5
                        unit: " strength"
                        key: "strength"
                    }
                }
            }

            // Corner Edge Detection
            Ui.Feature {
                id: corner
                name: "Corner Detection"
                height: 130
                args: ({func_name: "corner"})

                Column {
                    x: 25; y: 35
                    Ui.Slider{
                        implicitWidth: 150
                        from: 1
                        to: 11
                        stepSize: 2
                        unit: " kernel size"
                        key: "kernel_size"
                    }
                    Ui.Slider{
                        implicitWidth: 150
                        from: 0
                        to: 10
                        stepSize: 0.5
                        unit: " strength"
                        key: "sharpen_strength"
                    }
                }
            }

            // Rotation
            Ui.Feature {
                id: rotation
                name: "Rotate"
                args: ({func_name: "rotate"})

                Column {
                    x: 25; y: 35

                    Ui.Slider {
                        from: -45
                        to: 45
                        value: 0
                        unit: " deg"
                        key: "rotation_angle"
                    }
                }
            }

            // Ridge Detection
            Ui.Feature {
                id: perspective
                name: "Perspective Transform"
                args: ({func_name: "perspective",
                        point_list: targetoverlay.pts})
                Column {
                    x: 25; y: 35

                    Ui.Switch {
                        text: "Apply"
                    }

                }
            }

            // Filters
            Ui.Feature {
                id: filter
                name: "Filters"
                property int option: 0
                args: ({func_name: filterItems.get(0).func_name})
                height: Utils.getHeight(children[1])

                Column {
                    x: 25; y: 35

                    ComboBox {
                        currentIndex: 0
                        textRole: "text"
                        model: ListModel {
                            id: filterItems
                            ListElement { text: "Canny Cartoon"; func_name: "cannyCartoon"}
                            ListElement { text: "Color Sheet"; func_name: "colorSheet"}
                            ListElement { text: "Day Light"; func_name: "dayLight"}
                            ListElement { text: "Emboss"; func_name: "embossFilter"}
                            ListElement { text: "Invert"; func_name: "invert"}
                            ListElement { text: "Pencil Sketch"; func_name: "pencilSketch"}
                            ListElement { text: "Sepia"; func_name: "sepia"}
                            ListElement { text: "Splash"; func_name: "splash"}
                            ListElement { text: "Summer"; func_name: "summer"}
                            ListElement { text: "Thresh Cartoon"; func_name: "threshCartoon"}
                            ListElement { text: "Winter"; func_name: "winter"}
                        }
                        width: 200
                        onCurrentIndexChanged: () => {
                                                   targetimage.reset()
                                                   filter.args = ({func_name: filterItems.get(currentIndex).func_name})
                                                   filter.option = currentIndex
                                                   filter.height = Utils.getHeight(parent)
                                               }
                    }

                    // Canny Cartoon
                    Ui.Slider {
                        visible: (filter.option == 0)
                        from: 0
                        to: 127
                        unit: " strength"
                        key: "strength"
                    }

                    // Color Sheet
                    Ui.Switch {
                        visible: (filter.option == 1)
                        text: "Black Screen"
                        key: "black_screen"
                    }
                    Ui.Switch {
                        visible: (filter.option == 1)
                        text: "No Red"
                        key: "noRed"
                    }
                    Ui.Switch {
                        visible: (filter.option == 1)
                        text: "No Green"
                        key: "noGreen"
                    }
                    Ui.Switch {
                        visible: (filter.option == 1)
                        text: "No Blue"
                        key: "noBlue"
                    }
                    Ui.Slider {
                        visible: (filter.option == 1)
                        from: 0
                        to: 2
                        stepSize: 0.1
                        unit: " Red"
                        key: "redStrength"
                    }
                    Ui.Slider {
                        visible: (filter.option == 1)
                        from: 0
                        to: 2
                        stepSize: 0.1
                        unit: " Green"
                        key: "greenStrength"
                    }
                    Ui.Slider {
                        visible: (filter.option == 1)
                        from: 0
                        to: 2
                        stepSize: 0.1
                        unit: " Blue"
                        key: "blueStrength"
                    }

                    // Day Light
                    Ui.Slider {
                        visible: (filter.option == 2)
                        from: 1
                        to: 3
                        stepSize: 0.1
                        unit: " lighting"
                        key: "lighting"
                    }

                    // Emboss Filter
                    Ui.Switch {
                        visible: (filter.option == 3)
                        text: "Bottom Left"
                        key: "bottom_left"
                    }
                    Ui.Switch {
                        visible: (filter.option == 3)
                        text: "Bottom Right"
                        key: "bottom_right"
                    }
                    Ui.Switch {
                        visible: (filter.option == 3)
                        text: "Top Left"
                        key: "top_left"
                    }
                    Ui.Switch {
                        visible: (filter.option == 3)
                        text: "Top Right"
                        key: "top_right"
                    }

                    // Invert
                    Ui.Switch {
                        visible: (filter.option == 4)
                        text: "Apply"
                    }

                    // Pencil Sketch
                    Ui.Switch {
                        visible: (filter.option == 5)
                        text: "Apply"
                    }

                    // Sepia
                    Ui.Switch {
                        visible: (filter.option == 6)
                        text: "Apply"
                    }

                    // Splash
                    Ui.Slider {
                        visible: (filter.option == 7)
                        from: 0
                        to: 255
                        unit: " Min Hue"
                        key: "min_hue"
                    }
                    Ui.Slider {
                        visible: (filter.option == 7)
                        from: 0
                        to: 255
                        unit: " Max Hue"
                        key: "max_hue"
                    }

                    // Summer Filter
                    Ui.Slider {
                        visible: (filter.option == 8)
                        from: 0
                        to: 1
                        stepSize: 0.01
                        unit: " Value"
                        key: "summer_value"
                    }

                    // Thresh Cartoon
                    Ui.Slider {
                        visible: (filter.option == 9)
                        from: 0
                        to: 10
                        unit: " Value"
                        key: "threshold_value"
                    }

                    // Winter Filter
                    Ui.Slider {
                        visible: (filter.option == 10)
                        from: 0
                        to: 1
                        stepSize: 0.01
                        unit: " Value"
                        key: "winter_value"
                    }
                }
            }
            Ui.Feature {
                id: blending
                name: "Blending"
                args: ({func_name: "blend"})
                property var fileGot : 0

                Column {
                    x: 25; y: 35

                    Button {
                        // visible: (blending.fileGot == 0)
                        text: 'Upload'
                        onClicked: blendFileDialog.open()
                    }

                    Ui.Slider {
                        visible: (blending.fileGot == 1)
                        from: 0
                        to: 1
                        stepSize: 0.01
                        unit: " alpha"
                        key: "alpha"
                    }
                    Ui.Slider {
                        visible: (blending.fileGot == 1)
                        from: -50
                        to: 50
                        unit: " alpha"
                        key: "contrast"
                    }
                }
                FileDialog {
                    id: blendFileDialog
                    title: "Image to blend"
                    folder: shortcuts.home
                    onAccepted: {
                        blending.args['secondary_image'] = fileUrl.toString();
                        blending.fileGot = 1;
                        blending.height = Utils.getHeight(blending.children[1]);
                    }
                    property var imageNameFilters : ["*.png", "*.jpg", "*.jpeg"]
                }
            }
        }
    }
}
