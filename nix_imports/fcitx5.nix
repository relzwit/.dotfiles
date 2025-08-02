{ config, pkgs, ... }:

let
  # Explicitly include librime
  rimeLib = pkgs.librime;
in {
  environment.systemPackages = with pkgs; [
    fcitx5
    fcitx5-gtk
    fcitx5-configtool
    libsForQt5.fcitx5-qt
    fcitx5-rime
    catppuccin-fcitx5
  ];

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [
      pkgs.fcitx5-rime
      rimeLib  # 👈 This ensures librime.so is available to Fcitx5
    ];
  };
}
