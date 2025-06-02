# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./programs/audio/audio_and_cmus.nix
      ./programs/firefox/firefox.nix
      #./programs/greetd/greetd.nix
      ./programs/sddm/sddm.nix
    ];
    
################
### Programs ##
################

  # enabling hyprland
  programs.hyprland.enable = true;

############
##Services##
############

  # Stuff for mullvad VPN to function
  services.mullvad-vpn.enable = true;
  services.resolved.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.displayManager.sddm.enable = true; handled inside the sddm.nix file i believe. fingies crossed. 
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true; 

  # power management shit
  services.thermald.enable = true;
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.gnome.gnome-keyring.enable = true; # allows network manager to store wifi passwords
  programs.seahorse.enable = true; # GUI to manage secrets
  programs.ssh.askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass"; # forces hyprland to use seahorse not KDE's stuff

#########################
### File System Stuff ###
#########################
# Mounting the tibby ssd
  fileSystems."/mnt/tby" = {
    device = "UUID=6ad5996c-7fce-4da4-ac13-18a04aa80f53";
    fsType = "ext4";
    options = [ "defaults" ];
  };

# Swap device
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/2e378d8c-48ab-4c5d-93f6-ae7578b433b9";
    }
  ];

  # Specify resume device for hibernation
  boot.resumeDevice = "/dev/disk/by-uuid/2e378d8c-48ab-4c5d-93f6-ae7578b433b9";


  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  #probably required for steam i think it was
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
    "python2.7.18.6"
  ];

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


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.relz = {
    isNormalUser = true;
    description = "relz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #kdePackages.kate # dont need this, but kdePackages... is the qt6 version for 25.05
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.graphics = {
    enable = true;
  };


  location.latitude = 35.0122173;
  location.longitude = -85.1031394;
  location.provider = "manual";

  fonts.packages = with pkgs; [
    hack-font
    arkpandora_ttf
    corefonts
    fira-code-nerdfont
    font-awesome
  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # -- Applications --
    telegram-desktop
    vesktop
    signal-desktop
    thunderbird
    nicotine-plus #soulseek gui
    qbittorrent-enhanced
    steam
    anki
    bitwarden
    todoist-electron
    obs-studio
    prismlauncher # minecraft
    vscode
    zed-editor
    libsForQt5.okular # PDF viewer


    # -- Ricing --
    sddm-astronaut
    ironbar
    upower
    gammastep
    #zoxide # enables the `z` command in terminal (not setup)
    nitch #neofetch alt, necessary asf...fite me
    waybar #baaaarrrrrrr
    hyprpaper
    rofi-wayland #app launcher
    pywal


    # -- Dependencies --
    wineWowPackages.waylandFull
    libreoffice-qt6-fresh
    gamescope # for running games


    # -- Basics --
    neovim
    wget
    bash
    curl
    jq
    git
    gnugrep
    tree # nice file hierarchy visualizations
    parsify # calculator app
    kitty #terminal emulator
    mpvc #video player
    mpv # ''
    lxqt.lxqt-policykit
    

    # -- Utilities --
    networkmanager
    networkmanagerapplet #magical goodness tysm maintainer
    dunst #notification manager
    libnotify #dunst dependency
    btop #hardware monitor
    brightnessctl
    wl-clipboard # for capturing screenshots
    grim # ''
    slurp # ''
    powertop
    gparted
    yt-dlp # youtube video downloader
    mullvad
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };


  security.polkit.enable = true;

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
