{ config, pkgs, ... }:

let
  user = "relz";  # change if needed
in {
  # Install cmus and audio helper packages
  environment.systemPackages = with pkgs; [
    cmus
    pipewire
    pipewire-pulse
    pipewire-alsa
    wireplumber
    alsaUtils
  ];

  # Disable standalone PulseAudio
  hardware.pulseaudio.enable = false;

  # Enable realtimeKit for real-time scheduling support
  security.rtkit.enable = true;

  # Enable and configure PipeWire with PulseAudio, ALSA, and JACK support
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
    alsa.support32Bit = true;
  };

  # Enable WirePlumber session manager for PipeWire
  services.wireplumber.enable = true;

  # Add user to audio and wheel groups
  users.users.${user}.extraGroups = [ "audio" "wheel" ];

  # Deploy a default minimal cmus config for your user on activation
  system.activationScripts.cmusConfig = {
    text = ''
      mkdir -p /home/${user}/.config/cmus
      cat > /home/${user}/.config/cmus/config <<EOF
# cmus basic config
set look_syntax = true
set confirm_exit = false
set seek_step = 10
set replaygain = no
set volume_step = 5
EOF
      chown -R ${user}:${user} /home/${user}/.config/cmus
    '';
    deps = [ pkgs.cmus ];
  };

  # Disable mpd service if enabled to avoid conflicts
  systemd.services.mpd.enable = false;
}

