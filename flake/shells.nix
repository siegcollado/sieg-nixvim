{ siegLib, ... }:
{
  perSystem =
    { system, ... }:
    let
      pkgs = siegLib.mkPkgs system;
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [ statix ];
      };
    };
}
