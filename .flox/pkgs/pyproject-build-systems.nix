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
    mkdir -p $out
    cp default.nix $out/
    cp overlay.nix $out/
    cp build-systems.toml $out/
    cp pyproject.toml $out/
    cp uv.lock $out/
  '';

  meta = {
    description = "Nix build system packages for use with pyproject-nix and uv2nix";
    homepage = "https://github.com/pyproject-nix/build-system-pkgs";
    license = lib.licenses.mit;
  };
}
