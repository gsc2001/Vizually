import QtQuick 2.0
import QtQuick.Controls 2.15

Slider {
    x: 0; y: 0
    id: slider
    from: 0
    to: 360
    value: slider.from
    stepSize: 1
	property string unit: ""
    property string key
    property var feature: parent.parent
    onVisibleChanged: {
        value = slider.from
        text.text = slider.from + unit
        feature.update(key, slider.value)
    }

    function change() {
        if (Number.isInteger(stepSize)) {
            feature.update(key, slider.value)
            text.text = slider.value + unit
        }
        else
        {
            feature.update(key, slider.value)
            text.text = slider.value.toFixed(1) + unit
        }
    }
	onMoved: change()

    Text {
        id: text
        text: slider.value + unit
        anchors.left: parent.right
        // anchors.Margin: 5
        y: 10
    }

    implicitWidth: 200

    // onCompleted
    // implicitHeight: 26
}