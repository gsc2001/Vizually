import QtQuick 2.0
import QtQuick.Controls 2.15

RangeSlider {
    x: 20
    id: slider
    from: 0
    to: 179
    stepSize: 1
    first.value: slider.from
    second.value: slider.to
    property string minKey
    property string maxKey
    function change() {
        parent.parent.args[minKey] = slider.first.value
        parent.parent.update(maxKey, slider.second.value)
    }
    onVisibleChanged: {
        if (visible) {
            change()
        } else {
            delete parent.parent.args[minKey]
            delete parent.parent.args[maxKey]
        }
    }

    // max
    Text {
        text: second.value.toFixed(0)
        anchors.left: parent.right
        y: 10
    }
    // min
    Text {
        text: first.value.toFixed(0)
        anchors.right: parent.left
        y: 10
    }

    implicitWidth: 200

    Component.onCompleted: {
        slider.first.moved.connect(change)
        slider.second.moved.connect(change)
    }
}
