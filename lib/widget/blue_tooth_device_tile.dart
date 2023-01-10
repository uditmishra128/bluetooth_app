import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:google_fonts/google_fonts.dart';

class DeviceTile extends StatelessWidget {
  final ScanResult r;
  final Function(ScanResult) onTap;
  const DeviceTile({super.key, required this.r, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.poppins(fontSize: 15, color: Colors.white);
    Widget deviceSignal(ScanResult r) {
      return Text(
        r.rssi.toString(),
        style: style,
      );
    }

    Widget deviceMacAddress(ScanResult r) {
      return Text(
        r.device.id.id,
        style: style,
      );
    }

    /* 장치의 명 위젯  */
    Widget deviceName(ScanResult r) {
      String name = '';

      if (r.device.name.isNotEmpty) {
        name = r.device.name;
      } else if (r.advertisementData.localName.isNotEmpty) {
        name = r.advertisementData.localName;
      } else {
        name = 'N/A';
      }
      return Text(
        name,
        style: style,
      );
    }

    /* BLE 아이콘 위젯 */
    Widget leading(ScanResult r) {
      return const CircleAvatar(
        backgroundColor: Colors.cyan,
        child: Icon(
          Icons.bluetooth,
          color: Colors.white,
        ),
      );
    }

    return Material(
      color: Colors.black,
      child: ListTile(
        tileColor: Colors.black,
        onTap: () => onTap(r),
        title: deviceName(r),
        subtitle: deviceMacAddress(r),
        trailing: deviceSignal(r),
      ),
    );
  }
}
