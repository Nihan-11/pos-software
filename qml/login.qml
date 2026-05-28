import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components"
import "." as App

Rectangle {
    id: root
    signal submit(string username, string password)

    color: App.Theme.bg

    Rectangle {
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.9, 460)
        height: 350
        radius: 20
        color: App.Theme.panel
        border.color: Qt.rgba(1, 1, 1, 0.1)

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 14

            Text {
                text: "POS Login"
                color: App.Theme.text
                font.pixelSize: 30
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            TextField {
                id: username
                placeholderText: "Username"
                Layout.fillWidth: true
                color: App.Theme.text
                placeholderTextColor: App.Theme.mutedText
                background: Rectangle { radius: 10; color: App.Theme.panelAlt }
            }

            TextField {
                id: password
                placeholderText: "Password"
                echoMode: TextInput.Password
                Layout.fillWidth: true
                color: App.Theme.text
                placeholderTextColor: App.Theme.mutedText
                background: Rectangle { radius: 10; color: App.Theme.panelAlt }
            }

            AnimatedButton {
                text: "Sign In"
                Layout.fillWidth: true
                onClicked: root.submit(username.text, password.text)
            }

            Item { Layout.fillHeight: true }
        }

        BusyIndicator {
            id: loading
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 14
            running: false
            visible: running
        }
    }

    function setLoading(active) {
        loading.running = active
    }

    opacity: 0
    Component.onCompleted: opacity = 1
    Behavior on opacity { NumberAnimation { duration: App.Theme.smooth } }
}
