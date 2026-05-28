import QtQuick
import "components"

PageShell {
    title: "Custom Orders"
    content: Component {
        DataTable {
            tableModel: backend.customOrdersModel
            columns: [
                {"label": "Order", "role": "orderNo", "width": 120},
                {"label": "Customer", "role": "customer", "width": 220},
                {"label": "Status", "role": "status", "width": 160},
                {"label": "Amount", "role": "amount", "width": 120}
            ]
        }
    }
}
