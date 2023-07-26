import '../constants/constants.dart';

enum PlatformAsset {
  android(Labels.android, Assets.androidIcon),
  apple(Labels.apple, Assets.macIcon),
  atari(Labels.atari, Assets.atariIcon),
  gameboy(Labels.gameBoy, Assets.gameBoyIcon),
  gamecube(Labels.gamecube, Assets.gamecubeIcon),
  ios(Labels.iOS, Assets.iOSIcon),
  linux(Labels.linux, Assets.linuxIcon),
  macintosh(Labels.macintosh, Assets.macIcon),
  macos(Labels.macos, Assets.macIcon),
  nes(Labels.nes, Assets.nintendoIcon),
  nswitch(Labels.nintendoSwitch, Assets.switchIcon),
  nintendo(Labels.nintendo, Assets.nintendoIcon),
  pc(Labels.pc, Assets.windowsIcon),
  playstation3(Labels.playstation3, Assets.ps3Icon),
  playstation4(Labels.playstation4, Assets.ps4Icon),
  playstation5(Labels.playstation5, Assets.ps5Icon),
  playstation(Labels.playstation, Assets.playstationIcon),
  psvita(Labels.psVita, Assets.psVitaIcon),
  sega(Labels.sega, Assets.segaIcon),
  snes(Labels.snes, Assets.snesIcon),
  wiiu(Labels.wiiU, Assets.wiiUIcon),
  wii(Labels.wii, Assets.wiiIcon),
  windows(Labels.windows, Assets.windowsIcon),
  xbox(Labels.xbox, Assets.xboxIcon);

  const PlatformAsset(
    this.name,
    this.path,
  );

  final String name;
  final String path;
}
