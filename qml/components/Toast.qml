import QtQuick
import QtQuick.Controls
import ".." as App

Item {
    id: root
    property string message: ""
    property string type: "info"

    signal dismissed()

    anchors.horizontalCenter: parent.horizontalCenter
    width: Math.min(parent.width * 0.7, 520)
    height: bubble.implicitHeight
    visible: opacity > 0
    opacity: 0
    y: parent.height - height - 24

    function show(kind, text) {
        type = kind
        message = text
        anim.restart()
    }

    Rectangle {
        id: bubble
        width: parent.width
        implicitHeight: msg.paintedHeight + 26
        radius: 12
        color: type === "error" ? App.Theme.danger : type === "success" ? App.Theme.success : App.Theme.panelAlt

        Text {
            id: msg
            anchors.fill: parent
            anchors.margins: 12
            wrapMode: Text.Wrap
            text: root.message
            color: App.Theme.text
            font.pixelSize: 14
        }
    }

    SequentialAnimation {
        id: anim
        NumberAnimation { target: root; property: "opacity"; to: 1; duration: App.Theme.quick }
        PauseAnimation { duration: 2200 }
        NumberAnimation { target: root; property: "opacity"; to: 0; duration: App.Theme.quick }
        ScriptAction { script: root.dismissed() }
    }
}
