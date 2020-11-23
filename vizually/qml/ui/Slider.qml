import QtQuick 2.0
import QtQuick.Controls 2.15

Slider {
    x: 0
    id: slider
    from: 0
    to: 360
    stepSize: 1
    value: slider.from
    property string unit: ""
    property string key
    function change() {
        parent.parent.update(key, slider.value)        
    }
    onVisibleChanged: {
        if (visible) {
            change()
        }
    }
    onMoved: change()

    Text {
        text: slider.value.toFixed(2) + unit
        anchors.left: parent.right
        y: 10
    }

    implicitWidth: 180
}
