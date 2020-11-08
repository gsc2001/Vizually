import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle {
    id: feature
    width: 300; height: 80
    color: "#eee"
    radius: 10
    clip: true
    property string name: "Feature"
    property int total_height: height + 30
    property var args
    property var fun: function() {image.mainImage.apply(args)}

    property var toggle: () => {
        if (parent.opened != feature && parent.opened) {
            parent.opened.toggle()
        }
        
        feature.height = feature.total_height - feature.height
        vsymbol.text = String.fromCharCode('^'.charCodeAt(0) + 'V'.charCodeAt(0) - vsymbol.text.charCodeAt(0))
    
        if (vsymbol.text == "^")
            {   
                parent.opened = feature
                feature.children[1].visible = 1
            }
        else
            {
                parent.opened = 0
                feature.children[1].visible = 0
            }
    }

    property var update: (key, value) => {
        args[key] = value
        fun()
    }

    Behavior on height { NumberAnimation { duration: 100 } }

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
            onClicked: toggle()
        }
    }

    Component.onCompleted: () => {
        total_height = total_height
        height = total_height - height
    }
}