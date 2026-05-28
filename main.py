from __future__ import annotations

import os
import sys

from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine

from backend import BackendBridge


def main() -> int:
    app = QGuiApplication(sys.argv)
    app.setApplicationName("POS Software")

    engine = QQmlApplicationEngine()
    backend = BackendBridge()
    engine.rootContext().setContextProperty("backend", backend)

    qml_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), "qml", "main.qml")
    engine.load(qml_file)

    if not engine.rootObjects():
        return 1
    return app.exec()


if __name__ == "__main__":
    raise SystemExit(main())
