import QtQuick 6.0
import QtQuick.Controls 6.0

Button {
    id: root
    background: Rectangle { color: "#1E1E1E"; radius: 8; border.color: "#3C3C3C"; border.width: 1 }
    contentItem: Column {
        spacing: 2
        Text { text: new Date().toLocaleTimeString(Qt.locale(), "hh:mm"); color: "#FFFFFF"; font.pixelSize: 14; font.bold: true }
        Text { text: new Date().toLocaleDateString(Qt.locale(), "MM/dd"); color: "#AAAAAA"; font.pixelSize: 10 }
    }
    Timer { interval: 60000; running: true; repeat: true; onTriggered: contentItem.children[0].text = new Date().toLocaleTimeString(Qt.locale(), "hh:mm") }
    onClicked: root.onClicked?.()
}
