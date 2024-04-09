import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// The main function is the starting point for all our Flutter apps.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
          builder: (context) => Scaffold(
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
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      );
                    },
                  ),
                  title: const Text(
                    "e-Mess",
                    style: TextStyle(
                      fontFamily: 'BungeeSpice',
                      color: Colors.deepOrangeAccent,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.tealAccent,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.qr_code_scanner_rounded,
                          color: Colors.deepOrangeAccent, size: 30.0),
                      tooltip: 'scan QR Code',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Scan QR Code'),
                              content: const Text(
                                  'You have selected to scan a QR code.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
                body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10.0),
                        child: LinearProgressIndicator(
                          value: 0.25,
                          minHeight: 8.0,
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )
                    ],
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
              )),
    );
  }
}
