import QtQuick
import "Components"
import "Consts"

Window {
    width: Screen.width
    height: Screen.height
    visible: true
    title: qsTr("Hello World")

    Images { id: images }

    ImageButton {
        source: images.add
        width: 30
        height: 30

        onClicked: {
            console.log("Jehee test");
        }
    }

    Rectangle {
        width: 350
        height: parent.height * 0.7
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        border.color: "black"
        border.width: 1

        ListView {
            id: sshListView
            width: parent.width
            height: parent.height
            delegate: sshListDelegate
            model: sshListModel
        }
    }

    ListModel {
        id: sshListModel
        ListElement { name: "Item 1" }
        ListElement { name: "Item 2" }
        ListElement { name: "Item 3" }
    }

    Component {
        id: sshListDelegate

        Rectangle {
            id: sshListItem
            width: parent.width
            height: 50

            Rectangle {
                anchors.fill: parent
                anchors.topMargin:  -border.width
                anchors.bottomMargin: -border.width
                border.width:  1
                border.color: "black"
            }

            Text {
                anchors.centerIn: parent
                text: model.name
                color: "black"
            }
        }
    }
}
