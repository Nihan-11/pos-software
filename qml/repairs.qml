import QtQuick
import "components"

PageShell {
    title: "Repairs"
    content: Component {
        DataTable {
            tableModel: backend.repairsModel
            columns: [
                {"label": "Ticket", "role": "ticket", "width": 120},
                {"label": "Device", "role": "device", "width": 230},
                {"label": "Status", "role": "status", "width": 180},
                {"label": "ETA", "role": "eta", "width": 100}
            ]
        }
    }
}
