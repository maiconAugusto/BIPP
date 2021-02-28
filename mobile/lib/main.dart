import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blueGrey[900]),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Produtos'),
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
