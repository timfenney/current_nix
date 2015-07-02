# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config = {
    # necessary for proprietary nvidia driver for gtx 970 support
    allowUnfree = true;

    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
    };

  };
  

  
  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.kernelModules = [ "fbcon" ];
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidiafb"
  ];
  boot.kernelParams = [ "nomodeset" ];
  
  #hardware.opengl.driSupport32Bit = true;


  # networking.hostName = "nixos"; # Define your hostname.
  networking.hostId = "9e31619d";
  # networking.wireless.enable = true;  # Enables wireless.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
 i18n = {
   consoleFont = "lat9w-16";
   consoleKeyMap = "us";
   defaultLocale = "en_US.UTF-8";
 };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
     silver-searcher
     chromium
     git
     kde4.kdemultimedia
     kde4.kdegraphics
     kde4.kdeutils
     kde4.applications
     kde4.kdegames
     #kde4.kdeedu
     kde4.kdebindings
     kde4.kdeaccessibility
     kde4.kde_baseapps
     kde4.kactivities
     kde4.kdeadmin
     kde4.kdeartwork
     kde4.kde_base_artwork
     kde4.kdenetwork
     kde4.kdepim
     kde4.kdepimlibs
     kde4.kdeplasma_addons
     kde4.kdesdk
     kde4.kdetoys
     kde4.kde_wallpapers
     kde4.kdewebdev
     kde4.oxygen_icons
     kde4.kdebase_workspace
     kde4.kdelibs
     kde4.kdevelop
     kde4.kdevplatform
     vim
     wget
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = [ "nvidia" ];

    displayManager = {
      #auto = {
      #  enable = true;
      #  user = "hb";
      #};

      kdm.enable = true;
    };

    desktopManager.kde4.enable = true;
  };

  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.hb = {
    description = "me";
    group = "users";
    isNormalUser = true;
    uid = 1000;
    home = "/home/hb";
    createHome = true;
    useDefaultShell = true;
    password = "hb";
    extraGroups = [ "wheel" ];
  };

}
