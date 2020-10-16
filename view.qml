import QtQuick 2.0

Rectangle {
    id: page
    width: 320; height: 480
    color: "lightgray"

    Text {
        id: helloText
        text: "hello world"
        y: 30
        anchors.verticalCenter: page.verticalCenter ; anchors.horizontalCenter: page.horizontalCenter
        font.pointSize: 24; font.bold: true; color: "red"
    }
}
