import QtQuick
import QtQuick.Controls

import "Components"
import "Consts"
import "./"
import "./Views"

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
        id: sideBar
        barWidth: parent.width * 0.25
        barHeight: parent.height * 0.8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

    TabBarArea {
        id: tabBarArea
        areaWidth: parent.width
        areaHeight: 40
        anchors.left: sideBar.right
        anchors.bottom: sideBar.bottom
        anchors.bottomMargin: sideBar.height + areaHeight
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

                Row {
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        text: "Host:"
                        font.pixelSize: 14
                        color: "black"
                        width: 80
                        verticalAlignment: Text.AlignVCenter
                    }
                    TextField {
                        id: hostField
                        placeholderText: "Enter host"
                        color: "black"
                        width: 200
                    }
                }

                Row {
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        text: "Username:"
                        font.pixelSize: 14
                        color: "black"
                        width: 80
                        verticalAlignment: Text.AlignVCenter
                    }
                    TextField {
                        id: usernameField
                        placeholderText: "Enter username"
                        color: "black"
                        width: 200
                    }
                }

                Row {
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        text: "Password:"
                        font.pixelSize: 14
                        color: "black"
                        width: 80
                        verticalAlignment: Text.AlignVCenter
                    }
                    TextField {
                        id: passwordField
                        placeholderText: "Enter password"
                        color: "black"
                        width: 200
                        echoMode: TextInput.Password
                    }
                }

                Row {
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        text: "Port:"
                        font.pixelSize: 14
                        color: "black"
                        width: 80
                        verticalAlignment: Text.AlignVCenter
                    }
                    TextField {
                        id: portField
                        placeholderText: "Enter port"
                        color: "black"
                        width: 200
                        text: ""
                    }
                }


                Row {
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomButton {
                        text: "Add"
                        width: 100
                        height: 30
                        onClicked: {
                            if (hostField.text !== "" && usernameField.text !== "" && passwordField.text !== "") {
                                // sshListModel.append({
                                //     name: "Host: " + hostField.text + ", User: " + usernameField.text
                                // });
                                console.log("Added SSH entry: Host:", hostField.text, "User:", usernameField.text);

                                sshPopup.close();


                                sshModel.addSSHList(hostField.text, usernameField.text, passwordField.text, portField.text);

                                hostField.text = "";
                                usernameField.text = "";
                                passwordField.text = "";
                                portField.text = "";
                            }
                        }
                    }

                    CustomButton {
                        text: "Cancel"
                        width: 100
                        height: 30
                        onClicked: sshPopup.close
                    }
                }
            }
        }
    }
}
