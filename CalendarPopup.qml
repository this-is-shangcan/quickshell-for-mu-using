import QtQuick 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 6.0

PopupWindow {
    id: root
    width: 260; height: 280
    background: Rectangle { color: "#1E1E1E"; radius: 12; border.color: "#3C3C3C"; border.width: 1 }
    contentItem: ColumnLayout {
        anchors.fill: parent; anchors.margins: 16; spacing: 12
        RowLayout {
            Text { text: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"][new Date().getMonth()] + " " + new Date().getFullYear(); color: "#FFFFFF"; font.pixelSize: 16; font.bold: true }
            Item { Layout.fillWidth: true }
            Button { text: "✕"; background: Rectangle { color: "transparent" }; onClicked: root.close() }
        }
        RowLayout {
            Repeater { model: ["一","二","三","四","五","六","日"]; Text { text: modelData; color: index===6?"#FF6B6B":"#AAAAAA"; font.pixelSize: 12; Layout.fillWidth: true; horizontalAlignment: Text.AlignHCenter } }
        }
        GridLayout {
            columns: 7; rows: 6; columnSpacing: 8; rowSpacing: 8
            property var currentDate: new Date()
            property int firstDayOfMonth: new Date(currentDate.getFullYear(), currentDate.getMonth(), 1).getDay()
            property int daysInMonth: new Date(currentDate.getFullYear(), currentDate.getMonth()+1, 0).getDate()
            Repeater {
                model: 42
                Text {
                    property int dayNum: index+1 - (parent.firstDayOfMonth===0?7:parent.firstDayOfMonth)
                    text: dayNum>0 && dayNum<=parent.daysInMonth ? dayNum : ""
                    color: (dayNum===new Date().getDate() && new Date().getMonth()===parent.currentDate.getMonth()) ? "#4CAF50" : "#FFFFFF"
                    font.pixelSize: 12; horizontalAlignment: Text.AlignHCenter; Layout.fillWidth: true
                }
            }
        }
    }
}
