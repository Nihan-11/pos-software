import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import ".." as App

Button {
    id: root
    property color baseColor: App.Theme.accent
    property color textColor: App.Theme.text

    font.pixelSize: 15
    padding: 12
    hoverEnabled: true

    background: Item {
        implicitWidth: 140
        implicitHeight: 44

        Rectangle {
            id: shadow
            anchors.fill: bg
            anchors.margins: -2
            radius: bg.radius + 2
            color: "black"
            opacity: root.down ? 0.25 : root.hovered ? 0.35 : 0.18
            y: root.down ? 2 : 4
            Behavior on opacity { NumberAnimation { duration: App.Theme.quick } }
            Behavior on y { NumberAnimation { duration: App.Theme.quick } }
        }

        Rectangle {
            id: bg
            anchors.fill: parent
            radius: 12
            color: root.down ? App.Theme.accentPress : root.hovered ? Qt.tint(root.baseColor, "#20ffffff") : root.baseColor
            scale: root.down ? 0.97 : root.hovered ? 1.02 : 1.0
            Behavior on color { ColorAnimation { duration: App.Theme.quick } }
            Behavior on scale { NumberAnimation { duration: App.Theme.quick; easing.type: Easing.OutCubic } }
        }
    }

    contentItem: Text {
        text: root.text
        color: root.textColor
        font: root.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
