pragma Singleton
import QtQuick

QtObject {
    readonly property color bg: "#0f172a"
    readonly property color panel: "#111827"
    readonly property color panelAlt: "#1f2937"
    readonly property color text: "#f8fafc"
    readonly property color mutedText: "#94a3b8"
    readonly property color accent: "#22d3ee"
    readonly property color accentPress: "#06b6d4"
    readonly property color success: "#10b981"
    readonly property color warning: "#f59e0b"
    readonly property color danger: "#ef4444"

    readonly property int quick: 120
    readonly property int normal: 240
    readonly property int smooth: 360
    readonly property int dramatic: 540
}
