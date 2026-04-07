import QtQuick 6.0
import QtQuick.Controls 6.0

Button {
    id: root
    property int brightness: 50
    background: Rectangle { color: "#1E1E1E"; radius: 8; border.color: "#3C3C3C"; border.width: 1 }
    contentItem: RowLayout {
        spacing: 6
        Text { text: "☀"; color: "#FFFFFF"; font.pixelSize: 14 }   // 纯色太阳符号
        Text { text: brightness + "%"; color: "#FFFFFF"; font.pixelSize: 13 }
    }
    Timer { interval: 5000; running: true; repeat: true; onTriggered: updateBrightness() }
    Component.onCompleted: updateBrightness()

    function updateBrightness() {
        var xhr = new XMLHttpRequest()
        xhr.open("GET", "http://localhost:8080/brightness", true)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200)
                brightness = parseInt(xhr.responseText)
        }
        xhr.send()
    }
    function setBrightness(value) {
        var xhr = new XMLHttpRequest()
        xhr.open("POST", "http://localhost:8080/brightness", false)
        xhr.send(value.toString())
        brightness = value
    }
    onWheel: (wheel) => {
        var delta = wheel.angleDelta.y / 120
        setBrightness(Math.min(100, Math.max(0, brightness + delta*5)))
    }
}
