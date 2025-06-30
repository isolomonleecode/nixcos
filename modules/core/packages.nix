{pkgs, ...}: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = false; # Firefox is not installed by default
    dconf.enable = true;
    seahorse.enable = true;
    hyprland.enable = true; #create desktop file and depedencies if you switch to GUI login MGR
    hyprlock.enable = true; #resolve pam issue https://gitlab.com/Zaney/zaneyos/-/issues/164
    fuse.userAllowOther = true;
    mtr.enable = true;
    adb.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    amfora # Fancy Terminal Browser For Gemini Protocol
    appimage-run # Needed For AppImage Support
    bottom # btop like util
    brave # Brave Browser
    brightnessctl # For Screen Brightness Control
    cmatrix # Matrix Movie Effect In Terminal
    cowsay # Great Fun Terminal Program
    docker-compose # Allows Controlling Docker From A Single File
    duf # Utility For Viewing Disk Usage In Terminal
    dysk # disk usage util
    eza # Beautiful ls Replacement
    ffmpeg # Terminal Video / Audio Editing
    file-roller # Archive Manager
    gdu # graphical disk usage
    gedit # Simple Graphical Text Editor
    gimp # Great Photo Editor
    glxinfo # Needed for inxi -G GPU info
    gping #graphical ping
    greetd.tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
    htop # Simple Terminal Based System Monitor
    hyprpicker # Color Picker
    eog # For Image Viewing
    inxi # CLI System Information Tool
    killall # For Killing All Instances Of Programs
    libnotify # For Notifications
    lm_sensors # Used For Getting Hardware Temps
    lolcat # Add Colors To Your Terminal Command Output
    lshw # Detailed Hardware Information
    mpv # Incredible Video Player
    ncdu # Disk Usage Analyzer With Ncurses Interface
    nixfmt-rfc-style # Nix Formatter
    onefetch #shows current build info and stats
    pavucontrol # For Editing Audio Levels & Devices
    pciutils # Collection Of Tools For Inspecting PCI Devices
    picard # For Changing Music Metadata & Getting Cover Art
    pkg-config # Wrapper Script For Allowing Packages To Get Info On Others
    playerctl # Allows Changing Media Volume Through Scripts
    rhythmbox
    ripgrep # Improved Grep
    socat # Needed For Screenshots
    sox # audio support for FFMPEG
    unrar # Tool For Handling .rar Files
    unzip # Tool For Handling .zip Files
    usbutils # Good Tools For USB Devices
    v4l-utils # Used For Things Like OBS Virtual Camera
    waypaper # backup wallpaper GUI
    wget # Tool For Fetching Files With Links
    ytmdl # Tool For Downloading Audio From YouTube
    lutris
    heroic
    chromium
    qemu
    bitwarden
    czkawka
    vlc
    bottles
    joplin-desktop
    chiaki
    alvr
    vscode
    qemu
    virt-manager
    retroarch-full
    xemu
    flatpak
    steam-run
    protontricks
    protonup-qt
    protonup-ng
    gnumake42
    linuxConsoleTools
    coreutils
    fractal
    gnome-keyring
    rustc
    rustup
    gcc
    pkg-config
    glib
    gtk3
    gobject-introspection
    cairo
    pango
    atk
    gdk-pixbuf
    android-tools
    iptables
    nftables
    winetricks
    wineWowPackages.stable
    softmaker-office

    (pkgs.stdenv.mkDerivation {
      pname = "redream";
      version = "1.5.0";
      src = pkgs.fetchurl {
        url = "https://redream.io/download/redream-x86_64-linux.tar.gz";
        sha256 = "4cM1WK7GzoYQ79Jbc34BAqC+OQGNJSkF+m+QH5W1eZQ=";
      };
      nativeBuildInputs = [ pkgs.autoPatchelfHook pkgs.glibc pkgs.zlib ];
      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/redream
        chmod +x $out/bin/redream
      '';
      meta = with pkgs.lib; {
        description = "Dreamcast emulator";
        homepage = "https://redream.io/";
        license = licenses.unfree;
        platforms = platforms.linux;
      };
    })
  ];
}
