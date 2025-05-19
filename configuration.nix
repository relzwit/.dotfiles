# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # enabling hyprland
  programs.hyprland.enable = true;

  stylix.enable = true;

  #stylix.image = /home/relz/Documents/wallpapers/catgirl.jpg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/3024.yaml";

#  physlock = {
#    allowAnyUser = true;
#    enable = true;
#  };

#  services.xserver.displayManager.sddm.enable = true;
#  programs.xss-lock.enable = true;
#  services.xautolock = {
#    enable = true;
#    locker = "${pkgs.slock}/bin.slock";
#  };

  
  swapDevices = [{
    device = "/swapfile";
    size = 33 * 1024; # 33GB
  }];


  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
    "python2.7.18.6"
  ];

  #hardware.pulseaudio.support32Bit = true;

  nixpkgs.config.allowUnfreePredicate = (pkg: builtins.elem (builtins.parseDrvName pkg.name).name [ "steam" ]);  
  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true; 

  # power management shit
  services.thermald.enable = true;
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;

#old---:
  # Enable sound with pipewire.
 # hardware.pulseaudio.enable = false;
 # security.rtkit.enable = true;
 # services.pipewire = {
 #   enable = true;
 #   alsa.enable = true;
 #   alsa.support32Bit = true;
 #   pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
 # };
#new---:
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };




  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.relz = {
    isNormalUser = true;
    description = "relz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kate
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.graphics = {
    enable = true;
  };

# not currently working setting lat/long manually below
#  location.provider = "geoclue2";

  location.latitude = 35.0122173;
  location.longitude = -85.1031394;
  location.provider = "manual";

  services.redshift = {
    enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # basics
    neovim
    wget
    git
    inputs.helix.packages."${pkgs.system}".helix

    # messaging stuffs
    telegram-desktop
    vesktop
    signal-desktop
    thunderbird

    #apps
    strawberry
    steam
    libreoffice-qt6-fresh
    anki
    bitwarden
    todoist-electron
    waydroid #for android apps
    mpvc #video player
    mpv
    obs-studio
    prismlauncher

    #programming
    vscode
    zed-editor


# utilities and ricing
    nitch #neofetch alt, necessary asf...fite me
    
    #waybar shit
    waybar #baaaarrrrrrr
    hyprpicker
    bluez
    #swaynotificationcenter

    swww #wallpapers
    dunst #notification manager
    libnotify #dunst dependency
    btop #hardware monitor
    rofi-wayland #app launcher
    gnome-disk-utility 
    kitty #terminal emulator
    font-awesome
    brightnessctl
    # for capturing screenshots
    wl-clipboard
    grim
    slurp
    powertop
#    physlock
    xautolock

    #polkit
    #libsForQt5.polkit-kde-agent
   # pkgs.polkit
   # pkgs.polkit_gnome
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };


  security.polkit.enable = true;

 # systemd = {
    #user.services.polkit-gnome-authentication-agent-1 = {
      #description = "polkit-gnome-authentication-agent-1";
     # wantedBy = [ "graphical-session.target" ];
    #  wants = [ "graphical-session.target" ];
   #   after = [ "graphical-session.target" ];
  #    serviceConfig = {
 #       Type = "simple";
#	ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
#	Restart = "on-failure";
#	RestartSec = 1;
#	TimeoutStopSec = 10;
    #  };
   # };
  #   extraConfig = ''
 #      DefaultTimeoutStopSec=10s
   #  '';
  #};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
