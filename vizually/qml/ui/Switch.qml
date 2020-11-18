import QtQuick 2.0
import QtQuick.Controls 2.15

Switch {
    x: 0; y: 0
    id: swtch
    text: "Apply"
    property string key: "apply"
    onVisibleChanged: {
        swtch.checked = false
        if (visible) {
            parent.parent.update(key, false)
        } else {
            parent.parent.args[key] = false
        }
    }

    onClicked: {
        parent.parent.update(key, swtch.checked)
    }
}