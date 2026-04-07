import QtQuick 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 6.0

PopupWindow {
    id: root
    width: 360; height: 200
    background: Rectangle { color: "#1E1E1E"; radius: 16; border.color: "#3C3C3C"; border.width: 1 }
    contentItem: ColumnLayout {
        anchors.fill: parent; anchors.margins: 16; spacing: 12
        RowLayout {
            Text { text: "🎵 音频频谱"; color: "#FFFFFF"; font.pixelSize: 16; font.bold: true }
            Item { Layout.fillWidth: true }
            Button { text: "✕"; background: Rectangle { color: "transparent" }; onClicked: root.close() }
        }
        Rectangle {
            Layout.fillWidth: true; height: 120; color: "#2D2D2D"; radius: 8
            RowLayout {
                anchors.fill: parent; anchors.margins: 12; spacing: 6
                Repeater {
                    model: 20
                    Rectangle {
                        width: 6; height: 20 + Math.random()*80; radius: 3
                        color: Qt.rgba(76/255,175/255,80/255,0.7)
                        Layout.alignment: Qt.AlignBottom
                    }
                }
            }
        }
    }
}
