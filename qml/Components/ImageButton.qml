import QtQuick

Image {
    id: root
    width: 640
    height: 480

    signal imageClic()

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            root.imageClic()
        }
    }
}
