import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

Future<String>  generateDeviceId() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
   if (Platform.isAndroid) {
    AndroidDeviceInfo info = await deviceInfo.androidInfo;
    info.id;
  } else if (Platform.isWindows) {
    WindowsDeviceInfo info = await deviceInfo.windowsInfo;
    return info.deviceId;
  }else{
    return generateUUID();
  }
  return 'Unknown Device';
}


String generateUUID() {

  const uuid = Uuid();
  return uuid.v7();
}
