import QtQuick
import "components"

PageShell {
    title: "Cash Register"
    content: Component {
        DataTable {
            tableModel: backend.cashRegisterModel
            columns: [
                {"label": "Time", "role": "time", "width": 120},
                {"label": "Action", "role": "action", "width": 280},
                {"label": "Amount", "role": "amount", "width": 120}
            ]
        }
    }
}
