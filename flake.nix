{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    upstream.url = "github:mag-nix/partial?ref=main";
  };
  outputs = { self, nixpkgs, upstream }:
  let
    system = "x86_64-linux";
  in
  {
    inherit system;
    pkgs = import nixpkgs { inherit system; };

    packages.x86_64-linux = {
      a = if builtins.pathExists ./a then self.pkgs.callPackage ./a { } else self.pkgs.callPackage (upstream + "/a") { }; # renamed z so upstream is used
      b = if builtins.pathExists ./b then self.pkgs.callPackage ./b { } else self.pkgs.callPackage (upstream + "/b") { };
      c = if builtins.pathExists ./c then self.pkgs.callPackage ./c { } else self.pkgs.callPackage (upstream + "/c") { };
      abc = if builtins.pathExists ./abc then self.pkgs.callPackage ./abc {
        a = self.packages.x86_64-linux.a;
        b = self.packages.x86_64-linux.b;
        c = self.packages.x86_64-linux.c;
      } else self.pkgs.callPackage (upstream + "/abc") {
        a = self.packages.x86_64-linux.a;
        b = self.packages.x86_64-linux.b;
        c = self.packages.x86_64-linux.c;
      };
    };

    packages.x86_64-linux.default = self.packages.x86_64-linux.abc;

  };
}
