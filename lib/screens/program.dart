import 'package:bluetooth_app/utils/constants.dart';
import 'package:bluetooth_app/widget/blue_tooth_device_tile.dart';
import 'package:bluetooth_app/widget/glassy_btn.dart';
import 'package:bluetooth_app/widget/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgramScreen extends StatefulWidget {
  static const String routeName = '/program';

  const ProgramScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  String stateText = "Disconnected";
  FlutterBlue flutterBlue = FlutterBlue.instance;
  double value = 30;
  List<ScanResult> scanResultList = [];
  bool _isScanning = false;
  final style = GoogleFonts.poppins(fontSize: 15, color: Colors.white);
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Image.asset(
              Constants().carImage,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GlassyButton(
                            title: 'BlueTooth',
                            onTap: () {
                              startScan();
                            }),
                        Expanded(child: _connectionStatus()),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: scanResultList.length,
                        itemBuilder: (context, index) => DeviceTile(
                            r: scanResultList[index],
                            onTap: (r) {
                              connect(r.device);
                            })),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Reset réglage d'usine :",
                          style: style,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GlassyButton(title: ' OK ', onTap: () {}),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Réglage : ${value.toInt()}',
                        style: style,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomSlider(
                      value: value,
                      onValueChange: (value) {
                        setState(() {
                          this.value = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Envoyer le réglage',
                          style: style,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: GlassyButton(title: ' OK ', onTap: () {}),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Boitier activé',
                          style: style,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: GlassyButton(
                            title: ' Non ',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GlassyButton(title: 'Fermer', onTap: () {}),
                        const SizedBox(
                          width: 20,
                        ),
                        GlassyButton(title: 'Config', onTap: () {}),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _connectionStatus() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.grey,
                Colors.black,
              ]),
          border: Border.all(color: Colors.black, width: .5)),
      padding: const EdgeInsets.all(5),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: stateText != 'Connected' ? Colors.grey : Colors.red),
          child: Center(child: Text(stateText))),
    );
  }

  startScan() async {
    if (!_isScanning) {
      _isScanning = true;
      scanResultList.clear();

      flutterBlue.startScan(timeout: const Duration(seconds: 10));
      flutterBlue.scanResults.listen((results) {
        scanResultList = results;
        setState(() {});
      });
    } else {
      _isScanning = false;
      flutterBlue.stopScan();
    }
  }

  setBleConnectionState(BluetoothDeviceState event) {
    switch (event) {
      case BluetoothDeviceState.disconnected:
        stateText = 'Disconnected';
        break;
      case BluetoothDeviceState.disconnecting:
        stateText = 'Disconnecting';
        break;
      case BluetoothDeviceState.connected:
        stateText = 'Connected';
        break;
      case BluetoothDeviceState.connecting:
        stateText = 'Connecting';
        break;
    }
    deviceState = event;
    setState(() {});
  }

  Future<bool> connect(BluetoothDevice device) async {
    Future<bool>? returnValue;
    setState(() {
      stateText = 'Connecting';
    });

    await device.connect(autoConnect: false).timeout(const Duration(seconds: 5),
        onTimeout: () {
      returnValue = Future.value(false);
      debugPrint('timeout failed');
      setBleConnectionState(BluetoothDeviceState.disconnected);
    }).then((data) {
      if (returnValue == null) {
        debugPrint('connection successful');
        returnValue = Future.value(true);
      }
    });

    return returnValue ?? Future.value(false);
  }

  void disconnect(BluetoothDevice device) {
    try {
      setState(() {
        stateText = 'Disconnecting';
      });
      device.disconnect();
    } catch (e) {}
  }
}
