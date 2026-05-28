import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components"

PageShell {
    title: "Settings"
    content: Component {
        ColumnLayout {
            spacing: 12

            RowLayout {
                Layout.fillWidth: true
                TextField {
                    id: keyInput
                    placeholderText: "Key"
                    Layout.fillWidth: true
                }
                TextField {
                    id: valueInput
                    placeholderText: "Value"
                    Layout.fillWidth: true
                }
                AnimatedButton {
                    text: "Save"
                    onClicked: backend.updateSetting(keyInput.text, valueInput.text)
                }
            }

            DataTable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                tableModel: backend.settingsModel
                columns: [
                    {"label": "Setting", "role": "key", "width": 200},
                    {"label": "Value", "role": "value", "width": 300}
                ]
            }
        }
    }
}
