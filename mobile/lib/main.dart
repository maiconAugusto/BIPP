import 'package:flutter/material.dart';
import 'package:mobile/src/screens/home/index.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListProduct(),
    );
  }
}
