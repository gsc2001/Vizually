import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Extras 1.4

ApplicationWindow {
    id: mainWindow
    height: 900
    width: 1600

    SwipeView {
        id: swipeView
        x: 0
        y: 0
        width: 350
        height: 900

        Item {
            id: item1
            x: 204
            y: 358
            width: 200
            height: 200
        }
    }

    Flickable {
        id: flickable
        x: 350
        y: 0
        width: 1250
        height: 900

        Image {
            id: image
            x: 142
            y: 146
            width: 926
            height: 620
            source: "../data/images/test.jpg"
            fillMode: Image.PreserveAspectFit
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
