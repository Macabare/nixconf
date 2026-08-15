{ config, pkgs, ... }:

{
  programs.vscodium = {
    enable = true;

    profiles.default = {
      
      extensions = with pkgs.vscode-extensions; [
        esbenp.prettier-vscode
        golang.go

        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
      ];

      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-frappe";
        
        "breadcrumbs.icons" = false;
        "breadcrumbs.showArrays" = false;
        "breadcrumbs.showBooleans" = false;
        "breadcrumbs.showClasses" = false;
        "breadcrumbs.showConstants" = false;
        "breadcrumbs.showConstructors" = false;
        "breadcrumbs.showEnumMembers" = false;
        "breadcrumbs.showEvents" = false;
        "breadcrumbs.showFields" = false;
        "breadcrumbs.showFiles" = false;
        "breadcrumbs.showFunctions" = false;
        "breadcrumbs.showKeys" = false;
        "breadcrumbs.showMethods" = false;
        "breadcrumbs.showNamespaces" = false;
        "breadcrumbs.symbolPath" = "off";

        "chat.agent.enabled" = false;

        "editor.accessibilitySupport" = "off";
        "editor.bracketPairColorization.enabled" = false;
        "editor.cursorBlinking" = "solid";
        "editor.cursorSmoothCaretAnimation" = "explicit";
        "editor.cursorStyle" = "line-thin";
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.detectIndentation" = true;
        "editor.folding" = true;
        "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.glyphMargin" = false;
        "editor.gotoLocation.multipleDefinitions" = "goto";
        "editor.guides.indentation" = false;
        "editor.inlineSuggest.enabled" = true;
        "editor.linkedEditing" = true;
        "editor.minimap.enabled" = false;
        "editor.renderControlCharacters" = false;
        "editor.scrollBeyondLastLine" = true;
        "editor.scrollbar.horizontal" = "hidden";
        "editor.scrollbar.vertical" = "hidden";
        "editor.smoothScrolling" = true;
        "editor.stickyScroll.enabled" = false;
        "editor.stickyScroll.scrollWithEditor" = false;
        "editor.tabSize" = 2;

        "editor.tokenColorCustomizations" = {
          textMateRules = [
            {
              scope = [
                "comment"
                "constant"
                "entity.name.class"
                "keyword"
                "storage.modifier"
              ];
              settings = {
                fontStyle = "italic";
              };
            }
            {
              scope = [
                "constant.numeric"
                "invalid"
                "keyword.operator"
                "keyword.other.unit.px.css"
              ];
              settings = {
                fontStyle = "";
              };
            }
          ];
        };

        "explorer.compactFolders" = false;
        "explorer.confirmDelete" = false;

        "html.autoClosingTags" = true;
        "html.completion.attributeDefaultValue" = "singlequotes";

        "javascript.autoClosingTags" = true;
        "javascript.format.semicolons" = "insert";
        "javascript.preferences.quoteStyle" = "single";
        "javascript.updateImportsOnFileMove.enabled" = "always";

        "prettier.arrowParens" = "avoid";
        "prettier.enable" = true;
        "prettier.semi" = false;
        "prettier.singleQuote" = true;

        "security.workspace.trust.untrustedFiles" = "open";

        "typescript.autoClosingTags" = true;
        "typescript.format.semicolons" = "insert";
        "typescript.preferences.quoteStyle" = "single";
        "typescript.updateImportsOnFileMove.enabled" = "always";

        "window.commandCenter" = false;
        "window.confirmBeforeClose" = "keyboardOnly";
        "window.density.editorTabHeight" = "compact";
        "window.openFilesInNewWindow" = "off";

        "workbench.activityBar.location" = "hidden";
        "workbench.editor.tabSizing" = "shrink";
        "workbench.editor.showTabs" = "none";
        "workbench.layoutControl.enabled" = false;
        "workbench.startupEditor" = "none";
        "workbench.statusBar.visible" = false;
        "workbench.tree.enableStickyScroll" = false;
        "workbench.tree.expandMode" = "singleClick";
        "workbench.tree.renderIndentGuides" = "none";

        "npm.packageManager" = "bun";

        "[go]" = {
          "editor.defaultFormatter" = "golang.go";
        };
        
        "[qml]" = {
          "editor.defaultFormatter" = "theqtcompany.qt-qml";
        };

        "qt-qml.qmlls.customExePath" = "${pkgs.qt6.qtdeclarative}/bin/qmlls";
        
      };
    };
  };
}