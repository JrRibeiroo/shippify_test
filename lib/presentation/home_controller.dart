import 'package:get/get.dart';

class HomeController {
  final _codeList = RxList<String>([]);

  List<String> get codeList => _codeList;

  void addCode(String value) => value.isNotEmpty ? _codeList.add(value) : null;
  void removeCode(String value) =>
      value.isNotEmpty ? _codeList.remove(value) : null;
}
