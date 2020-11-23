import QtQuick 2.0
import QtQuick.Controls 2.15

Switch {
    x: 0; y: 0
    id: swtch
    text: "Apply"
    property string key: "apply"
    function change() {
        parent.parent.update(key, swtch.checked)        
    }
    onVisibleChanged: {
        if (visible) {
            change()
        } 
    }

    onClicked: change()
}