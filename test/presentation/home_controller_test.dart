import 'package:flutter_test/flutter_test.dart';
import 'package:shippify/presentation/home_controller.dart';

void main() {
  late HomeController _controller;

  setUp((() {
    _controller = HomeController();
  }));

  group(
    HomeController,
    () {
      test(
        'onAddCode function shouldn`t add empty codes',
        () async {
          // ARRANGE
          final initialListLenght = _controller.codeList.length;

          // ACT
          _controller.addCode("");

          // ASSERT
          expect(_controller.codeList.length, equals(initialListLenght));
        },
      );

      test(
        'onAddCode function should add not empty codes',
        () async {
          // ARRANGE
          final initialListLenght = _controller.codeList.length;
          const _testCode = '123456789';

          // ACT
          _controller.addCode(_testCode);

          // ASSERT
          expect(_controller.codeList.length, equals(initialListLenght + 1));
          expect(_controller.codeList, contains(_testCode));
        },
      );

      test(
        'onRemoveCode function shouldn\'t remove empty codes',
        () async {
          // ARRANGE
          _controller.addCode("987654321");
          _controller.addCode("123456789");
          final initialListLenght = _controller.codeList.length;

          // ACT
          _controller.removeCode("");

          // ASSERT
          expect(_controller.codeList.length, equals(initialListLenght));
        },
      );

      test(
        'onRemoveCode function should remove not empty codes',
        () async {
          // ARRANGE
          const _testCode = '123456789';
          _controller.addCode("987654321");
          _controller.addCode(_testCode);
          final initialListLenght = _controller.codeList.length;

          // ACT
          _controller.removeCode(_testCode);

          // ASSERT
          expect(_controller.codeList.length, equals(initialListLenght - 1));
          expect(_controller.codeList, isNot(contains(_testCode)));
        },
      );
    },
  );
}
