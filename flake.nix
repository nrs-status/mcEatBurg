{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/d6524aaca2ff07876657ae2b323f24be4874944b";
    peachRampSkateboard.url = "github:nrs-status/newPeachRampSkateboard";
  };

  outputs =
    inputs:
    let
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      baseLib = inputs.peachRampSkateboard.baseLib;
      pkgsLib = inputs.peachRampSkateboard.pkgsLib;
      localPkgsArgs = { inherit baseLib pkgsLib; };
      inductedPkgs = pkgsLib.fix (self: import ./colossusRhodes (localPkgsArgs // { localPkgs = self; }));

    in
    {
      packages = inductedPkgs;
      inherit pkgs;
      nixpkgs = inputs.nixpkgs;
    };
}
