{ stdenv }:

stdenv.mkDerivation {
  name = "data-c";
  src = ./.;
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out
    cp $src/datc $out
  '';
}