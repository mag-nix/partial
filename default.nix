{ }:
let
  pkgs = import (builtins.fetchTarball {
    name = "nixos-unstable";
    url = "https://github.com/nixos/nixpkgs/archive/4aa36568d413aca0ea84a1684d2d46f55dbabad7.tar.gz";
    sha256 = "sha256-Zwl8YgTVJTEum+L+0zVAWvXAGbWAuXHax3KzuejaDyo=";
  }) {};
  upstream = import (builtins.fetchTarball {
    name = "upstream-repo";
    url = "https://github.com/mag-nix/partial/archive/08beac640a63e2ac4ca40a8fdf72ce52dbf0e442.tar.gz";
    sha256 = "sha256:0lsygcnvdzmvdnk6jl4rh429iswasvlx1768l1yny1732pnbqm2a";
  }) {};
in
{
  packages = rec {
  a = if builtins.pathExists ./a then pkgs.callPackage ./a { } else upstream.packages.a; # renamed z so upstream is used
  b = if builtins.pathExists ./b then pkgs.callPackage ./b { } else upstream.packages.b;
  c = if builtins.pathExists ./c then pkgs.callPackage ./c { } else upstream.packages.c;
  abc = if builtins.pathExists ./abc then pkgs.callPackage ./abc {
    a = a;
    b = b;
    c = c;
  } else upstream.packages.abc;
  };
}
