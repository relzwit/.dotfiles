{ config, lib, pkgs, ... }:

{
  services.udev.extraRules = ''
    # Disable tap-drag for Synaptics TM3418-002
    ACTION=="add|change", SUBSYSTEM=="input", ATTRS{name}=="Synaptics TM3418-002", ENV{LIBINPUT_ATTR_TAP_DRAG_ENABLED}="0"
  '';
}
