import QtQuick
import "components"

PageShell {
    title: "Stock Alerts"
    content: Component {
        DataTable {
            tableModel: backend.stockAlertsModel
            columns: [
                {"label": "Item", "role": "item", "width": 250},
                {"label": "Remaining", "role": "remaining", "width": 130},
                {"label": "Severity", "role": "severity", "width": 180}
            ]
        }
    }
}
