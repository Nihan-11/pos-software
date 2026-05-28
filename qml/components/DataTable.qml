import QtQuick
import QtQuick.Controls
import ".." as App

Rectangle {
    id: root
    property var tableModel
    property var columns: []

    color: App.Theme.panel
    radius: 14
    border.color: Qt.rgba(1, 1, 1, 0.08)

    Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        Row {
            spacing: 8
            Repeater {
                model: root.columns
                delegate: Text {
                    text: modelData.label
                    width: modelData.width
                    color: App.Theme.mutedText
                    font.pixelSize: 13
                }
            }
        }

        Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.08) }

        ListView {
            id: list
            width: parent.width
            height: parent.height - 42
            clip: true
            spacing: 6
            model: root.tableModel

            add: Transition {
                NumberAnimation { property: "opacity"; from: 0; to: 1; duration: App.Theme.smooth }
                NumberAnimation { property: "x"; from: 32; to: 0; duration: App.Theme.smooth; easing.type: Easing.OutCubic }
            }
            remove: Transition {
                NumberAnimation { property: "opacity"; to: 0; duration: App.Theme.quick }
            }
            displaced: Transition {
                NumberAnimation { property: "y"; duration: App.Theme.normal; easing.type: Easing.OutQuad }
            }

            delegate: Rectangle {
                width: list.width
                height: 36
                radius: 8
                color: Qt.rgba(1,1,1,0.04)

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8
                    Repeater {
                        model: root.columns
                        delegate: Text {
                            width: modelData.width
                            color: App.Theme.text
                            font.pixelSize: 13
                            text: {
                                const value = model[modelData.role]
                                return value === undefined || value === null ? "" : value.toString()
                            }
                        }
                    }
                }
            }
        }
    }
}
