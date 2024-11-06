{ stdenv, a, b, c }:

stdenv.mkDerivation {
  name = "data-abc";
  src = ./.;
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out/{a,b,c}
    cp ${a}/data $out/a
    cp ${b}/datb $out/b
    cp ${c}/datc $out/c
  '';
}