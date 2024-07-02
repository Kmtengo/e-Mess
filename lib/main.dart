import 'package:flutter/material.dart';

// The main function is the starting point for all our Flutter apps.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4,
        vsync:
            this); // You can change the length as per the number of tabs you have
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                      color: Colors.deepOrange,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.tealAccent,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.qr_code_scanner_rounded,
                          color: Colors.deepOrange, size: 30.0),
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
                      ),
                      TabBar(
                        indicatorColor: Colors.teal,
                        labelColor: Colors.deepOrange,
                        labelStyle: const TextStyle(
                            fontFamily: 'TiltNeon',
                            fontWeight: FontWeight.bold),
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'Breakfast'),
                          Tab(text: '  Lunch  '),
                          Tab(text: '4pm Tea'),
                          Tab(text: 'Supper')
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            // Breakfast GridView/Tab
                            GridView.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 5.0,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/tea.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Tea',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 15',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                  'images/bread1.jpg',
                                                  height: 30.0),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Bread',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 12',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/eggs.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Eggs',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 20',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/mandazi.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Mandazi',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 15',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/coffee.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Coffee',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 25',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/toast.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Toast',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 15',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Lunch GridView/Tab
                            GridView.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/ugali.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Ugali',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 20',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/rice.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Rice',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 30',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/ndengu.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Ndengu',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 40',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/madondo.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Madondo',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 45',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/beef.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Beef Stew',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 70',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/cabbage.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Cabbage',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 20',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/sukuma.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Sukuma',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 30',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/matumbo1.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Matumbo',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 65',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/pilau1.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Pilau',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 60',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),

                            // 4pm Tea GridView/Tab
                            GridView.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/tea.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Tea',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 15',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/coffee.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Coffee',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 25',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/bread1.jpg',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Bread',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 12',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/eggs.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Eggs',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 20',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/mandazi.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Mandazi',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 15',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/toast.png',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Toast',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh. 15',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),

                            // Supper GridView/Tab
                            GridView.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/tea.jpg',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Tea',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh.15.0',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/tea.jpg',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Tea',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh.15.0',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/tea.jpg',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Tea',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh.15.0',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/tea.jpg',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Tea',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh.15.0',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/tea.jpg',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Tea',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh.15.0',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/tea.jpg',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Tea',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh.15.0',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/tea.jpg',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Tea',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh.15.0',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/tea.jpg',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Tea',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh.15.0',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.zero, // Set padding to zero
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 90.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: Image.asset(
                                                'images/tea.jpg',
                                                height: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 16.0, 0.0),
                                                child: Text(
                                                  'Tea',
                                                  style: TextStyle(
                                                    fontFamily: 'DancingScript',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 0.0, 16.0, 0.0),
                                              child: Text(
                                                'Ksh.15.0',
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8.5),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
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
