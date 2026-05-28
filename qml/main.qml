import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "." as App
import "components"

ApplicationWindow {
    id: window
    width: 1440
    height: 900
    minimumWidth: 1100
    minimumHeight: 700
    visible: true
    title: "POS Software"
    color: App.Theme.bg

    property bool loggedIn: false
    property int currentPageIndex: 0

    readonly property var pages: [
        {"title": "Dashboard", "source": "dashboard.qml"},
        {"title": "Sales", "source": "sales.qml"},
        {"title": "Inventory", "source": "inventory.qml"},
        {"title": "Repairs", "source": "repairs.qml"},
        {"title": "Custom Orders", "source": "customorders.qml"},
        {"title": "Cash Register", "source": "cashregister.qml"},
        {"title": "Stock Alerts", "source": "stockalerts.qml"},
        {"title": "Reports", "source": "reports.qml"},
        {"title": "Settings", "source": "settings.qml"}
    ]

    Loader {
        id: loginLoader
        anchors.fill: parent
        source: loggedIn ? "" : "login.qml"
        active: !loggedIn

        onLoaded: {
            if (item && item.submit) {
                item.submit.connect(function(username, password) {
                    item.setLoading(true)
                    backend.login(username, password)
                })
            }
        }
    }

    Rectangle {
        id: shell
        anchors.fill: parent
        color: App.Theme.bg
        visible: loggedIn
        opacity: loggedIn ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: App.Theme.normal } }

        RowLayout {
            anchors.fill: parent

            Rectangle {
                Layout.preferredWidth: 260
                Layout.fillHeight: true
                color: App.Theme.panel

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 8

                    Text {
                        text: "POS Control"
                        color: App.Theme.text
                        font.pixelSize: 24
                        font.bold: true
                        Layout.bottomMargin: 10
                    }

                    Repeater {
                        model: pages
                        delegate: AnimatedButton {
                            Layout.fillWidth: true
                            text: modelData.title
                            baseColor: currentPageIndex === index ? App.Theme.accent : App.Theme.panelAlt
                            onClicked: currentPageIndex = index
                        }
                    }

                    Item { Layout.fillHeight: true }

                    AnimatedButton {
                        Layout.fillWidth: true
                        text: "Refresh"
                        onClicked: backend.refreshAll()
                    }
                }
            }

            Item {
                id: pageHolder
                Layout.fillWidth: true
                Layout.fillHeight: true

                Loader {
                    id: pageLoader
                    anchors.fill: parent
                    source: pages[currentPageIndex].source
                    opacity: 1
                    x: 0

                    onSourceChanged: {
                        opacity = 0
                        x = 40
                        appear.start()
                    }

                    SequentialAnimation {
                        id: appear
                        NumberAnimation { target: pageLoader; property: "opacity"; to: 1; duration: App.Theme.smooth }
                        NumberAnimation { target: pageLoader; property: "x"; to: 0; duration: App.Theme.smooth; easing.type: Easing.OutCubic }
                    }
                }
            }
        }
    }

    Toast {
        id: toast
        anchors.bottom: parent.bottom
    }

    Connections {
        target: backend
        function onLoginSucceeded(_username) {
            loggedIn = true
            if (loginLoader.item) {
                loginLoader.item.setLoading(false)
            }
        }
        function onLoginFailed(message) {
            if (loginLoader.item) {
                loginLoader.item.setLoading(false)
            }
            toast.show("error", message)
        }
        function onToast(kind, message) {
            toast.show(kind, message)
        }
        function onErrorOccurred(message) {
            toast.show("error", message)
        }
    }
}
