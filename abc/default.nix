{ stdenv, a, b, c }:

stdenv.mkDerivation {
  name = "data-abc";
  src = ./.;
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out/{a,b,c}
    cp -r ${a}/* $out/a
    cp -r ${b}/* $out/b
    cp -r ${c}/* $out/c
  '';
}