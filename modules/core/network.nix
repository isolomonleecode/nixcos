{
  pkgs,
  host,
  options,
  ...
}: {
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
        8080
        9943
        9942
        8082
      ];
      allowedUDPPorts = [
        59010
        59011
        9944
        11111
        9942
        8082
      ];
      allowedUDPPortRanges = [
    { from = 20000; to = 30000; }
      ];
    };
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet];
}
