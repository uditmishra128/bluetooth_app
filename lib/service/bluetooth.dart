import 'package:flutter/cupertino.dart';

import 'package:flutter_blue/flutter_blue.dart';

class BlueToothService extends ChangeNotifier {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  void startScanning() {
    // Start scanning
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    var subscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });
    // Stop scanning
    flutterBlue.stopScan();
  }
}
