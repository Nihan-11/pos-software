from __future__ import annotations

from typing import Any

from PyQt6.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot

from models import DictListModel


class BackendBridge(QObject):
    loginSucceeded = pyqtSignal(str)
    loginFailed = pyqtSignal(str)
    toast = pyqtSignal(str, str)
    errorOccurred = pyqtSignal(str)

    modelsChanged = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._database: Any = None
        self._user = ""
        self._initialize_database()

        self._dashboard_model = DictListModel(
            [
                {"title": "Daily Sales", "value": "$1,250", "trend": "+12%"},
                {"title": "Items Sold", "value": "89", "trend": "+4%"},
                {"title": "Repairs Open", "value": "6", "trend": "-1"},
                {"title": "Low Stock", "value": "4", "trend": "+2"},
            ]
        )
        self._sales_model = DictListModel(
            [
                {"id": "TX-1001", "item": "Phone Case", "qty": 2, "total": "$30"},
                {"id": "TX-1002", "item": "Screen Guard", "qty": 1, "total": "$12"},
            ]
        )
        self._inventory_model = DictListModel(
            [
                {"sku": "INV-101", "name": "Charging Cable", "stock": 42, "status": "In stock"},
                {"sku": "INV-203", "name": "Battery Pack", "stock": 5, "status": "Low stock"},
            ]
        )
        self._repairs_model = DictListModel(
            [
                {"ticket": "R-77", "device": "iPhone 13", "status": "In progress", "eta": "2d"},
                {"ticket": "R-78", "device": "Samsung A52", "status": "Waiting part", "eta": "4d"},
            ]
        )
        self._custom_orders_model = DictListModel(
            [{"orderNo": "CO-11", "customer": "Ayan", "status": "Pending", "amount": "$240"}]
        )
        self._cash_model = DictListModel(
            [{"time": "09:00", "action": "Opening balance", "amount": "$500"}]
        )
        self._alerts_model = DictListModel(
            [{"item": "Battery Pack", "remaining": 5, "severity": "Warning"}]
        )
        self._reports_model = DictListModel(
            [{"name": "Monthly Sales", "status": "Ready", "period": "May 2026"}]
        )
        self._settings_model = DictListModel(
            [
                {"key": "Currency", "value": "USD"},
                {"key": "Theme", "value": "Dark"},
                {"key": "Tax Rate", "value": "8%"},
            ]
        )

    def _initialize_database(self) -> None:
        try:
            import database  # type: ignore

            db_factory = getattr(database, "Database", None)
            self._database = db_factory() if callable(db_factory) else database
        except Exception:
            self._database = None

    @pyqtProperty(QObject, constant=True)
    def dashboardModel(self):  # noqa: N802
        return self._dashboard_model

    @pyqtProperty(QObject, constant=True)
    def salesModel(self):  # noqa: N802
        return self._sales_model

    @pyqtProperty(QObject, constant=True)
    def inventoryModel(self):  # noqa: N802
        return self._inventory_model

    @pyqtProperty(QObject, constant=True)
    def repairsModel(self):  # noqa: N802
        return self._repairs_model

    @pyqtProperty(QObject, constant=True)
    def customOrdersModel(self):  # noqa: N802
        return self._custom_orders_model

    @pyqtProperty(QObject, constant=True)
    def cashRegisterModel(self):  # noqa: N802
        return self._cash_model

    @pyqtProperty(QObject, constant=True)
    def stockAlertsModel(self):  # noqa: N802
        return self._alerts_model

    @pyqtProperty(QObject, constant=True)
    def reportsModel(self):  # noqa: N802
        return self._reports_model

    @pyqtProperty(QObject, constant=True)
    def settingsModel(self):  # noqa: N802
        return self._settings_model

    @pyqtSlot(str, str)
    def login(self, username: str, password: str) -> None:
        try:
            if self._database and hasattr(self._database, "authenticate"):
                ok = bool(self._database.authenticate(username, password))
            else:
                ok = bool(username and password)

            if ok:
                self._user = username
                self.loginSucceeded.emit(username)
                self.toast.emit("success", f"Welcome {username}")
            else:
                self.loginFailed.emit("Invalid username or password")
        except Exception as exc:
            self.errorOccurred.emit(f"Login failed: {exc}")

    @pyqtSlot(str)
    def addSale(self, item_name: str) -> None:  # noqa: N802
        if not item_name.strip():
            self.toast.emit("error", "Item name is required")
            return
        row = len(self._sales_model.to_list()) + 1001
        self._sales_model.append(
            {
                "id": f"TX-{row}",
                "item": item_name.strip(),
                "qty": 1,
                "total": "$0",
            }
        )
        self.toast.emit("info", f"Added {item_name}")

    @pyqtSlot(str, str)
    def updateSetting(self, key: str, value: str) -> None:  # noqa: N802
        try:
            updated = []
            found = False
            for row in self._settings_model.to_list():
                if row.get("key") == key:
                    row = {**row, "value": value}
                    found = True
                updated.append(row)
            if not found:
                updated.append({"key": key, "value": value})
            self._settings_model.set_items(updated)
            self.toast.emit("success", f"Updated {key}")
        except Exception as exc:
            self.errorOccurred.emit(f"Settings update failed: {exc}")

    @pyqtSlot()
    def refreshAll(self) -> None:  # noqa: N802
        self.toast.emit("info", "Data refreshed")
