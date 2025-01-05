import QtQuick

Item {
    id: root
    width: 100
    height: 20

    property alias text: label.text

    signal clicked()

    Rectangle {
        id: background
        anchors.fill: parent
        color: "transparent"
        border.color: "black"
        border.width: 1
        radius: 8
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: ""
        color: "black"
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            root.clicked()
        }
    }
}
