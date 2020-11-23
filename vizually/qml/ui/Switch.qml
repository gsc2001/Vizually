import QtQuick 2.0
import QtQuick.Controls 2.15

Switch {
    x: 0; y: 0
    id: swtch
    text: "Try"
    property bool reset: false
    property string key: "apply"
    function change() {
        parent.parent.update(key, swtch.checked)        
    }
    onVisibleChanged: {
        if (visible) {
            if(reset == true){
                swtch.checked = false
            }
            change()
        } 
    }

    onClicked: change()
}