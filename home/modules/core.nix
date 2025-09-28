{
  username,
  dir,
  stateVersion,
  ...
}:
{
  home.username = username;
  home.homeDirectory = dir;
  home.stateVersion = stateVersion;
}
