import QtQuick 6.0
import Quickshell.Hyprland 1.0

Rectangle {
    id: root
    color: "#1E1E1E"; radius: 8; border.color: "#3C3C3C"; border.width: 1
    Text {
        anchors.fill: parent; anchors.margins: 8
        text: "Desktop"
        color: "#FFFFFF"; font.pixelSize: 13; elide: Text.ElideRight; verticalAlignment: Text.AlignVCenter
    }
    Connections {
        target: Hyprland
        function onActiveToplevelChanged() {
            root.children[0].text = Hyprland.activeToplevel ? (Hyprland.activeToplevel.title || Hyprland.activeToplevel.class || "Desktop") : "Desktop"
        }
    }
    Component.onCompleted: {
        if (Hyprland.activeToplevel)
            root.children[0].text = Hyprland.activeToplevel.title || Hyprland.activeToplevel.class || "Desktop"
    }
}
