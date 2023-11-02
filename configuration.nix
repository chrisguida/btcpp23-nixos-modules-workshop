# This file is imported by vm.nix and rebuild.nix. Declare services here.

# This module is a function with the following arguments:
{
  pkgs, # nixpkgs
  modulesPath, # the path to the NixOS modules
  config, # the current system configuration
  ...
}:
let
  yourAppPort = 4242;
in
{
  imports = [
    # imports the your_app module
    ./modules/your_app
  ];

  ## Task 1
  services.bitcoind."regtest" = {
    enable = true;
    rpc = {
      port = 18444;
      users.workshop = {
        name = "workshop";
        # hashed password can be generated with https://github.com/bitcoin/bitcoin/blob/master/share/rpcauth/rpcauth.py
        # or https://jlopp.github.io/bitcoin-core-rpc-auth-generator/
        # Here, the password is "btcpp23berlin".
        passwordHMAC = "261106eacc7b4ff02628fbda556d65ec$bdc62ae101fbe7948c44b5475e2b56d046e326ce5d4f81b55e0861a66801226b";
      };
    };
    extraConfig = ''
      regtest=1
    '';
  };

  services.your_app = {
    # FIXME: Task 2.3: declare the options your_app options defined in 2.1
    # Use `yourAppPort` as port.
    port = 4242;
    enable = true;
    rpc = {
      port = config.services.bitcoind."regtest".rpc.port;
      host = "localhost";
      pass = "btcpp23berlin";
      user = "workshop";
    };
  };

  # FIXME: 2.4: Open the firewall
  networking.firewall.allowedTCPPorts = [ 4242 ];

  # Task 4
  virtualisation.oci-containers.containers = {
    #"plaintext-hello" = {your
      # FIXME: Task 4.2: declare `image` and `ports` options
    #};
  };

  # FIXME: Task 4.3: empty NixOS container
}
