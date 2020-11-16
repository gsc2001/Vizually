import QtQuick 2.0
import QtQuick.Controls 2.15

import "." as Ui

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

                // Blur
                Ui.Feature {
                    id: blur
                    name: "Blur"
                    property int option: 0
                    args: ({func_name: blurItems.get(0).func_name})
                    height: blurItems.get(0).height

                    Column {
                    x: 25; y: 35

                        ComboBox {
                            currentIndex: 0
                            textRole: "text"
                            model: ListModel {
                                id: blurItems
                                ListElement { text: "Average Blur"; func_name: "avgBlur"; height: 130}
                                ListElement { text: "Gaussian Blur"; func_name: "gaussianBlur"; height: 160}
                                ListElement { text: "Bilateral Blur"; func_name: "bilateralBlur"; height: 130}
                            }
                            width: 200
                            onCurrentIndexChanged: () => {
                                image.mainImage.reset()
                                blur.args = ({func_name: blurItems.get(currentIndex).func_name})
                                blur.option = currentIndex
                                blur.height = blurItems.get(blur.option).height
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

                // Blur
                // Ui.Feature {
                //     id: blur
                //     name: "Blurring"
                //     args: ({func_name: "avgBlur"})
                //     Column {
                //     x: 25; y: 35

                //         Ui.Slider {
                //             from: 1
                //             to: 20
                //             unit: "%"
                //             key: "blurValue"
                //         }
                //     }
                // }

                // Edge Detection
                Ui.Feature {
                    id: edge
                    name: "Edge"
                    property int option: 0
                    args: ({func_name: edgeItems.get(0).func_name})
                    height: 130

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
                                image.mainImage.reset()
                                edge.args = ({func_name: edgeItems.get(currentIndex).func_name})
                                edge.option = currentIndex
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

                        //sobel
                        Ui.Switch {
                            visible: (edge.option == 1)
                            text: "Apply"
                        }
                    }
                }

                // Thresholding
                Ui.Feature {
                    id: thresholding
                    name: "Thresholding"
                    property int option: 0
                    args: ({func_name: thresholdingItems.get(0).func_name})
                    height: 130

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
                                image.mainImage.reset()
                                thresholding.args = ({func_name: thresholdingItems.get(currentIndex).func_name})
                                thresholding.option = currentIndex
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
                    args: ({func_name: "flip", horizontal: false, vertical: false})

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

                        Ui.Slider{
                            from: 0
                            to: 3
                            value: 0
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