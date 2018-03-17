with (import <nixpkgs> {});
let
  node = nodejs-8_x;
  elixir = elixir_1_6;
in stdenv.mkDerivation {
  name = "my_node_app";
  buildInputs = [
    node
    postgresql
    elixir
  ];
}
