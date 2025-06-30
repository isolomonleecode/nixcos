{ stdenv, fetchFromGitHub, kernel, lib }:

stdenv.mkDerivation rec {
  pname = "hid-fanatecff";
  version = "unstable-2024-06-20";

  src = fetchFromGitHub {
    owner = "gotzl";
    repo = "hid-fanatecff";
    rev = "master";
    sha256 = "sha256-M2jm8pyxHRiswV4iJEawo57GkJ2XOclIo3NxEFgK+q0=";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  patchPhase = ''
    sed -i "s|KVERSION ?=.*|KVERSION ?= 6.15.2-zen1|" Makefile
    sed -i "s|KERNEL_SRC ?=.*|KERNEL_SRC ?= /nix/store/xicmayjf4b1slgl2633385s95a6x36m2-linux-zen-6.15.2-dev/lib/modules/6.15.2-zen1/build|" Makefile
    echo "==== PATCHED MAKEFILE ===="
    cat Makefile
  '';

  installPhase = ''
    mkdir -p $out/lib/modules/6.15.2-zen1/kernel/drivers/hid
    cp hid-fanatec.ko $out/lib/modules/6.15.2-zen1/kernel/drivers/hid/
'';

  meta = with lib; {
    description = "Fanatec HID kernel module";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
