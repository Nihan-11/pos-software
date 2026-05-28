import QtQuick
import "components"

PageShell {
    title: "Inventory"
    content: Component {
        DataTable {
            tableModel: backend.inventoryModel
            columns: [
                {"label": "SKU", "role": "sku", "width": 140},
                {"label": "Name", "role": "name", "width": 240},
                {"label": "Stock", "role": "stock", "width": 100},
                {"label": "Status", "role": "status", "width": 140}
            ]
        }
    }
}
