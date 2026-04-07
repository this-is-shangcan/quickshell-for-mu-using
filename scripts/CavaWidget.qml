import QtQuick 6.0
import QtQuick.Controls 6.0

Button {
    id: root
    property variant bars: [0,0,0,0,0,0,0,0,0,0]
    background: Rectangle { color: "#1E1E1E"; radius: 8; border.color: "#3C3C3C"; border.width: 1 }
    contentItem: RowLayout {
        spacing: 2
        Repeater {
            model: 10
            Rectangle {
                width: 3; height: 4 + bars[index]*20; radius: 1; color: "#4CAF50"
                Layout.alignment: Qt.AlignBottom
            }
        }
    }
    Timer { interval: 50; running: true; repeat: true; onTriggered: updateBars() }
    function updateBars() {
        for (var i=0; i<bars.length; i++) bars[i] = Math.random()  // 实际应读取 /tmp/cava.fifo
    }
}
