{ nixpkgs ? import <nixpkgs> {  } }:
let
  pkgs = nixpkgs;
  upstream = null;
in
{
  packages = rec {
  a = if builtins.pathExists ./a then pkgs.callPackage ./a { } else upstream.a;
  b = if builtins.pathExists ./b then pkgs.callPackage ./b { } else upstream.b;
  c = if builtins.pathExists ./c then pkgs.callPackage ./c { } else upstream.c;
  abc = if builtins.pathExists ./abc then pkgs.callPackage ./abc {
    a = a;
    b = b;
    c = c;
  } else upstream.abc;
  };
}
