import QtQuick 6.0
import QtQuick.Controls 6.0
import Quickshell.Services.UPower 1.0

Button {
    id: root
    property int percentage: 0
    property bool isCharging: false
    background: Rectangle { color: "#1E1E1E"; radius: 8; border.color: "#3C3C3C"; border.width: 1 }
    contentItem: RowLayout {
        spacing: 6
        Text { text: isCharging ? "⚡" : (percentage<15 ? "🪫" : "🔋"); color: "#FFFFFF"; font.pixelSize: 14 }  // 保留简单符号
        Text { text: percentage + "%"; color: percentage<15 ? "#FF6B6B" : "#FFFFFF"; font.pixelSize: 13 }
    }
    UPowerBattery {
        id: battery
        onPercentageChanged: root.percentage = Math.round(percentage)
        onStateChanged: root.isCharging = (state === UPowerBattery.Charging)
    }
    Component.onCompleted: { percentage = Math.round(battery.percentage); isCharging = battery.state === UPowerBattery.Charging }
}
