# pos-software

PyQt6 + QML desktop POS shell with animated pages, reusable components, and a Python backend bridge.

## Run

```bash
python main.py
```

## Structure

- `/main.py` - PyQt6 entry point
- `/backend.py` - Python/QML bridge and app actions
- `/models.py` - generic QAbstractListModel implementation for QML
- `/animations.py` - reusable animation timing configuration
- `/qml/` - QML UI pages, components, and theme singleton
