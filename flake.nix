{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    upstream.url = "github:mag-nix/partial?ref=main";
    upstream.inputs.nixpkgs.follows = "nixpkgs";
    upstream.inputs.upstream.follows = "nixpkgs"; # Stop recursion at the first level
  };
  outputs = { self, nixpkgs, upstream }:
  let
    system = "x86_64-linux";
    up = if builtins.pathExists ./local then upstream else null;
  in
  {
    inherit system;
    pkgs = import nixpkgs { inherit system; };

    packages.x86_64-linux = {
      a = self.pkgs.callPackage (if builtins.pathExists ./a then ./a else up + "/a") { };
      b = self.pkgs.callPackage (if builtins.pathExists ./b then ./b else up + "/b") { };
      c = self.pkgs.callPackage (if builtins.pathExists ./c then ./c else up + "/c") { };
      abc = self.pkgs.callPackage (if builtins.pathExists ./abc then ./abc else up + "/abc") {
        a = self.packages.x86_64-linux.a;
        b = self.packages.x86_64-linux.b;
        c = self.packages.x86_64-linux.c;
      };
    };

    packages.x86_64-linux.default = self.packages.x86_64-linux.abc;

  };
}
