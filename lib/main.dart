import 'dart:ui';

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
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.deepOrangeAccent,
                  size: 30.0,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: const Text(
            "e-Mess",
            style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.tealAccent,
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
          ),
        ),
        drawer: const Drawer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('This is the Drawer'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
