import 'package:flutter/material.dart';

// The main function is the starting point for all our Flutter apps.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("e-Mess"),
          centerTitle: true,
          backgroundColor: Colors.tealAccent,
        ),
        body: Container(),
      ),
    );
  }
}
