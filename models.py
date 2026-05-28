from __future__ import annotations

from typing import Any, Iterable

from PyQt6.QtCore import QAbstractListModel, QModelIndex, Qt


class DictListModel(QAbstractListModel):
    """A generic QML-friendly list model backed by dictionaries."""

    def __init__(self, items: Iterable[dict[str, Any]] | None = None, parent=None):
        super().__init__(parent)
        self._items: list[dict[str, Any]] = list(items or [])
        self._roles: dict[int, bytes] = {}
        self._rebuild_roles()

    def _rebuild_roles(self) -> None:
        keys: set[str] = set()
        for item in self._items:
            keys.update(item.keys())
        self._roles = {
            Qt.ItemDataRole.UserRole + i + 1: key.encode("utf-8")
            for i, key in enumerate(sorted(keys))
        }

    def rowCount(self, parent=QModelIndex()) -> int:  # noqa: N802
        if parent.isValid():
            return 0
        return len(self._items)

    def data(self, index: QModelIndex, role: int = Qt.ItemDataRole.DisplayRole) -> Any:
        if not index.isValid():
            return None
        row = index.row()
        if row < 0 or row >= len(self._items):
            return None

        key = self._roles.get(role)
        if key is None:
            return None
        return self._items[row].get(key.decode("utf-8"))

    def roleNames(self) -> dict[int, bytes]:  # noqa: N802
        return self._roles

    def set_items(self, items: Iterable[dict[str, Any]]) -> None:
        self.beginResetModel()
        self._items = list(items)
        self._rebuild_roles()
        self.endResetModel()

    def append(self, item: dict[str, Any]) -> None:
        row = len(self._items)
        self.beginInsertRows(QModelIndex(), row, row)
        self._items.append(item)
        self.endInsertRows()
        self._rebuild_roles()

    def to_list(self) -> list[dict[str, Any]]:
        return list(self._items)
