import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
import 'widgets/code_item_widget.dart';
import 'widgets/scanner_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("Code Scanner"),
        ),
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: _controller.codeList.isEmpty
                ? Center(
                    child: Column(
                      key: const Key("emptyColumn"),
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.clear_all,
                          size: 80,
                          color: Colors.black26,
                        ),
                        Text(
                          "No codes read",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black26,
                          ),
                        )
                      ],
                    ),
                  )
                : Column(
                    key: const Key("filledColumn"),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemCount: _controller.codeList.length,
                          itemBuilder: (_, index) => CodeItem(
                            title: _controller.codeList[index],
                            onDelete: _controller.removeCode,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Scan"),
          icon: const Icon(Icons.qr_code_scanner),
          onPressed: () => showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            builder: (_) => ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .5),
              child: ScannerBottomSheet(onScan: _controller.addCode),
            ),
          ),
        ),
      ),
    );
  }
}
