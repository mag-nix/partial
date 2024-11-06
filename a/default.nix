{ stdenv }:

stdenv.mkDerivation {
  name = "data-a";
  src = ./.;
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out
    cp $src/data $out
  '';
};