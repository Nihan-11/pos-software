import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components"
import "." as App

PageShell {
    title: "Dashboard"
    content: Component {
        Flickable {
            contentWidth: width
            contentHeight: grid.implicitHeight
            clip: true

            GridLayout {
                id: grid
                width: parent.width
                columns: parent.width > 1100 ? 4 : parent.width > 760 ? 2 : 1
                columnSpacing: 12
                rowSpacing: 12

                Repeater {
                    model: backend.dashboardModel
                    delegate: StatCard {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 150
                        title: model.title
                        value: model.value
                        trend: model.trend
                    }
                }
            }
        }
    }
}
