import QtQuick
import QtQuick.Controls

import "Components"
import "Consts"
import "./"

Window {
    width: Screen.width
    height: Screen.height
    visible: true
    title: qsTr("SSH Connection Manager")
    color: colors.mainBackground

    Images { id: images }
    Colors { id: colors }
    Strings { id: strings }

    ImageButton {
        source: images.add
        width: 30
        height: 30

        onClicked: {
            console.log("Add button clicked");
            sshPopup.open();
        }
    }

    SideBar {

    }

    // TabButton {
    //     id: exampleComponent
    //     anchors.centerIn: parent
    //     enabledImageSource: images.sshListEnable
    //     disabledImageSource: images.sshListDisable
    //     imageWidth: 48
    //     imageHeight: 48
    //     text: "Hello World"
    //     fontSize: 16
    //     enabledColor: colors.tabEnable
    //     hoverColor: colors.tabHoverEnable
    //     disabledColor: colors.transparent
    //     textEnabledColor: colors.white
    //     textHoverColor: colors.white
    //     textDisabledColor: colors.disable
    // }

    // Rectangle {
        // width: 350
        // height: parent.height * 0.7
        // anchors.left: parent.left
        // anchors.bottom: parent.bottom
        // border.color: "black"
        // border.width: 1

    //     ListView {
    //         id: sshListView
    //         width: parent.width
    //         height: parent.height
    //         delegate: sshListDelegate
    //         model: sshModel.sshList
    //     }
    // }

    // ListModel {
    //     id: sshListModel
    //     ListElement { name: "Item 1" }
    //     ListElement { name: "Item 2" }
    //     ListElement { name: "Item 3" }
    // }

    // Component {
    //     id: sshListDelegate

    //     Rectangle {
    //         id: sshListItem
    //         width: parent.width
    //         height: 50


    //         Rectangle {
    //             anchors.fill: parent
    //             anchors.topMargin: -border.width
    //             anchors.bottomMargin: -border.width
    //             border.width: 1
    //             border.color: "black"
    //         }

    //         Row {
    //             width: parent.width
    //             height: parent.height
    //             anchors.fill: parent
    //             anchors.leftMargin: 10
    //             spacing: 10

    //             Text {
    //                 text: "Host: " + modelData.hostName + ", User: " + modelData.userName
    //                 anchors.leftMargin: 10
    //                 anchors.verticalCenter: parent.verticalCenter
    //                 horizontalAlignment: Text.AlignLeft
    //                 verticalAlignment: Text.AlignVCenter
    //                 width: parent.width - 40
    //                 elide: Text.ElideRight
    //             }

    //             ImageButton {
    //                 source: images.close
    //                 width: 20
    //                 height: 20
    //                 anchors.rightMargin: 10
    //                 anchors.verticalCenter: parent.verticalCenter
    //                 onClicked: {
    //                     console.log("Remove button clicked for Host:", modelData.hostName);
    //                     sshModel.removeSSHList(modelData.hostName, modelData.userName);
    //                 }
    //             }
    //         }
    //     }
    // }


    // Popup {
    //     id: sshPopup
    //     width: 400
    //     height: 300
    //     modal: true
    //     dim: true
    //     closePolicy: Popup.CloseOnEscape

    //     x: (parent.width - width) / 2
    //     y: (parent.height - height) / 2

    //     Rectangle {
    //         id: popupContent
    //         anchors.fill: parent
    //         color: "white"
    //         radius: 10
    //         border.color: "#cccccc"
    //         border.width: 1

    //         MouseArea {
    //             id: dragArea
    //             anchors.fill: parent
    //             cursorShape: Qt.OpenHandCursor

    //             property real startX
    //             property real startY

    //             onPressed: function(event) {
    //                 cursorShape = Qt.ClosedHandCursor;
    //                 startX = sshPopup.x - event.x;
    //                 startY = sshPopup.y - event.y;
    //             }

    //             onReleased: function() {
    //                 cursorShape = Qt.OpenHandCursor;
    //             }

    //             onPositionChanged: function(event) {
    //                 sshPopup.x = startX + event.x;
    //                 sshPopup.y = startY + event.y;
    //             }
    //         }

    //         Column {
    //             anchors.fill: parent
    //             anchors.margins: 20
    //             spacing: 10

    //             Text {
    //                 text: "SSH Connection"
    //                 font.bold: true
    //                 font.pixelSize: 18
    //                 horizontalAlignment: Text.AlignHCenter
    //                 anchors.horizontalCenter: parent.horizontalCenter
    //             }

    //             Row {
    //                 spacing: 10
    //                 anchors.horizontalCenter: parent.horizontalCenter

    //                 Text {
    //                     text: "Host:"
    //                     font.pixelSize: 14
    //                     color: "black"
    //                     width: 80
    //                     verticalAlignment: Text.AlignVCenter
    //                 }
    //                 TextField {
    //                     id: hostField
    //                     placeholderText: "Enter host"
    //                     color: "black"
    //                     width: 200
    //                 }
    //             }

    //             Row {
    //                 spacing: 10
    //                 anchors.horizontalCenter: parent.horizontalCenter

    //                 Text {
    //                     text: "Username:"
    //                     font.pixelSize: 14
    //                     color: "black"
    //                     width: 80
    //                     verticalAlignment: Text.AlignVCenter
    //                 }
    //                 TextField {
    //                     id: usernameField
    //                     placeholderText: "Enter username"
    //                     color: "black"
    //                     width: 200
    //                 }
    //             }

    //             Row {
    //                 spacing: 10
    //                 anchors.horizontalCenter: parent.horizontalCenter

    //                 Text {
    //                     text: "Password:"
    //                     font.pixelSize: 14
    //                     color: "black"
    //                     width: 80
    //                     verticalAlignment: Text.AlignVCenter
    //                 }
    //                 TextField {
    //                     id: passwordField
    //                     placeholderText: "Enter password"
    //                     color: "black"
    //                     width: 200
    //                     echoMode: TextInput.Password
    //                 }
    //             }

    //             Row {
    //                 spacing: 10
    //                 anchors.horizontalCenter: parent.horizontalCenter

    //                 Text {
    //                     text: "Port:"
    //                     font.pixelSize: 14
    //                     color: "black"
    //                     width: 80
    //                     verticalAlignment: Text.AlignVCenter
    //                 }
    //                 TextField {
    //                     id: portField
    //                     placeholderText: "Enter port"
    //                     color: "black"
    //                     width: 200
    //                     text: ""
    //                 }
    //             }


    //             Row {
    //                 spacing: 20
    //                 anchors.horizontalCenter: parent.horizontalCenter

    //                 CustomButton {
    //                     text: "Add"
    //                     width: 100
    //                     height: 30
    //                     onClicked: {
    //                         if (hostField.text !== "" && usernameField.text !== "" && passwordField.text !== "") {
    //                             sshListModel.append({
    //                                 name: "Host: " + hostField.text + ", User: " + usernameField.text
    //                             });
    //                             console.log("Added SSH entry: Host:", hostField.text, "User:", usernameField.text);

    //                             sshPopup.close();


    //                             sshModel.addSSHList(hostField.text, usernameField.text, passwordField.text, port);

    //                             hostField.text = "";
    //                             usernameField.text = "";
    //                             passwordField.text = "";
    //                             portField.text = "";
    //                         }
    //                     }
    //                 }

    //                 CustomButton {
    //                     text: "Cancel"
    //                     width: 100
    //                     height: 30
    //                     onClicked: sshPopup.close
    //                 }
    //             }
    //         }
    //     }
    // }
}
