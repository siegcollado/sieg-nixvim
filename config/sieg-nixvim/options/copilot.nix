{ lib, ... }:
{
  options.sieg-nixvim.copilot.tokenEncryption = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Encrypt Copilot's cached authentication token using the system keyring.";
  };
}
