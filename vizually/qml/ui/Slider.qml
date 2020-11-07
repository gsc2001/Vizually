import QtQuick 2.0
import QtQuick.Controls 2.15

Slider {
    x: 0; y: 0
    id: slider
    from: 0
    to: 360
    value: 0
    stepSize: 1
	property string unit: ""
    property string key
    onVisibleChanged: {
        value = 0
        text.text = '0'+ unit
        parent.parent.update(key, slider.value)
    }

    function change() {
        if (Number.isInteger(stepSize)) {
            parent.parent.update(key, slider.value)
            text.text = slider.value + unit
        }
        else
        {
            parent.parent.update(key, slider.value)
            text.text = slider.value.toFixed(1) + unit
        }
    }
	onMoved: change()

    Text {
        id: text
        text: '0'+ unit
        anchors.left: parent.right
        // anchors.Margin: 5
        y: 10
    }

    implicitWidth: 200
    // implicitHeight: 26
}