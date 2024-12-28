import QtQuick

import "Components"
import "Consts"

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Images { id: images }

    ImageButton {
        source: images.add
        width: 30
        height: 30
    }
}
