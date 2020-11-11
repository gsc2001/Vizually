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

                property var opened: sidebar.opened

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
                    name: "Blur"
                    property int option: 0
                    args: blurItems.get(0).func_name
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
                                blur.option = currentIndex
                                blur.height = blurItems.get(blur.option).height
                                blur.args = ({func_name: blurItems.get(blur.option).func_name})
                            }
                        }

                        Ui.Slider {
                            visible: (blur.option == 0)
                            from: 1
                            to: 20
                            unit: "%"
                            key: "blurValue"
                        }

                        Ui.Slider {
                            visible: (blur.option == 1)
                            from: 0
                            to: 2
                            stepSize: 0.1
                            unit: "%"
                            key: "sigmaX"
                        }

                        Ui.Slider {
                            visible: (blur.option == 1)
                            from: 0
                            to: 2
                            stepSize: 0.1
                            unit: "%"
                            key: "sigmaY"
                        }

                        Switch {
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
                //             // fun: function() {image.mainImage.apply({func_name: "avgBlur", blurValue: value})}
                //         }
                //     }
                // }
                
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
                    args: ({func_name: "sharpen", strength: 0.0, kernel_size: 0})

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