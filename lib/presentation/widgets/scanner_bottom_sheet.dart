import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerBottomSheet extends StatefulWidget {
  const ScannerBottomSheet({
    Key? key,
    required this.onScan,
  }) : super(key: key);

  final Function(String) onScan;

  @override
  State<ScannerBottomSheet> createState() => _ScannerBottomSheetState();
}

class _ScannerBottomSheetState extends State<ScannerBottomSheet> {
  final Rx<Icon> _icon = const Icon(Icons.qr_code_2,
          key: Key("defaultIcon"), color: Colors.black54)
      .obs;

  void _runTimer() async {
    _icon.value = const Icon(Icons.check,
        key: Key("completeIcon"), color: Colors.black54);

    await Future.delayed(const Duration(seconds: 1)).then((_) => _icon.value =
        const Icon(Icons.qr_code_2,
            key: Key("defaultIcon"), color: Colors.black54));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const CloseButton(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Point to the BarCode/QrCode",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(width: 8.0),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _icon.value,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: MobileScanner(
                  allowDuplicates: false,
                  // fit: BoxFit.fill,
                  controller:
                      MobileScannerController(facing: CameraFacing.back),
                  onDetect: (barcode, _) {
                    final code = barcode.rawValue;

                    if (code != null) {
                      widget.onScan(code);
                      _runTimer();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
