import QtQuick

Item {
    id: root
    width: 150
    height: 100

    property color enabledColor: "transparent"
    property color hoverColor: "transparent"
    property color disabledColor: "transparent"

    property bool isEnabled: true
    property bool isHovered: false

    property string imageSource: ""
    property int imageWidth: 24
    property int imageHeight: 24
    property string text: ""
    property int fontSize: 12

    Rectangle {
        id: background
        anchors.fill: parent
        border.color: "black"
        border.width: 1
        radius: 8

        color: isHovered
            ? root.hoverColor
            : (isEnabled ? root.enabledColor : root.disabledColor)

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                isEnabled = !isEnabled
            }

            onEntered: {
                isHovered = true
            }

            onExited: {
                isHovered = false
            }
        }

        Column {
            id: content
            anchors.centerIn: parent
            spacing: 5

            Image {
                id: icon
                source: root.imageSource
                width: root.imageWidth
                height: root.imageHeight
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: label
                text: root.text
                font.pixelSize: root.fontSize
                horizontalAlignment: Text.AlignHCenter
                color: "black"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
