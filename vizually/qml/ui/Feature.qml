import QtQuick 2.0
import QtQuick.Controls 2.15

import "../Fonts"

Rectangle {
    id: feature
    width: parent.width; height: 30
    color: "#eee"
    clip: true
    property string name: "Feature"
    property int total_height: height + 30      // 30 => to display title
    property var args

    property var toggle: () => {
        if (sidebar.opened && sidebar.opened != feature) {
            sidebar.opened.toggle()
        }
        
        if (feature.height > 30) {
            feature.total_height = feature.height + 30
            feature.height = 30     // close
        } else {
            feature.height = feature.total_height - 30      //open
        }

        vsymbol.text = String.fromCharCode('^'.charCodeAt(0) + 'V'.charCodeAt(0) - vsymbol.text.charCodeAt(0))
    
        if (vsymbol.text == "^")
            {   
                sidebar.opened = feature
                feature.children[1].visible = 1
            }
        else
            {
                sidebar.opened = 0
                feature.children[1].visible = 0
                image.mainImage.reset()
            }
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
            text: "V"
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
