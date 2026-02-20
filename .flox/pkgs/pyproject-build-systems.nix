{
  stdenv,
  lib,
}:
stdenv.mkDerivation {
  pname = "pyproject-build-systems";
  version = "0-unstable-2026-02-20";

  src = builtins.path {
    path = ../..;
    name = "pyproject-build-systems-source";
    filter = path: type:
      let
        rel = lib.removePrefix (toString ../..) path;
      in
      rel == "/default.nix"
      || rel == "/overlay.nix"
      || rel == "/build-systems.toml"
      || rel == "/pyproject.toml"
      || rel == "/uv.lock";
  };

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    mkdir -p $out/pyproject-build-systems
    cp default.nix $out/pyproject-build-systems/
    cp overlay.nix $out/pyproject-build-systems/
    cp build-systems.toml $out/pyproject-build-systems/
    cp pyproject.toml $out/pyproject-build-systems/
    cp uv.lock $out/pyproject-build-systems/
  '';

  meta = {
    description = "Nix build system packages for use with pyproject-nix and uv2nix";
    homepage = "https://github.com/pyproject-nix/build-system-pkgs";
    license = lib.licenses.mit;
  };
}
