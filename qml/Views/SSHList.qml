import QtQuick
import "../Components"

Item {
    Rectangle {
        anchors.fill: parent
        color: colors.mainBackground
        border.color: colors.line
        border.width: 1

        ListView {
            id: sshListView
            anchors.fill: parent
            spacing: 5
            header: Item {
                width: parent.width
                height: 10
            }
            delegate: sshListDelegate
            model: sshModel.sshList
        }

        Component {
            id: sshListDelegate

            Rectangle {
                id: sshListItem
                width: sshListView.width * 0.95
                height: 50
                color: colors.disable
                border.color: colors.line
                border.width: 1
                radius: 12
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    id: hoverArea
                    anchors.fill: parent
                    hoverEnabled: true
                }

                Item {
                    id: contentItem
                    width: parent.width
                    height: parent.height

                    Text {
                        text: modelData.hostName + ':' + modelData.port
                        color: colors.white
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                    }

                    Item {
                        id: rightGroup
                        width: 100
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10

                        Row {
                            id: indicatorAndButtons
                            spacing: 5
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right

                            Rectangle {
                                id: indicator
                                width: 16
                                height: 16
                                radius: 8
                                color: modelData.isConnected ? colors.primary : colors.red
                                visible: !hoverArea.containsMouse
                            }

                            Row {
                                id: actionButtons
                                spacing: 5
                                visible: hoverArea.containsMouse

                                ImageButton {
                                    source: images.close
                                    width: 20
                                    height: 20
                                    hoverEnabled: hoverArea.containsMouse
                                    onClicked: {
                                        sshModel.removeSSHList(modelData.hostName, modelData.userName);
                                    }
                                }

                                ImageButton {
                                    source: images.editEnable
                                    width: 20
                                    height: 20
                                    hoverEnabled: hoverArea.containsMouse
                                    onClicked: {
                                        sshModel.editSSHList(modelData.hostName, modelData.userName);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
