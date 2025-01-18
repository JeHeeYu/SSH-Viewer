import QtQuick
import QtQuick.Controls

import "../Consts"

Item {
    id: root

    Colors { id: colors }

    property int areaWidth: parent.width
    property int areaHeight: parent.height
    property int currentTabIndex: -1

    Rectangle {
        width: areaWidth
        height: areaHeight
        color: colors.mainBackground
        border.color: colors.line
        border.width: 1

        Row {
            id: buttonRow
            spacing: 10
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 10
        }
    }

    Component {
        id: selectableButton
        Item {
            width: 100
            height: 40

            property alias text: label.text
            property bool isSelected: false

            signal clicked()

            Rectangle {
                id: background
                anchors.fill: parent
                color: colors.transparent
                border.color: colors.transparent
            }

            Text {
                id: label
                anchors.centerIn: parent
                text: ""
                color: colors.white
            }

            Rectangle {
                id: indicator
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: colors.primary
                visible: isSelected
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.currentTabIndex = buttonRow.children.indexOf(parent);
                    root.updateSelection();
                }
            }
        }
    }

    function updateSelection() {
        for (var i = 0; i < buttonRow.children.length; i++) {
            var button = buttonRow.children[i];
            button.isSelected = (i === currentTabIndex);
        }
    }

    function addButton(text) {
        var button = selectableButton.createObject(buttonRow, { text: text });
        if (button === null) {
            console.error("Failed to create button");
        }
    }

    Component.onCompleted: {
        addButton("Button 1");
        addButton("Button 2");
        addButton("Button 3");
    }
}
