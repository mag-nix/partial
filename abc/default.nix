{ stdenv, a, b, c }:

stdenv.mkDerivation {
  name = "data-abc";
  src = ./.;
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out/{a,b,c}
    cp ${a}/out/data $out/a
    cp ${b}/out/data $out/b
    cp ${c}/out/data $out/c
  '';
}