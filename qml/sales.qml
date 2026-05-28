import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components"

PageShell {
    title: "Sales / POS"
    content: Component {
        ColumnLayout {
            spacing: 12

            RowLayout {
                Layout.fillWidth: true
                TextField {
                    id: itemName
                    placeholderText: "Add item"
                    Layout.fillWidth: true
                }
                AnimatedButton {
                    text: "Add"
                    onClicked: backend.addSale(itemName.text)
                }
            }

            DataTable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                tableModel: backend.salesModel
                columns: [
                    {"label": "Transaction", "role": "id", "width": 140},
                    {"label": "Item", "role": "item", "width": 240},
                    {"label": "Qty", "role": "qty", "width": 70},
                    {"label": "Total", "role": "total", "width": 120}
                ]
            }
        }
    }
}
