import Quickshell
import Quickshell.Wayland
import QtQuick

import qs.config
import qs.services

import "./modules/bar/"

ShellRoot {
    id: root

    property bool _idleReady: IdleService.caffeineEnabled

    IdleMonitor {
        timeout: IdleService.lockTimeout
        enabled: !IdleService.caffeineEnabled && !IdleService.mediaPlaying && !IdleService.systemInhibited && !StateService.isLoading
        respectInhibitors: true

        onIsIdleChanged: {
            if (isIdle) {
                console.log("[Idle] Lock timeout reached");
                IdleService.lock();
            }
        }
    }

    IdleMonitor {
        timeout: IdleService.dpmsTimeout
        enabled: !IdleService.caffeineEnabled && !IdleService.mediaPlaying && !IdleService.systemInhibited && IdleService.dpmsEnabled && !StateService.isLoading
        respectInhibitors: true

        onIsIdleChanged: {
            if (isIdle) {
                console.log("[Idle] DPMS timeout, displays off");
                IdleService.dpmsOff();
            } else {
                console.log("[Idle] User returned, displays on");
                IdleService.dpmsOn();
            }
        }
    }

    Bar {}

    Loader {
        id: notificationLoader
        active: NotificationService.activePopupCount > 0 || NotificationService.popups.length > 0
        source: "./modules/notifications/NotificationOverlay.qml"

        onStatusChanged: {
            if (status === Loader.Ready)
                console.log("[Shell] NotificationOverlay loaded");
        }
    }

    // Lock Screen
    Loader {
        id: lockLoader
        active: LockService.locked
        source: "./modules/lock/LockScreen.qml"

        onStatusChanged: {
            if (status === Loader.Ready)
                console.log("[Shell] LockScreen loaded");
        }
    }

    // Power Overlay
    Loader {
        id: powerLoader
        active: PowerService.overlayVisible
        source: "./modules/power/PowerOverlay.qml"

        onStatusChanged: {
            if (status === Loader.Ready)
                console.log("[Shell] PowerOverlay loaded");
        }
    }

    Loader {
        active: OsdService.visible
        source: "./modules/osd/OsdOverlay.qml"
    }
}
