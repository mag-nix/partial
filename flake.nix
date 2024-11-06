{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    pkgs = import nixpkgs { system = "x86_64-linux"; };

    packages.x86_64-linux = {
      a = self.pkgs.callPackage ./a { };
      b = self.pkgs.callPackage ./b { };
      c = self.pkgs.callPackage ./c { };
    };

    packages.x86_64-linux.default = self.packages.x86_64-linux.a;

  };
}
