import 'dart:ui';

class SmeupDeviceInfo {
  double physicalWidth;
  double physicalHeight;
  double safeWidth;
  double safeHeight;
  WindowPadding padding;
  SmeupDeviceInfo(this.padding, this.physicalHeight, this.physicalWidth,
      this.safeHeight, this.safeWidth);
}
