import QtQuick 2.0
import QtQuick.Controls 2.15

TextField {
    x: 0
    id: field
    property string unit: ""
    property string key: ""
    function change() {
        parent.parent.update(key, field.text) 
    }
    onVisibleChanged: {
        if (visible) {
            change()
        }
    }
    validator:IntValidator {bottom: 0; top: 99999}
    Text {
        text: unit
        anchors.left: parent.right
        y: 10
    }

    implicitWidth: 150

    Component.onCompleted: {
        field.editingFinished.connect(change)
    }
}
