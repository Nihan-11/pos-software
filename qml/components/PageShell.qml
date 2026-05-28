import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".." as App

Rectangle {
    id: root
    property string title: ""
    property alias content: contentLoader.sourceComponent

    color: App.Theme.bg

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16

        Text {
            text: root.title
            color: App.Theme.text
            font.pixelSize: 28
            font.bold: true
            Layout.fillWidth: true
        }

        Loader {
            id: contentLoader
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    opacity: 0
    x: 30
    Component.onCompleted: {
        opacity = 1
        x = 0
    }
    Behavior on opacity { NumberAnimation { duration: App.Theme.smooth } }
    Behavior on x { NumberAnimation { duration: App.Theme.smooth; easing.type: Easing.OutCubic } }
}
