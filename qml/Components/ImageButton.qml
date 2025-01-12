import QtQuick

Image {
    id: root
    width: 640
    height: 480

    property bool hoverEnabled: true

    signal clicked()

    MouseArea {
        anchors.fill: parent
        hoverEnabled: hoverEnabled
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            root.clicked()
        }
    }
}
