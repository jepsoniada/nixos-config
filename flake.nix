{
   inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
   outputs = { self, nixpkgs }: {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
         modules = [({ pkgs, ... }: {
            imports = [ /etc/nixos/hardware-configuration.nix ];

            nix.settings.experimental-features = [
               "nix-command"
               "flakes"
            ];

            services.openssh.enable = true;

            users.users.jepson = {
               isNormalUser = true;
               home = "/home/jepson";
               extraGroups = ["wheel"];
            };

            boot.loader.grub.enable = true;
            boot.loader.grub.device = "/dev/sda";
            system.stateVersion = "23.05";
         })];
      };
   };
}
