{ pkgs, ... }:

let
  linuxHeaders = pkgs.linuxHeaders;
in

pkgs.python3Packages.buildPythonPackage {
  pname = "evdev";
  version = "1.6.1";

  src = pkgs.fetchFromGitHub {
    owner = "gvalkov";
    repo = "python-evdev";
    rev = "v1.6.1";
    sha256 = "sha256-8Z2oseFnIqKGsHpWOQw03Dfj2VKCPN087ncsy0eZe+4=";
  };

  nativeBuildInputs = with pkgs; [
    python3Packages.setuptools
    python3Packages.wheel
  ];

patchPhase = ''
  substituteInPlace setup.py \
    --replace-fail "'/usr/include'" "'evdev-headers'"
'';


   preBuild = ''
    mkdir -p evdev-headers/linux
    cp ${linuxHeaders}/include/linux/input.h evdev-headers/linux/input.h
    cp ${linuxHeaders}/include/linux/input-event-codes.h evdev-headers/linux/input-event-codes.h
  '';


  buildPhase = ''
    python setup.py \
      build \
      build_ecodes --evdev-headers evdev-headers \
      build_ext --include-dirs evdev-headers
  '';

  doCheck = false;

  meta = with pkgs.lib; {
    description = "Python bindings for the Linux evdev interface";
    homepage = "https://github.com/gvalkov/python-evdev";
    license = licenses.bsd2;
  };
}

