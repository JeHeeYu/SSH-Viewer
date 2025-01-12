import QtQuick
import "./Consts"
import "./Components"

Item {
    id: root
    width: parent.width
    height: parent.height

    readonly property int tabBarButtonHeight: 65
    readonly property int listTabButtonIndex: 0
    readonly property int editTabButtonIndex: 1

    property int currentTabButtonIndex: listTabButtonIndex

    Rectangle {
        id: mainArea
        width: parent.height * 0.4
        height: parent.height * 0.8
        color: colors.mainBackground
        border.color: colors.line
        border.width: 1
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        Rectangle {
            id: buttonContainer
            width: parent.width * 0.3
            height: parent.height
            color: colors.mainBackground
            border.color: colors.line
            border.width: 1
            anchors.left: parent.left
            anchors.bottom: parent.bottom

            Column {
                id: tabButtonColumn
                spacing: 10
                anchors.fill: parent
                anchors.margins: 10

                TabButton {
                    id: sshList
                    width: buttonContainer.width - (tabButtonColumn.anchors.margins * 2)
                    height: tabBarButtonHeight
                    enabledImageSource: images.sshListEnable
                    disabledImageSource: images.sshListDisable
                    text: strings.sshList
                    fontSize: 12
                    enabledColor: colors.tabEnable
                    hoverColor: colors.tabHoverEnable
                    disabledColor: colors.transparent
                    textEnabledColor: colors.white
                    textHoverColor: colors.white
                    textDisabledColor: colors.disable
                    isEnabled: currentTabButtonIndex === listTabButtonIndex

                    onClicked: {
                        currentTabButtonIndex = listTabButtonIndex

                        console.log("Jehee 0 currentTabButtonIndex ", currentTabButtonIndex)
                    }
                }

                TabButton {
                    id: edit
                    width: buttonContainer.width - (tabButtonColumn.anchors.margins * 2)
                    height: tabBarButtonHeight
                    enabledImageSource: images.editEnable
                    disabledImageSource: images.editDisable
                    text: strings.edit
                    fontSize: 12
                    enabledColor: colors.tabEnable
                    hoverColor: colors.tabHoverEnable
                    disabledColor: colors.transparent
                    textEnabledColor: colors.white
                    textHoverColor: colors.white
                    textDisabledColor: colors.disable
                    isEnabled: currentTabButtonIndex === editTabButtonIndex

                    onClicked: {
                        currentTabButtonIndex = editTabButtonIndex

                        console.log("Jehee 1 currentTabButtonIndex ", currentTabButtonIndex)
                    }
                }
            }
        }
    }
}
