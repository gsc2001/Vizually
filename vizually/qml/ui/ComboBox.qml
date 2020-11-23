import QtQuick 2.0
import QtQuick.Controls 2.15

ComboBox {
    x: 0
    id: combobox
    property string unit: "choose"
    property string key: "apply"
    currentIndex: 0

    Text {
        text: '  ' + unit
        anchors.left: parent.right
        y: 10
    }

    onVisibleChanged: {
        if (visible) {
            parent.parent.update(key, combobox.model.get(currentIndex).value)
        } else {
            parent.parent.args[key] = combobox.model.get(currentIndex).value
        }
    }
	onCurrentIndexChanged: {
        parent.parent.update(key, combobox.model.get(currentIndex).value)	
	}

    implicitWidth: 150
}