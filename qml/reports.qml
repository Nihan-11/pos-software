import QtQuick
import "components"

PageShell {
    title: "Reports"
    content: Component {
        DataTable {
            tableModel: backend.reportsModel
            columns: [
                {"label": "Report", "role": "name", "width": 250},
                {"label": "Status", "role": "status", "width": 140},
                {"label": "Period", "role": "period", "width": 180}
            ]
        }
    }
}
