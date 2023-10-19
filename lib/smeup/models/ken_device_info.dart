import 'dart:ui';

class KenDeviceInfo {
  double physicalWidth;
  double physicalHeight;
  double safeWidth;
  double safeHeight;
  ViewPadding padding;
  KenDeviceInfo(this.padding, this.physicalHeight, this.physicalWidth,
      this.safeHeight, this.safeWidth);
}
