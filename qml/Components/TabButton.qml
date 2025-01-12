import QtQuick

import "../Consts"

Item {
    id: root
    width: 150
    height: 100

    Colors { id: colors }

    signal clicked()

    property color enabledColor: colors.transparent
    property color hoverColor: colors.transparent
    property color disabledColor: colors.transparent

    property color textEnabledColor: colors.transparent
    property color textHoverColor: colors.transparent
    property color textDisabledColor: colors.transparent

    property bool isEnabled: true
    property bool isHovered: false

    property string enabledImageSource: ""
    property string disabledImageSource: ""
    property int imageWidth: 24
    property int imageHeight: 24
    property string text: ""
    property int fontSize: 12

    Rectangle {
        id: background
        anchors.fill: parent
        border.color: colors.transparent
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
                root.clicked()
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
                source: isEnabled ? root.enabledImageSource : root.disabledImageSource
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
                color: isHovered
                    ? root.textHoverColor
                    : (isEnabled ? root.textEnabledColor : root.textDisabledColor)
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
