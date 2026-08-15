pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import qs.services
import qs.config

Singleton {
    id: root

    // Helper function to shorten the service call
    function getState(path, fallback) {
        return StateService.get(path, fallback);
    }

    function setState(path, value) {
        StateService.set(path, value);
    }

    // ========================================================================
    // PROPERTIES
    // ========================================================================

    readonly property string themesDir: Quickshell.env("HOME") + "/.local/share/themes"


    property string currentThemeName: getState("theme.name", "catppuccin-mocha")
    property string themeMode: getState("theme.mode", "preset") // "preset" | "auto"
    property string colorScheme: getState("theme.scheme", "dark") // "dark" | "light"
    readonly property bool isAutoMode: themeMode === "auto"
    readonly property bool isDarkMode: colorScheme === "dark"
    readonly property string gtkThemeName: isDarkMode ? "adw-gtk3-dark" : "adw-gtk3"
    property var availableThemes: []

    // Themes filtered by current color scheme (dark shows dark, light shows light)
    readonly property var displayThemes: {
        var result = [];
        var themes = availableThemes;
        var previews = themePreviews;
        var scheme = colorScheme;
        for (var i = 0; i < themes.length; i++) {
            var name = themes[i];
            var preview = previews[name];
            var variant = (preview && preview.variant) ? preview.variant : "dark";
            if (variant === scheme)
                result.push(name);
        }
        // If no themes match (e.g. no light presets yet), show all
        if (result.length === 0)
            return themes;
        return result;
    }

    // Preview data: { "themeName": { name, palette: { background, accent, ... } } }
    property var themePreviews: ({})

    // The palette is the single source of truth for all colors
    // Config.qml reads from here
    property var palette: ({
            "background": "#1a1b26",
            "surface0": "#24283b",
            "surface1": "#292e42",
            "surface2": "#414868",
            "surface3": "#565f89",
            "text": "#c0caf5",
            "textReverse": "#1a1b26",
            "subtext": "#a9b1d6",
            "subtextReverse": "#565f89",
            "accent": "#7aa2f7",
            "success": "#9ece6a",
            "warning": "#e0af68",
            "error": "#f7768e",
            "muted": "#545c7e",
            "greyBlue": "#283457",
            "blueDark": "#16161e"
        })

    // Helper for Config.qml to read palette with fallback
    function color(key, fallback) {
        return palette[key] ?? fallback;
    }

    // ========================================================================
    // INITIALIZATION
    // ========================================================================

    Component.onCompleted: {
        listThemes();
    }

    // Load theme when state is ready
    Connections {
        target: StateService
        function onStateLoaded() {
            root.themeMode = root.getState("theme.mode", "preset");
            root.colorScheme = root.getState("theme.scheme", "dark");
            root.currentThemeName = root.getState("theme.name", "catppuccin-mocha");
            root.applyTheme(root.currentThemeName);
        }
    }

    // ========================================================================
    // PUBLIC API
    // ========================================================================

    function applyTheme(themeName) {
        console.log("[Theme] Loading theme:", themeName);
        loadThemeProc._themeName = themeName;
        loadThemeProc._buffer = "";
        loadThemeProc.command = ["cat", themesDir + "/" + themeName + ".json"];
        loadThemeProc.running = true;
    }

    function setPresetMode(themeName) {
        console.log("[Theme] Switching to preset mode:", themeName);
        themeMode = "preset";
        setState("theme.mode", "preset");
        applyTheme(themeName);
    }

    function setColorScheme(scheme: string) {
        console.log("[Theme] Switching color scheme to:", scheme);
        colorScheme = scheme;
        setState("theme.scheme", scheme);

       // Load current theme JSON to find the pair for the new scheme
       _schemeSwitchProc._targetScheme = scheme;
       _schemeSwitchProc._buffer = "";
       _schemeSwitchProc.command = ["cat", themesDir + "/" + currentThemeName + ".json"];
       _schemeSwitchProc.running = true;
    }

    function listThemes() {
        listThemesProc._collected = [];
        listThemesProc.running = true;
    }

    function loadPreviews() {
        previewProc._buffer = "";
        previewProc.running = true;
    }

    // ========================================================================
    // INTERNAL
    // ========================================================================

    function _applyThemeData(themeName, data) {
        // 1. Update palette (triggers Config.qml rebinding)
        if (data.palette) {
            root.palette = data.palette;
        }

        // 2. Update opacity in StateService (user preference, not theme-owned)
        if (data.opacity && data.opacity.background !== undefined) {
            setState("opacity.background", data.opacity.background);
        }

        // 3. Save theme name
        currentThemeName = themeName;
        setState("theme.name", themeName);

        // 4. Apply to Hyprland
        _applyHyprland(data.hyprland);

        console.log("[Theme] Theme applied:", data.name || themeName);
    }

    function _applyHyprland(hyprColors) {
        if (!hyprColors)
            return;

        const cmds = [];
        if (hyprColors.activeBorder)
            cmds.push("hyprctl eval 'hl.config({ general = { col = { active_border = \"rgba(" + hyprColors.activeBorder + ")\" } } })'");
        if (hyprColors.inactiveBorder)
            cmds.push("hyprctl eval 'hl.config({ general = { col = { inactive_border = \"rgba(" + hyprColors.inactiveBorder + ")\" } } })'");
        if (hyprColors.shadowColor)
            cmds.push("hyprctl eval 'hl.config({ decoration = { shadow = { color = \"rgba(" + hyprColors.shadowColor + ")\" } } })'");

        if (cmds.length > 0) {
            hyprProc.command = ["bash", "-c", cmds.join(" && ")];
            hyprProc.running = true;
        }
    }

    // ========================================================================
    // PROCESSES
    // ========================================================================

    Process {
        id: loadThemeProc
        property string _themeName: ""
        property string _buffer: ""

        stdout: SplitParser {
            onRead: data => loadThemeProc._buffer += data + "\n"
        }

        stderr: SplitParser {
            onRead: data => console.error("[Theme] " + data)
        }

        onExited: exitCode => {
            if (exitCode === 0) {
                try {
                    const data = JSON.parse(_buffer.trim());
                    root._applyThemeData(_themeName, data);
                } catch (e) {
                    console.error("[Theme] Failed to parse theme:", e);
                }
            } else {
                console.error("[Theme] Theme file not found:", _themeName);
            }
            _buffer = "";
        }
    }

    // Reads the current theme JSON to find its light/dark pair
    Process {
        id: _schemeSwitchProc
        property string _targetScheme: ""
        property string _buffer: ""

        stdout: SplitParser {
            onRead: data => _schemeSwitchProc._buffer += data + "\n"
        }

        stderr: SplitParser {
            onRead: data => console.error("[Theme:SchemeSwitch] " + data)
        }

        onExited: exitCode => {
            if (exitCode === 0) {
                try {
                    const data = JSON.parse(_buffer.trim());
                    var pairName = "";
                    if (_targetScheme === "light" && data.lightPair)
                        pairName = data.lightPair;
                    else if (_targetScheme === "dark" && data.darkPair)
                        pairName = data.darkPair;

                    if (pairName) {
                        console.log("[Theme] Switching to pair theme:", pairName);
                        root.applyTheme(pairName);
                    } else {
                        // No pair found — re-apply current theme (fallback)
                        console.log("[Theme] No pair for scheme, re-applying current theme");
                        root.applyTheme(root.currentThemeName);
                    }
                } catch (e) {
                    console.error("[Theme] Failed to read pair:", e);
                    root.applyTheme(root.currentThemeName);
                }
            } else {
                root.applyTheme(root.currentThemeName);
            }
            _buffer = "";
        }
    }

    Process {
        id: listThemesProc
        command: ["bash", "-c", "ls -1 '" + root.themesDir + "'/*.json 2>/dev/null | sed 's|.*/||;s|\\.json$||' | sort"]
        property var _collected: []

        stdout: SplitParser {
            onRead: data => {
                const name = data.trim();
                if (name)
                    listThemesProc._collected.push(name);
            }
        }

        onExited: {
            root.availableThemes = listThemesProc._collected;
            console.log("[Theme] Available themes:", root.availableThemes.join(", "));
            root.loadPreviews();
        }
    }

    // Load all theme JSONs to extract preview palettes
    Process {
        id: previewProc
        command: ["bash", "-c", "for f in '" + root.themesDir + "'/*.json; do echo \"---THEME_NAME:$(basename \"$f\" .json)---\"; cat \"$f\"; echo '---THEME_SEP---'; done"]
        property string _buffer: ""

        stdout: SplitParser {
            onRead: data => previewProc._buffer += data + "\n"
        }

        onExited: exitCode => {
            if (exitCode !== 0)
                return;

            const chunks = _buffer.split("---THEME_SEP---");
            var previews = {};

            for (var i = 0; i < chunks.length; i++) {
                var chunk = chunks[i].trim();
                if (!chunk)
                    continue;

                // Extract theme name from the header line
                var nameMatch = chunk.indexOf("---THEME_NAME:");
                if (nameMatch === -1)
                    continue;
                var nameEnd = chunk.indexOf("---", nameMatch + 14);
                if (nameEnd === -1)
                    continue;
                var themeName = chunk.substring(nameMatch + 14, nameEnd).trim();
                var jsonStr = chunk.substring(nameEnd + 3).trim();

                try {
                    var data = JSON.parse(jsonStr);
                    previews[themeName] = {
                        name: data.name || themeName,
                        palette: data.palette || {},
                        wallpaper: data.wallpaper || "",
                        variant: data.variant || "dark",
                        lightPair: data.lightPair || "",
                        darkPair: data.darkPair || ""
                    };
                } catch (e) {
                    console.error("[Theme] Preview parse error for " + themeName + ":", e);
                }
            }

            root.themePreviews = previews;
            console.log("[Theme] Loaded previews for", Object.keys(previews).length, "themes");
            _buffer = "";
        }
    }

    Process {
        id: hyprProc
        stderr: SplitParser {
            onRead: data => console.error("[Theme:Hyprland] " + data)
        }
    }
}