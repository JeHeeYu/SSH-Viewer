import QtQuick

Item {
    id: root

    // 경로를 절대 경로로 설정해 확인
    readonly property string add: "qrc:/assets/images/add.png"

    Component.onCompleted: {
        console.log("Resolved URL for add:", add);
    }
}
