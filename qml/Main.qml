import QtQuick
import QtQuick.Controls
import "Components"
import "Consts"

Window {
    width: 600//Screen.width
    height: 500//Screen.height
    visible: true
    title: qsTr("SSH Connection Manager")

    Images { id: images }

    ImageButton {
        source: images.add
        width: 30
        height: 30

        onClicked: {
            console.log("Add button clicked");
            sshPopup.open();
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
            model: sshModel.sshList
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
                anchors.topMargin: -border.width
                anchors.bottomMargin: -border.width
                border.width: 1
                border.color: "black"
            }

            Text {
                anchors.centerIn: parent
                text: "Host: " + modelData.hostName + ", User: " + modelData.userName
            }
        }
    }

    Popup {
        id: sshPopup
        width: 400
        height: 300
        modal: true
        dim: true
        closePolicy: Popup.CloseOnEscape

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        Rectangle {
            id: popupContent
            anchors.fill: parent
            color: "white"
            radius: 10
            border.color: "#cccccc"
            border.width: 1

            MouseArea {
                id: dragArea
                anchors.fill: parent
                cursorShape: Qt.OpenHandCursor

                property real startX
                property real startY

                onPressed: function(event) {
                    cursorShape = Qt.ClosedHandCursor;
                    startX = sshPopup.x - event.x;
                    startY = sshPopup.y - event.y;
                }

                onReleased: function() {
                    cursorShape = Qt.OpenHandCursor;
                }

                onPositionChanged: function(event) {
                    sshPopup.x = startX + event.x;
                    sshPopup.y = startY + event.y;
                }
            }

            Column {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10

                Text {
                    text: "SSH Connection"
                    font.bold: true
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                TextField {
                    id: hostField
                    placeholderText: "Host"
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.8
                }

                TextField {
                    id: usernameField
                    placeholderText: "Username"
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.8
                }

                TextField {
                    id: passwordField
                    placeholderText: "Password"
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.8
                    echoMode: TextInput.Password
                }

                TextField {
                    id: portField
                    placeholderText: "Port"
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.8
                    text: "22"
                }

                Row {
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter

                    Button {
                        width: 100
                        height: 20

                        onClicked: {
                            if (hostField.text !== "" && usernameField.text !== "" && passwordField.text !== "") {
                                sshListModel.append({
                                    name: "Host: " + hostField.text + ", User: " + usernameField.text
                                });
                                console.log("Added SSH entry: Host:", hostField.text, "User:", usernameField.text);

                                sshPopup.close();

                                hostField.text = "";
                                usernameField.text = "";
                                passwordField.text = "";
                                portField.text = "22";

                                sshModel.addSSHList(hostField.text, usernameField.text, passwordField.text);
                            }
                        }

                    }

                    // Cancel 버튼
                    Button {
                        text: "Cancel"
                        onClicked: sshPopup.close
                    }
                }
            }
        }
    }



}
