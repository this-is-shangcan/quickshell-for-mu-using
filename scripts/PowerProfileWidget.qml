import QtQuick 6.0
import QtQuick.Controls 6.0

Button {
    id: root
    property string profile: "balanced"
    background: Rectangle { color: "#1E1E1E"; radius: 8; border.color: "#3C3C3C"; border.width: 1 }
    contentItem: Text {
        text: profile === "performance" ? "⚡" : (profile === "power-saver" ? "🐢" : "⚖️")
        color: "#FFFFFF"; font.pixelSize: 16; horizontalAlignment: Text.AlignHCenter
    }
    Timer { interval: 5000; running: true; repeat: true; onTriggered: updateProfile() }
    Component.onCompleted: updateProfile()

    function updateProfile() {
        var xhr = new XMLHttpRequest()
        xhr.open("GET", "http://localhost:8082/profile", true)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200)
                profile = xhr.responseText
        }
        xhr.send()
    }
    function cycleProfile() {
        var newProfile = profile === "balanced" ? "performance" : (profile === "performance" ? "power-saver" : "balanced")
        var xhr = new XMLHttpRequest()
        xhr.open("POST", "http://localhost:8082/profile", false)
        xhr.send(newProfile)
        profile = newProfile
    }
    onClicked: cycleProfile()
}
