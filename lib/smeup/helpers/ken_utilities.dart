// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/ken_device_info.dart';

class KenUtilities {
  static KenDeviceInfo getDeviceInfo() {
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

    var smeupDeviceInfo = KenDeviceInfo(
        padding, physicalHeight, physicalWidth, safeHeight, safeWidth);

    return smeupDeviceInfo;
  }

  static String getMessageBusId(
      String? shiroId, GlobalKey<ScaffoldState>? formKey) {
    String? newId = formKey != null ? '${formKey.hashCode}_$shiroId' : shiroId;
    return newId ?? '';
  }
}
