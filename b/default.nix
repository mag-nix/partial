{ stdenv }:

stdenv.mkDerivation {
  name = "data-b";
  src = ./.;
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out
    cp $src/data $out
  '';
}