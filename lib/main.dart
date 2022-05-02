import 'package:flutter/material.dart';
import 'presentation/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Code Scanner',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: const HomePage(),
  ));
}
