import QtQuick 6.0
import QtQuick.Controls 6.0

Button {
    id: root
    property int volume: 70
    property bool muted: false
    background: Rectangle { color: "#1E1E1E"; radius: 8; border.color: "#3C3C3C"; border.width: 1 }
    contentItem: RowLayout {
        spacing: 6
        Text { text: muted ? "🔇" : (volume>50 ? "🔊" : "🔉"); color: "#FFFFFF"; font.pixelSize: 14 }
        Text { text: muted ? "Muted" : volume+"%"; color: "#FFFFFF"; font.pixelSize: 13 }
    }
    Timer { interval: 1000; running: true; repeat: true; onTriggered: updateVolume() }
    Component.onCompleted: updateVolume()

    function updateVolume() {
        var xhr = new XMLHttpRequest()
        xhr.open("GET", "http://localhost:8081/volume", true)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                var data = JSON.parse(xhr.responseText)
                volume = data.volume; muted = data.muted
            }
        }
        xhr.send()
    }
    function setVolume(value) {
        var xhr = new XMLHttpRequest()
        xhr.open("POST", "http://localhost:8081/volume", false)
        xhr.send(JSON.stringify({volume: value}))
        volume = value
    }
    function toggleMute() {
        var xhr = new XMLHttpRequest()
        xhr.open("POST", "http://localhost:8081/mute", false)
        xhr.send()
        muted = !muted
    }
    onWheel: (wheel) => setVolume(Math.min(100, Math.max(0, volume + (wheel.angleDelta.y/120)*5)))
    onPressed: (mouse) => { if (mouse.button === Qt.RightButton) toggleMute() }
}
