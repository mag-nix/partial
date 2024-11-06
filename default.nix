{ }:
let
  pkgs = import (builtins.fetchTarball {
    name = "nixos-unstable";
    url = "https://github.com/nixos/nixpkgs/archive/4aa36568d413aca0ea84a1684d2d46f55dbabad7.tar.gz";
    sha256 = "sha256-Zwl8YgTVJTEum+L+0zVAWvXAGbWAuXHax3KzuejaDyo=";
  }) { system = "x86_64-linux"; };
  upstream = builtins.fetchTarball {
    name = "upstream-repo";
    url = "https://github.com/mag-nix/partial/archive/fba7f70561170bc23aec240a4fe94dab4eb152d2.tar.gz";
    sha256 = "sha256-lUQQiYPuI2mWqnCT/foZWylrrpuUjYQY7GKlTzkn6ZY=";
  };
in
{
  inherit upstream;
  packages = rec {
  a = pkgs.callPackage (if builtins.pathExists ./a then ./a else upstream + "/a") { };
  b = pkgs.callPackage (if builtins.pathExists ./b then ./b else upstream + "/b") { };
  c = pkgs.callPackage (if builtins.pathExists ./c then ./c else upstream + "/c") { };
  abc = pkgs.callPackage (if builtins.pathExists ./abc then ./abc else upstream + "/abc") {
    # not necessary not proper yet
    a = a;
    b = b;
    c = c;
  };
  };
}
