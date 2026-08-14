import Quickshell
import Quickshell.Wayland
import QtQuick

import qs.config
import qs.services

import "./modules/bar/"

ShellRoot {
    id: root

    Bar {}
}
