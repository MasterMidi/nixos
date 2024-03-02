{
  pkgs,
  inputs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    userSettings = {
      "cargo.automaticCheck" = false;
      "files.autoSave" = "afterDelay";
      "editor.wordWrap" = "on";
      "editor.fontFamily" = "'MesloLGS Nerd Font'";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "editor.fontWeight" = "normal";
      "editor.formatOnSave" = true;
      "editor.stickyScroll.enabled" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs" = "active";
      "terminal.integrated.fontFamily" = "'MesloLGS Nerd Font'";
      "terminal.integrated.fontSize" = 14;
      "terminal.external.linuxExec" = "kitty";
      "terminal.integrated.gpuAcceleration" = "auto";
      "terminal.integrated.shellIntegration.enabled" = true;
      "terminal.integrated.ignoreProcessNames" = [
        "starship"
        "bash"
      ];
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;
      "window.autoDetectColorScheme" = true;
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "One Dark Pro Mix";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.preferredDarkColorTheme" = "One Dark Pro Mix";
      "workbench.preferredHighContrastColorTheme" = "Default High Contrast Light";
      "workbench.settings.editor" = "json";
      "workbench.tree.indent" = 20;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        nixd = {
          formatting = {
            command = "nixpkgs-fmt";
          };
          options = {
            # Disable it if you are not writting modules.
            enable = true;
            target = {
              args = [];
              # Example of NixOS options.
              installable = "<flakeref>#nixosConfigurations.<name>.options";
            };
          };
        };
        nil = {
          formatting = {
            command = ["nixpkgs-fmt"];
          };
        };
      };
      "css.validate" = false;
      "less.validate" = false;
      "scss.validate" = false;
      "[css]" = {
        "editor.defaultFormatter" = "stylelint.vscode-stylelint";
      };
      "files.associations" = {
        "*.rasi" = "css";
      };
    };
    keybindings = [
      {
        command = "workbench.action.terminal.new";
        key = "ctrl+shift+[Semicolon]";
      }
    ];
    extensions = with pkgs.vscode-extensions.extensions.x86_64-linux.vscode-marketplace;
      [
        kamadorueda.alejandra
        mads-hartmann.bash-ide-vscode
        mkhl.shfmt
        timonwong.shellcheck
        jeff-hykin.better-shellscript-syntax
        jeff-hykin.better-nix-syntax
        jeff-hykin.better-jsonc-syntax
        jeff-hykin.better-dockerfile-syntax
        aaron-bond.better-comments
        stylelint.vscode-stylelint
        naumovs.color-highlight
        mcu-debug.debug-tracker-vscode
        ms-vscode-remote.remote-containers
        mkhl.direnv
        ms-azuretools.vscode-docker
        p1c2u.docker-compose
        mikestead.dotenv
        editorconfig.editorconfig
        usernamehw.errorlens
        github.copilot
        bierner.markdown-preview-github-styles
        bierner.markdown-mermaid
        github.remotehub
        eamodio.gitlens
        kisstkondoros.vscode-gutter-preview
        visualstudioexptteam.vscodeintellicode
        visualstudioexptteam.intellicode-api-usage-examples
        yzhang.markdown-all-in-one
        davidanson.vscode-markdownlint
        pkief.material-icon-theme
        arrterian.nix-env-selector
        jnoortheen.nix-ide
        carlocardella.vscode-filesystemtoolbox
        zhuangtongfa.material-theme
        # ms-vscode-remote.remote-ssh
        # ms-vscode-remote.remote-ssh-edit
        # ms-vscode.remote-server
        semanticdiff.semanticdiff
        sidp.strict-whitespace
        albert.tabout
        actboy168.tasks
        ms-vscode.test-adapter-converter
        hbenl.vscode-test-explorer
        gruntfuggly.todo-tree
        panicbit.cargo
        vadimcn.vscode-lldb
        webfreak.debug
        serayuzgur.crates
        tamasfe.even-better-toml
        github.vscode-github-actions
        github.copilot-chat
        github.vscode-pull-request-github
        mcu-debug.memory-view
        dustypomerleau.rust-syntax
        swellaby.vscode-rust-test-adapter
        rust-lang.rust-analyzer
        belfz.search-crates-io
        mtxr.sqltools
        # vscodevim.vim
      ]
      ++ (with pkgs.vscode-extensions.extensions.x86_64-linux.open-vsx; [
        jeanp413.open-remote-ssh
      ]);
  };

  home.packages = with pkgs; [
    # Language tools
    ## Nix tools
    nil
    nixd
    nixpkgs-fmt
    alejandra

    ## Shell tools
    shellcheck
    shfmt
    nodePackages.bash-language-server
  ];
}
