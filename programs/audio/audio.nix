{ config, pkgs, ... }:

{
  options = {};

  config = {
    # Enable real-time kit for pipewire
    security.rtkit.enable = true;

    # PipeWire setup
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # MPD system service
    services.mpd = {
      enable = true;
      user = "relz";
      musicDirectory = "/home/relz/Music";
      dataDir = "/home/relz/.config/mpd";
      network.listenAddress = "127.0.0.1";
      extraConfig = ''
        audio_output {
          type            "pulse"
          name            "PipeWire PulseAudio"
        }
        mixer_type            "software"
        bind_to_address        "127.0.0.1"
      '';
    };
  };
}

