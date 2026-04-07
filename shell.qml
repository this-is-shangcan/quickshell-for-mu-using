import QtQuick 6.0
import QtQuick.Layouts 1.0
import Quickshell 0.2
import Quickshell.Hyprland 1.0

ShellRoot {
    id: root
    layer: ShellLayer.Top
    anchors {
        top: true
        left: true
        right: true
    }
    width: parent?.width ?? Screen.width
    height: 48

    background: Rectangle { color: "#00000000" }  // 透明背景

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 12

        // 左侧：当前窗口
        ActiveWindowWidget { Layout.fillWidth: true; Layout.minimumWidth: 200 }

        // 右侧组件
        RowLayout {
            spacing: 16
            Layout.alignment: Qt.AlignRight

            CavaWidget { onClicked: dynamicIslandLoader.active = true }
            BrightnessWidget { }
            VolumeWidget { }
            PowerProfileWidget { }
            BatteryWidget { }
            TimeWidget { onClicked: calendarLoader.active = true }
        }
    }

    // 日历弹窗
    Loader {
        id: calendarLoader
        active: false
        sourceComponent: CalendarPopup { onCloseRequest: calendarLoader.active = false }
        onActiveChanged: if (active) item && (item.x = parent.width - item.width - 8, item.y = root.height + 4)
    }

    // 灵动岛（仅CAVA）
    Loader {
        id: dynamicIslandLoader
        active: false
        sourceComponent: DynamicIsland { onCloseRequest: dynamicIslandLoader.active = false }
        onActiveChanged: if (active) item && (item.x = parent.width - item.width - 8, item.y = root.height + 4)
    }
}
