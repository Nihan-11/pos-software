import QtQuick
import QtQuick.Controls
import ".." as App

Rectangle {
    id: root
    property string title: ""
    property string value: ""
    property string trend: ""

    radius: 16
    color: App.Theme.panelAlt

    Rectangle {
        anchors.fill: parent
        anchors.margins: 2
        radius: 14
        color: "transparent"
        border.color: Qt.rgba(1, 1, 1, 0.08)
    }

    Column {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text { text: root.title; color: App.Theme.mutedText; font.pixelSize: 14 }
        Text { text: root.value; color: App.Theme.text; font.pixelSize: 28; font.bold: true }
        Text {
            text: root.trend
            color: root.trend.indexOf("-") === 0 ? App.Theme.danger : App.Theme.success
            font.pixelSize: 13
        }
    }

    opacity: 0
    y: 14
    Component.onCompleted: {
        opacity = 1
        y = 0
    }
    Behavior on opacity { NumberAnimation { duration: App.Theme.smooth } }
    Behavior on y { NumberAnimation { duration: App.Theme.smooth; easing.type: Easing.OutCubic } }
}
