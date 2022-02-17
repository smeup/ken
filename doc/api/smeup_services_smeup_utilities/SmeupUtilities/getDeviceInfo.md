


# getDeviceInfo method








[SmeupDeviceInfo](../../smeup_models_smeup_device_info/SmeupDeviceInfo-class.md) getDeviceInfo
()








## Implementation

```dart
static SmeupDeviceInfo getDeviceInfo() {
  var pixelRatio = window.devicePixelRatio;

  //Size in physical pixels
  var physicalScreenSize = window.physicalSize;
  var physicalWidth = physicalScreenSize.width;
  var physicalHeight = physicalScreenSize.height;

  //Size in logical pixels
  var logicalScreenSize = window.physicalSize / pixelRatio;
  var logicalWidth = logicalScreenSize.width;
  var logicalHeight = logicalScreenSize.height;

  //Padding in physical pixels
  var padding = window.padding;

  //Safe area paddings in logical pixels
  var paddingLeft = window.padding.left / window.devicePixelRatio;
  var paddingRight = window.padding.right / window.devicePixelRatio;
  var paddingTop = window.padding.top / window.devicePixelRatio;
  var paddingBottom = window.padding.bottom / window.devicePixelRatio;

  //Safe area in logical pixels
  var safeWidth = logicalWidth - paddingLeft - paddingRight;
  var safeHeight = logicalHeight - paddingTop - paddingBottom;

  var smeupDeviceInfo = SmeupDeviceInfo(
      padding, physicalHeight, physicalWidth, safeHeight, safeWidth);

  return smeupDeviceInfo;
}
```







