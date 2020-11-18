import QtQuick 2.0
import QtQuick.Controls 2.15

Slider {
    x: 0; y: 0
    id: slider
    from: 0
    to: 360
    stepSize: 1
    value: slider.from
    property var def_val: 0
    property string unit: ""
    property string key
    onVisibleChanged: {
        if (visible) {
            value = def_val
            text.text = def_val + unit
            parent.parent.update(key, def_val)
        } else {
            parent.parent.args[key] = def_val
        }
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
        text: slider.value + unit
        anchors.left: parent.right
        y: 10
    }

    implicitWidth: 200

    Component.onCompleted: {
        def_val = slider.value
        def_val = def_val
    }
}
