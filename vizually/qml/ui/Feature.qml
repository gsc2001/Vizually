import QtQuick 2.0
import QtQuick.Controls 2.15
import "Utils.js" as Utils

// import "../Fonts"

Rectangle {
    id: feature
    width: parent.width; height: 80
    color: "#eee"
    clip: true
    property string name: "Feature"
    property int total_height: height + 30      // 30 => to display title
    property var args

    property var toggle: () => {
        if (sidebar.opened && sidebar.opened != feature) {
            sidebar.opened.toggle()
        }
        vsymbol.text = String.fromCharCode('\uf106'.charCodeAt(0) + '\uf107'.charCodeAt(0) - vsymbol.text.charCodeAt(0))
    
        if (vsymbol.text == "\uf106") {   
            sidebar.opened = feature
            feature.children[1].visible = 1
        } else {
            sidebar.opened = 0
            feature.children[1].visible = 0
            targetimage.reset()
        }

        feature.height = Utils.getHeight(children[1])
    }

    property var update: (key, value) => {
                             args[key] = value
                             if (loaded) {
                                 targetimage.apply(args)
                             }
                         }

    Behavior on height { NumberAnimation { duration: 100 } }

    Rectangle {

        id: topheader
        color: '#fff'
        width: parent.width; height: 30
        anchors.top: parent.top
        radius: 5

        Text {
            id: vsymbol
            text: "\uf107"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
        }
        Text {
            id: fname
            text: name
            anchors.verticalCenter: parent.verticalCenter
            x: 10
            font.italic: true
            font.pointSize: 13
        }

        MouseArea {
            anchors.fill: parent
            onClicked: toggle()
        }
    }

    Component.onCompleted: {
        total_height = total_height
        height = total_height - height
        feature.children[1].visible = 0
    }
}
