import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle {
    id: feature
    width: 300; height: 80
    color: "#eee"
    radius: 10
    clip: true
    property string name: "Feature"
    property int change: height + 30

    Behavior on height { NumberAnimation { duration: 250 } }

    Rectangle {
        color: '#eee'
        width: 300; height: 30
        anchors.top: parent.top
        radius: 10

        Text {
            id: vsymbol
            text: 'V'
            anchors.verticalCenter: parent.verticalCenter
            // x: 280
            anchors.right: parent.right
            anchors.rightMargin: 10
            font.bold: true
            font.pointSize: 10
        }
        Text {
            id: fname
            text: name
            anchors.verticalCenter: parent.verticalCenter
            x: 20
            font.italic: true
            font.pointSize: 13
        }

        MouseArea {
            anchors.fill: parent
            onClicked: () => {
                feature.height = feature.change - feature.height
                vsymbol.text = String.fromCharCode('^'.charCodeAt(0) + 'V'.charCodeAt(0) - vsymbol.text.charCodeAt(0))
            }
        }
    }

    Component.onCompleted: () => {
        change = change
        height = change - height
    }
}