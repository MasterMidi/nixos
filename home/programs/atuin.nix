{...}: {
  # https://github.com/atuinsh/atuin/issues/1003
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
  };
}
